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

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    }
    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    public void setCreateAt(LocalDateTime createAt) {
        this.createdAt = createAt;
    }
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    //khai baos constructor không có tham số
    public User() {
        super();
    }
    
    public User(Long id, String email, String password, String phone, String address, String image, String role,
    LocalDateTime createdAt, LocalDateTime updatedAt) {
        super();
        this.id = id;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.address = address;
        this.image = image;
        this.role = role;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

        //  Constructor rút gọn (không cần truyền id, createdAt, updatedAt)
    public User(String email, String password, String phone, String address, String image, String role) {
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.address = address;
        this.image = image;
        this.role = role;
    }


}
