package com.shop.developer.resources;

import java.util.Map;

public class ErrorResource {
    private String message;
    private Map<String, String> errors;

    // Constructor với chỉ message
    public ErrorResource(String message) {
        this.message = message;
        this.errors = null;
    }

    // Constructor với message và errors
    public ErrorResource(String message, Map<String, String> errors) {
        super();
        this.message = message;
        this.errors = errors;
    }
    
    public String getMessage() {
        return message;
    }
    
    public void setMessage(String message) {
        this.message = message;
    }
    
    public Map<String, String> getErrors() {
        return errors;
    }

    public void setErrors(Map<String, String> errors) {
        this.errors = errors;
    }
}
