package com.shop.developer.modules.users.services.interfaces;

import java.util.List;
import java.util.Optional;

import com.shop.developer.modules.users.models.User;
import com.shop.developer.modules.users.request.UserRequest;

public interface UserCrudService {
    List<User> getAllUsers();
    Optional<User> getUserById(Long id);
    User createUser(UserRequest userRequest);
    User updateUser(Long id, UserRequest userRequest);
    void deleteUser(Long id);
    Optional<User> getUserByEmail(String email);
}