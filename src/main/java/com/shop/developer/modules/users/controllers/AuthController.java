package com.shop.developer.modules.users.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.shop.developer.modules.users.request.LoginRequest;
import com.shop.developer.modules.users.resources.LoginResources;
import com.shop.developer.modules.users.services.interfaces.UserServicesInterface;
import com.shop.developer.resources.ErrorResource;

import jakarta.validation.Valid;

@Validated
@RestController
@RequestMapping("auth")
public class AuthController {
     //để xác thực người dùng khi đăng nhập
    private final UserServicesInterface userService;

   public AuthController( UserServicesInterface userService) {
     super(); //chứa các thông tin của thuộc tính cha
     this.userService = userService; 
   }
   @PostMapping("login")
    public ResponseEntity<?> login(@Valid @RequestBody LoginRequest request) {  //? là khai báo một biến
      // return ResponseEntity.ok("123");
       Object result = userService.authenticate(request);
       if(result instanceof LoginResources loginResources) {
         return ResponseEntity.ok(loginResources); //kết trả sẽ trả về
       }
       if(result instanceof ErrorResource errorResource) {
        return ResponseEntity.unprocessableEntity().body(errorResource);
       }

       return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Network Error");
   }

}
