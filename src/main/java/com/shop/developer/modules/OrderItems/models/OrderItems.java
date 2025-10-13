package com.shop.developer.modules.OrderItems.models;

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
    private int order_id;
    private int product_id;

    public OrderItems() {
        super();
    }
    public OrderItems(int quantity, double price, int order_id, int product_id) {
        super();
        this.quantity = quantity;
        this.price = price;
        this.order_id = order_id;
        this.product_id = product_id;
    }
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }
    public int getOrderId() {
        return order_id;
    }
    public void setOrderId(int order_id) {
        this.order_id = order_id;
    }
    public int getProductId() {
        return product_id;
    }
    public void setProductId(int product_id) {
        this.product_id = product_id;
    }
}
