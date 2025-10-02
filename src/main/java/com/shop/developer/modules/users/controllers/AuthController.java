package com.shop.developer.modules.users.controllers;

import com.shop.developer.modules.users.request.LoginRequest;
import com.shop.developer.modules.users.resources.LoginResources;
import com.shop.developer.modules.users.services.interfaces.UserServicesInterface;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
    public ResponseEntity<LoginResources> login(@Valid @RequestBody LoginRequest request) {
       LoginResources auth = userService.login(request);
       return ResponseEntity.ok(auth); //kết trả sẽ trả về
   }

}
