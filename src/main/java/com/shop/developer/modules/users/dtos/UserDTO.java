package com.shop.developer.modules.users.dtos;

public class UserDTO {
     private final Long id; //final là khi mà khởi tạo giá trị cho biến thì không thể thay đổi thuộc tính đối tượng được nữa
     private final String email;

     //lớp contructor
     public UserDTO(Long id, String email) {
        super(); //super() dùng để chứa các thuộc tính của lớp cha
        this.id = id;
        this.email = email;
     }
     public Long getId() {
        return id;
     }
    public String getEmail() {
        return email;
    }

}
