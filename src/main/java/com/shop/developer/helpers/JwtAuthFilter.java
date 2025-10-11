package com.shop.developer.helpers;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.util.Date;

import javax.crypto.spec.SecretKeySpec;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.web.filter.OncePerRequestFilter;

import com.shop.developer.modules.users.services.impl.CustomDetailUserService;
import com.shop.developer.services.JWTService;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.micrometer.common.lang.NonNull;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

// @Component - Tạm thời disable để tập trung vào MVC demo
@RequiredArgsConstructor
public class JwtAuthFilter extends OncePerRequestFilter {

    private final JWTService jwtService;
    private final CustomDetailUserService customDetailUserService;
    private static final Logger logger = LoggerFactory.getLogger(JwtAuthFilter.class);

    @Override
    protected void doFilterInternal(
            @NonNull HttpServletRequest request,
            @NonNull HttpServletResponse response,
            @NonNull FilterChain filterChain)
            throws ServletException, IOException {

        final String authHeader = request.getHeader("Authorization");
        final String jwt;
        final String userId;

        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            filterChain.doFilter(request, response);
            return;
        }

        jwt = authHeader.substring(7).trim();
        userId = jwtService.getUserIdFromJwt(jwt);

        if (userId != null && SecurityContextHolder.getContext().getAuthentication() == null) {
            try {
                UserDetails userDetails = customDetailUserService.loadUserByUsername(userId);

                if (isValidToken(jwt, userDetails)) {
                    UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
                            userDetails, null, userDetails.getAuthorities());
                    authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                    SecurityContextHolder.getContext().setAuthentication(authToken);
                    logger.info("Xác thực thành công: {}", userDetails.getUsername());
                } else {
                    logger.warn("Token không hợp lệ hoặc đã hết hạn cho userId: {}", userId);
                }
            } catch (Exception e) {
                logger.error("Lỗi khi xác thực user từ token: {}", e.getMessage());
            }
        }

        filterChain.doFilter(request, response);
    }

    /* 
     1. Token có đúng định dạng không
     2. Chữ ký của token có đúng không
     3. Kiểm tra xem token đã hết hạn hay chưa
     4. user_id/username của token có khớp với userDetails 
     5. (Có thể thêm) kiểm tra blacklist, quyền, v.v.
    */
    public boolean isValidToken(String token, UserDetails userDetails) {
        try {
            if (!isTokenFormatValid(token)) {
                logger.error("Token không đúng định dạng!");
                return false;
            }

            if (!isSignatureValid(token)) {
                logger.error("Chữ ký token không hợp lệ!");
                return false;
            }

            if (isTokenExpired(token)) {
                logger.error("Token đã hết hạn!");
                return false;
            }

            String usernameFromToken = extractUsername(token);
            if (usernameFromToken == null || !usernameFromToken.equals(userDetails.getUsername())) {
                logger.error("Token không khớp với user hiện tại!");
                return false;
            }

            return true;
        } catch (Exception e) {
            logger.error("Xác thực token thất bại: {}", e.getMessage());
            return false;
        }
    }

    private boolean isTokenFormatValid(String token) {
        try {
            String[] tokenParts = token.split("\\.");
            return tokenParts.length == 3;
        } catch (Exception e) {
            return false;
        }
    }

    private boolean isSignatureValid(String token) {
        try {
            // Nếu parse thành công thì chữ ký hợp lệ
            extractAllClaims(token);
            return true;
        } catch (Exception e) {
            logger.error("isSignatureValid error: {}", e.getMessage());
            return false;
        }
    }

    private boolean isTokenExpired(String token) {
        try {
            final Date expiration = extractAllClaims(token).getExpiration();
            return expiration.before(new Date());
        } catch (Exception e) {
            logger.error("isTokenExpired error: {}", e.getMessage());
            // Nếu không parse được claims thì coi là không hợp lệ / đã hết hạn
            return true;
        }
    }

    private String extractUsername(String token) {
        try {
            Claims claims = extractAllClaims(token);
            return claims.getSubject();
        } catch (Exception e) {
            logger.error("extractUsername error: {}", e.getMessage());
            return null;
        }
    }

    private Claims extractAllClaims(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(getSigningKey())
                .build()
                .parseClaimsJws(token)
                .getBody();
    }

    /**
     * Fix: tạo key bằng SecretKeySpec để tránh phụ thuộc vào Keys.hmacShaKeyFor (phiên bản jjwt cũ)
     * Lưu ý: secret nên có độ dài >= 32 bytes (256 bits) cho HS256.
     */
    private Key getSigningKey() {
        // Chú ý dùng StandardCharsets.UTF_8 để không phụ thuộc vào charset mặc định hệ thống
        // Tạm thời sử dụng secret key cố định, sau này sẽ inject JwtConfig
        String secretKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImlhdCI6MTUxNjIzOTAyMn0.KMUFsIDTnFmyG3nMiGM6H9FNFUROf3wh7SmqJp-QV30";
        byte[] keyBytes = secretKey.getBytes(StandardCharsets.UTF_8);

        // Sử dụng thuật toán tương ứng với token (thường là HS256)
        String jcaAlg = SignatureAlgorithm.HS256.getJcaName();
        return new SecretKeySpec(keyBytes, jcaAlg);

        /*
         * Nếu bạn dùng jjwt >= 0.11.x và secret đã mã base64:
         * import io.jsonwebtoken.io.Decoders;
         * import io.jsonwebtoken.security.Keys;
         * byte[] keyBytes = Decoders.BASE64.decode(jwtBase64Secret);
         * return Keys.hmacShaKeyFor(keyBytes);
         */
    }
}
