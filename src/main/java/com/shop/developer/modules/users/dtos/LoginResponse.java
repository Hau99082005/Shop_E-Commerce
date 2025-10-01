package com.shop.developer.modules.users.dtos;

public class LoginResponse {
    private final String token; //là 1 chuỗi ký tự đại diện cho phiên đăng nhập của người dùng
    private final UserDTO user; //là đối tượng UserDTO chứa thông tin người dùng(users)
    //lớp contructor
    public LoginResponse(String token, UserDTO user) { 
        super(); //chứa các thuộc tính của lớp cha
        this.token = token;
        this.user = user;
    }
    public String getToken() {
        return token;
    }
    public UserDTO getUser() {
        return user;
    }

}
