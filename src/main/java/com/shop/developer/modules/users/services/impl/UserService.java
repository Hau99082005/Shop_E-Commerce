package com.shop.developer.modules.users.services.impl;
import com.shop.developer.modules.users.request.LoginRequest;
import com.shop.developer.modules.users.resources.LoginResources;
import com.shop.developer.modules.users.resources.UserResources;

import org.springframework.stereotype.Service;

import com.shop.developer.modules.users.services.interfaces.UserServicesInterface;
import com.shop.developer.services.BaseService;


@Service
public class UserService extends BaseService implements UserServicesInterface{

    @Override
    public LoginResources login(LoginRequest request) {
        try {
//            String email = request.getEmail();
//            String password = request.getPassword();
            String token = "random_token";
            UserResources user = new UserResources(1L, "hau22082005@gmail.com");
            return new LoginResources(token, user);
           

        }catch(Exception e) {
            throw new RuntimeException("Đã có vẫn đề xảy ra!");
        }
    }
}
