package com.shop.developer.services;

import java.security.Key;
import java.util.Base64;
import java.util.Date;

import org.springframework.stereotype.Service;

import com.shop.developer.config.JwtConfig;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;

@Service
public class JWTService {
    private final JwtConfig jwtConfig;
    private final Key key;

    public JWTService(JwtConfig jwtConfig) {
         super();
         this.jwtConfig = jwtConfig;  // inject JwtConfig để lấy secretKey
         this.key = Keys.hmacShaKeyFor(Base64.getEncoder().encode(jwtConfig.getSecretKey().getBytes()));
         // sử dụng base64 để mã hoá chuỗi secretkey thành byte array
    }
    public String generateToken(Long userId, String email) {
       Date now = new Date();
       Date expiryDate = new Date(now.getTime() + jwtConfig.getExpirationTime()); 
       //lấy thời gian hiện tại cộng với thời gian hết hạn từ cấu hình jwtconfig
       return Jwts.builder()
           .setSubject(String.valueOf(userId))
           .claim("email", email)
           .setIssuedAt(now)
           .setExpiration(expiryDate)
           .signWith(key, SignatureAlgorithm.HS256)
           .compact();
           //sử dụng thuật toán HS256 để tạo token với key đã mã hoá 
           
    }
    
    
}
