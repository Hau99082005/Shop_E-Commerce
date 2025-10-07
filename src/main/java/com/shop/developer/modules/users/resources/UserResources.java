package com.shop.developer.modules.users.resources;

public class UserResources {
     private final Long id; //final là khi mà khởi tạo giá trị cho biến thì không thể thay đổi thuộc tính đối tượng được nữa
     private final String email;
     private final String name;

     //lớp contructor
     public UserResources(Long id, String email, String name) {
        super(); //super() dùng để chứa các thuộc tính của lớp cha
        this.id = id;
        this.email = email;
        this.name = name;
     }
     public Long getId() {
        return id;
     }
    public String getEmail() {
        return email;
    }
    public String getName() {
      return name;
    }


}
