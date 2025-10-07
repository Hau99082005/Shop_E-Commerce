package com.shop.developer.modules.users.services.interfaces;


import com.shop.developer.modules.users.request.LoginRequest;

public interface UserServicesInterface {

    Object authenticate(LoginRequest request);
}
