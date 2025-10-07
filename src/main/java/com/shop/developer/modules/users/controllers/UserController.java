package com.shop.developer.modules.users.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.shop.developer.modules.users.models.User;
import com.shop.developer.modules.users.repositories.UserRepository;
import com.shop.developer.modules.users.resources.UserResources;
import com.shop.developer.resources.SuccessResource;

@RestController
@RequestMapping("login")
public class UserController { //quản lý thông tin người dùng

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/me")
    public ResponseEntity<?> me() {
        String email = "hau99082005@gmail.com";

        User user = userRepository.findByEmail(email).orElseThrow(() -> new RuntimeException("User not found!"));
        UserResources userResources = new UserResources(user.getId(), user.getEmail(), user.getName());
        SuccessResource<UserResources> response = new SuccessResource<>("SUCCESS", userResources);

        return ResponseEntity.ok(response);
    }
}
