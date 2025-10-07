package com.shop.developer.modules.users.services.impl;
import java.util.Collections;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.shop.developer.modules.users.models.User;
import com.shop.developer.modules.users.repositories.UserRepository;

import lombok.RequiredArgsConstructor;

@Service 
@RequiredArgsConstructor
public class CustomDetailUserService implements UserDetailsService{
    private final UserRepository userRepository;


    @Override
    public UserDetails loadUserByUsername(String userId) 
    throws UsernameNotFoundException
    {
        User user = userRepository.findById(Long.valueOf(userId)).orElseThrow(() -> new UsernameNotFoundException("user not found"));
        return new org.springframework.security.core.userdetails.User(
            user.getEmail(),
            user.getPassword(),
            Collections.emptyList()
            );
    }
    
}
