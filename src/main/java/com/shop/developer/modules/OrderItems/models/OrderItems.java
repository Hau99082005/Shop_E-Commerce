package com.shop.developer.modules.OrderItems.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name="order_items")
public class OrderItems {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int quantity;
    private double price;

    @Column(name = "order_id")
    private int orderId;

    @Column(name = "product_id")
    private int productId;

    public OrderItems() {
        super();
    }
    public OrderItems(int quantity, double price, int order_id, int product_id) {
        super();
        this.quantity = quantity;
        this.price = price;
        this.orderId = order_id;
        this.productId = product_id;
    }
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }
    public int getOrderId() {
        return orderId;
    }
    public void setOrderId(int order_id) {
        this.orderId = order_id;
    }
    public int getProductId() {
        return productId;
    }
    public void setProductId(int product_id) {
        this.productId = product_id;
    }
}
