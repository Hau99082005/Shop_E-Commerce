package com.shop.developer.modules.users.services.impl;
import com.shop.developer.modules.users.dtos.LoginRequest;
import com.shop.developer.modules.users.dtos.LoginResponse;
import com.shop.developer.modules.users.dtos.UserDTO;
import org.springframework.stereotype.Service;

import com.shop.developer.modules.users.services.interfaces.UserServicesInterface;
import com.shop.developer.services.BaseService;


@Service
public class UserService extends BaseService implements UserServicesInterface{

    @Override
    public LoginResponse login(LoginRequest request) {
        try {
//            String email = request.getEmail();
//            String password = request.getPassword();
            String token = "random_token";
            UserDTO user = new UserDTO(1L, "hau22082005@gmail.com");
            return new LoginResponse(token, user);


        }catch(Exception e) {
            throw new RuntimeException("Đã có vẫn đề xảy ra!");
        }
    }
}
