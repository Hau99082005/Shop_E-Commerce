package com.shop.developer.controllers;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.shop.developer.modules.users.models.User;
import com.shop.developer.modules.users.request.UserRequest;
import com.shop.developer.modules.users.resources.UserResponse;
import com.shop.developer.modules.users.services.interfaces.UserCrudService;
import com.shop.developer.resources.ErrorResource;
import com.shop.developer.resources.SuccessResource;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/users")
@CrossOrigin(origins = "*")
@Validated
public class UserRestController {

    @Autowired
    private UserCrudService userCrudService;

    /**
     * GET /api/users - Lấy danh sách tất cả users
     */
    @GetMapping
    public ResponseEntity<?> getAllUsers() {
        try {
            List<User> users = userCrudService.getAllUsers();
            List<UserResponse> userResponses = users.stream()
                    .map(this::convertToResponse)
                    .collect(Collectors.toList());
            
            SuccessResource<List<UserResponse>> response = new SuccessResource<>(
                "Users retrieved successfully", userResponses);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            ErrorResource error = new ErrorResource("Failed to retrieve users: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(error);
        }
    }

    /**
     * GET /api/users/{id} - Lấy user theo ID
     */
    @GetMapping("/{id}")
    public ResponseEntity<?> getUserById(@PathVariable Long id) {
        try {
            User user = userCrudService.getUserById(id)
                    .orElseThrow(() -> new RuntimeException("User not found"));
            
            UserResponse userResponse = convertToResponse(user);
            SuccessResource<UserResponse> response = new SuccessResource<>(
                "User retrieved successfully", userResponse);
            return ResponseEntity.ok(response);
        } catch (RuntimeException e) {
            ErrorResource error = new ErrorResource(e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(error);
        } catch (Exception e) {
            ErrorResource error = new ErrorResource("Failed to retrieve user: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(error);
        }
    }

    /**
     * POST /api/users - Tạo user mới
     */
    @PostMapping
    public ResponseEntity<?> createUser(@Valid @RequestBody UserRequest userRequest) {
        try {
            User user = userCrudService.createUser(userRequest);
            UserResponse userResponse = convertToResponse(user);
            
            SuccessResource<UserResponse> response = new SuccessResource<>(
                "User created successfully", userResponse);
            return ResponseEntity.status(HttpStatus.CREATED).body(response);
        } catch (RuntimeException e) {
            ErrorResource error = new ErrorResource(e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(error);
        } catch (Exception e) {
            ErrorResource error = new ErrorResource("Failed to create user: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(error);
        }
    }

    /**
     * PUT /api/users/{id} - Cập nhật user
     */
    @PutMapping("/{id}")
    public ResponseEntity<?> updateUser(@PathVariable Long id, @Valid @RequestBody UserRequest userRequest) {
        try {
            User user = userCrudService.updateUser(id, userRequest);
            UserResponse userResponse = convertToResponse(user);
            
            SuccessResource<UserResponse> response = new SuccessResource<>(
                "User updated successfully", userResponse);
            return ResponseEntity.ok(response);
        } catch (RuntimeException e) {
            ErrorResource error = new ErrorResource(e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(error);
        } catch (Exception e) {
            ErrorResource error = new ErrorResource("Failed to update user: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(error);
        }
    }

    /**
     * DELETE /api/users/{id} - Xóa user
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteUser(@PathVariable Long id) {
        try {
            userCrudService.deleteUser(id);
            SuccessResource<String> response = new SuccessResource<>(
                "User deleted successfully", null);
            return ResponseEntity.ok(response);
        } catch (RuntimeException e) {
            ErrorResource error = new ErrorResource(e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(error);
        } catch (Exception e) {
            ErrorResource error = new ErrorResource("Failed to delete user: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(error);
        }
    }

    /**
     * GET /api/users/email/{email} - Tìm user theo email
     */
    @GetMapping("/email/{email}")
    public ResponseEntity<?> getUserByEmail(@PathVariable String email) {
        try {
            User user = userCrudService.getUserByEmail(email)
                    .orElseThrow(() -> new RuntimeException("User not found"));
            
            UserResponse userResponse = convertToResponse(user);
            SuccessResource<UserResponse> response = new SuccessResource<>(
                "User retrieved successfully", userResponse);
            return ResponseEntity.ok(response);
        } catch (RuntimeException e) {
            ErrorResource error = new ErrorResource(e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(error);
        } catch (Exception e) {
            ErrorResource error = new ErrorResource("Failed to retrieve user: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(error);
        }
    }

    /**
     * Convert User entity to UserResponse DTO
     */
    private UserResponse convertToResponse(User user) {
        return new UserResponse(
            user.getId(),
            user.getEmail(),
            user.getName(),
            user.getPhone(),
            user.getAddress(),
            user.getImage(),
            user.getRole(),
            user.getCreatedAt(),
            user.getUpdatedAt()
        );
    }
}