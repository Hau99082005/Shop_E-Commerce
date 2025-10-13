package com.shop.developer;

import java.io.Serializable;
import java.time.LocalDateTime;

import com.shop.developer.modules.users.models.User;

public class Profile implements Serializable {
    private Long id;
    private String email;
    private String name;
    private String phone;
    private String address;
    private String image;
    private String role;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public static Profile fromUser(User u) {
        if (u == null) return null;
        Profile p = new Profile();
        p.setId(u.getId());
        p.setEmail(u.getEmail());
        p.setName(u.getName());
        p.setPhone(u.getPhone());
        p.setAddress(u.getAddress());
        p.setImage(u.getImage());
        p.setRole(u.getRole());
        p.setCreatedAt(u.getCreatedAt());
        p.setUpdatedAt(u.getUpdatedAt());
        return p;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
}
