package com.shop.developer.modules.order.models;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name="orders")
public class Order {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
    private String code;
    private Boolean status;
    public int user_id;
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

    public Order() {
        super();
    }
    public Order(String code, Boolean status, int user_id) {
        super();
        this.code = code;
        this.status = status;
        this.user_id = user_id;
    }

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public String getCode() {
        return code;
    }
    public void setCode(String code) {
        this.code = code;
    }
    public Boolean getStatus() {
        return status;
    }
    public void setStatus(Boolean status) {
        this.status = status;
    }
    public int getUserId() {
        return user_id;
    }
    public void setUserId(int user_id) {
        this.user_id = user_id;
    }


}
