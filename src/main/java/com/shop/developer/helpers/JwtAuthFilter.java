package com.shop.developer.helpers;
import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import com.shop.developer.modules.users.services.impl.CustomDetailUserService;
import com.shop.developer.services.JWTService;

import io.micrometer.common.lang.NonNull;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class JwtAuthFilter extends OncePerRequestFilter{
    private final JWTService jwtService;
    private final CustomDetailUserService customDetailUserService;
    private static final Logger logger = LoggerFactory.getLogger(JwtAuthFilter.class);
    

    @Override
    public void doFilterInternal(
        @NonNull HttpServletRequest request, 
        @NonNull HttpServletResponse response, 
        @NonNull FilterChain filterChain)
    throws ServletException, IOException {

        final String authHeader = request.getHeader("Authorization");
        final String jwt;
        final String userId;
        if(authHeader == null || !authHeader.startsWith("Bearer")) {
            logger.error("test"); //log lỗi ra từ token
            filterChain.doFilter(request, response);
            return;
        }
        jwt = authHeader.substring(7);
        userId = jwtService.getUserIdFromJwt(jwt);
        if(userId !=  null && SecurityContextHolder.getContext().getAuthentication() == null) {
            UserDetails userDetails = customDetailUserService.loadUserByUsername(userId);
            logger.info(userDetails.getUsername());
            
        }


      filterChain.doFilter(request, response);
    }

}
