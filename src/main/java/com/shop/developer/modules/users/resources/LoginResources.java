package com.shop.developer.modules.users.resources;

public class LoginResources {
    private final String token; //là 1 chuỗi ký tự đại diện cho phiên đăng nhập của người dùng
    private final UserResources user; //là đối tượng UserDTO chứa thông tin người dùng(users)
    //lớp contructor
    public LoginResources(String token, UserResources user) { 
        super(); //chứa các thuộc tính của lớp cha
        this.token = token;
        this.user = user;
    }
    public String getToken() {
        return token;
    }
    public UserResources getUser() {
        return user;
    }

}
