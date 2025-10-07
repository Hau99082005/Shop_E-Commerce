package com.shop.developer.modules.users.services.impl;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.shop.developer.modules.users.models.User;
import com.shop.developer.modules.users.repositories.UserRepository;
import com.shop.developer.modules.users.request.LoginRequest;
import com.shop.developer.modules.users.resources.LoginResources;
import com.shop.developer.modules.users.resources.UserResources;
import com.shop.developer.modules.users.services.interfaces.UserServicesInterface;
import com.shop.developer.resources.ErrorResource;
import com.shop.developer.services.BaseService;
import com.shop.developer.services.JWTService;

@Service
public class UserService extends BaseService implements UserServicesInterface {

    private static final Logger logger = LoggerFactory.getLogger(UserService.class);

    @Autowired
    private JWTService jwtService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserRepository userRepository;

    @Override
    public Object authenticate(LoginRequest request) {
        try {
            User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new BadCredentialsException("Tài khoản hoặc mật khẩu không đúng!"));
            
                if(!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
                    throw new BadCredentialsException("Email hoặc mật khẩu không chính xác!");
                }
                
            UserResources userResource = new UserResources(user.getId(), user.getEmail(), user.getName());
            String token = jwtService.generateToken(user.getId(), user.getEmail());
            return new LoginResources(token, userResource);

        } catch (BadCredentialsException e) { //thông báo lỗi 
            logger.error("Lỗi xác thực {}", e.getMessage()); //log ra lỗi xác thực authentication 
            // throw new RuntimeException("Đã có vấn đề xảy ra!", e);
            Map<String, String> errors = new HashMap<>();
            errors.put("message", e.getMessage());
            ErrorResource errorResource = new ErrorResource("Có vấn đề xảy ra trong quá trình xác thực", errors);
            return errorResource;
        }
    }
    
}
