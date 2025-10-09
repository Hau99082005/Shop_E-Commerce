package com.shop.developer.modules.products.models;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name="products")
public class Products {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String image;
    private String description;
    private Double price;
    private Double price_old;
    private Integer quantity;
    private Integer view;
    private Integer category_id;
    private Boolean status;

     @Column(name="created_at", updatable=false)
    private LocalDateTime createdAt;

    
    
    @PrePersist //dùng để set dữ liệu trước khi lưu vào database thì nó sẽ gán thời gian hiện tại vào createdAt
    protected void onCreate() { //phương thức này sẽ được gọi trước khi thực hiện thao tác lưu (persist) đối tượng vào database.
        createdAt = LocalDateTime.now();
    }

    public Products() {
        super();
    }
    public Products(Long id, String name, String image, String description, Double price, Double price_old, 
    Integer quantity, Integer view, Integer category_id, Boolean status) {
       super();
       this.id = id;
       this.name = name;
       this.image = image;
       this.description = description;
       this.price = price;
       this.price_old = price_old;
       this.quantity = quantity;
       this.view = view;
       this.category_id = category_id;
       this.status = status;
    }

    public Products(Long id, String name, String image, String description, Double price, Double price_old, 
    Integer quantity, Integer view, Integer category_id, Boolean status, LocalDateTime created_at) {
        super();
        this.id = id;
        this.name = name;
        this.image = image;
        this.description = description;
        this.price = price;
        this.price_old = price_old;
        this.quantity = quantity;
        this.view = view;
        this.category_id = category_id;
        this.status = status;
        this.createdAt = created_at;
    }

}
