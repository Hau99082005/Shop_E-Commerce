package com.shop.developer.modules.users.controllers;

import com.shop.developer.modules.users.dtos.LoginRequest;
import com.shop.developer.modules.users.dtos.LoginResponse;
import com.shop.developer.modules.users.services.interfaces.UserServicesInterface;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;



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
    public ResponseEntity<LoginResponse> login(@RequestBody LoginRequest request) {
       LoginResponse auth = userService.login(request);
       return ResponseEntity.ok(auth); //kết trả sẽ trả về
   }

}
