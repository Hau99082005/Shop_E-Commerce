package com.shop.developer.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.shop.developer.helpers.JwtAuthFilter;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Configuration
public class SecurityConfig {

    private final JwtAuthFilter jwtAuthFilter;


    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
       http.csrf(csrf -> csrf.disable())
       .authorizeHttpRequests(auth -> auth.requestMatchers("/auth/login") //1. Routes Auth - No JWT
       .permitAll()
       //2.Routes PUBLIC
       .requestMatchers("/api/products").permitAll()
       .anyRequest().authenticated()
       )
       .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
       .addFilterBefore(jwtAuthFilter, UsernamePasswordAuthenticationFilter.class);
       return http.build();
    }
}
