package com.shop.developer.modules.users.services.interfaces;


import com.shop.developer.modules.users.dtos.LoginRequest;
import com.shop.developer.modules.users.dtos.LoginResponse;

public interface UserServicesInterface {

    LoginResponse login(LoginRequest request);
}
