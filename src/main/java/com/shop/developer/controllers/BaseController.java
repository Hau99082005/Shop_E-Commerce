package com.shop.developer.controllers;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

public class BaseController {
    //tạo phương thức trả về(response) chuẩn cho tất cả API
    protected ResponseEntity<Map<String, Object>> successResponse(Object data) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("data", data);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
     protected ResponseEntity<Map<String, Object>> errorResponse(String message, HttpStatus status) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", false);
        response.put("error", message);
        return new ResponseEntity<>(response, status);
    }
     protected void logAction(String message) {
        System.out.println("[BaseController] " + message);
    }
    
}
