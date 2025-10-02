package com.shop.developer.modules.users.services.interfaces;


import com.shop.developer.modules.users.request.LoginRequest;
import com.shop.developer.modules.users.resources.LoginResources;

public interface UserServicesInterface {

    LoginResources login(LoginRequest request);
}
