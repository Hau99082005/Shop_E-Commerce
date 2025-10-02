package com.shop.developer.modules.users.models;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor //tạo constructor không có tham số
@AllArgsConstructor //tạo constructor có tất cả các tham số
@Data //tự động tạo các phương thức getter, setter, toString, equals, hashCode
@Entity
@Table(name="users") //tên bảng trong database
public class User {

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = false, unique = true, length = 50)
    private String email;
     @Column(nullable = false, length = 255)
    private String password;
    @Column(nullable = false, unique = true, length = 15)
    private String phone;
    @Column(length = 255)
    private String address;
    @Column(length = 255)
    private String image;
     @Column(nullable = false, length = 20)
    private String role;

    @Column(name="created_at", updatable=false)
    private LocalDateTime createdAt;

    @Column(name="updated_at")
    private LocalDateTime updatedAt;

    @PrePersist //dùng để set dữ liệu trước khi lưu vào database thì nó sẽ gán thời gian hiện tại vào createdAt
    protected void onCreate() { //phương thức này sẽ được gọi trước khi thực hiện thao tác lưu (persist) đối tượng vào database.
        createdAt = LocalDateTime.now();
    }

    @PreUpdate //dùng để set dữ liệu trước khi cập nhật vào database thì nó sẽ gán thời gian hiện tại vào updatedAt
    protected void onUpdate() { // phương thức sẽ được gọi trước khi thức hiện update đối tượng trong database.
        updatedAt = LocalDateTime.now();
    }

}
