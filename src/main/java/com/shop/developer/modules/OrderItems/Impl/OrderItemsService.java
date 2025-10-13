package com.shop.developer.modules.OrderItems.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.developer.modules.OrderItems.models.OrderItems;
import com.shop.developer.modules.OrderItems.repositories.OrderItemsRepository;

@Service
public class OrderItemsService {
    @Autowired
    private OrderItemsRepository orderItemsRepository;

    public List<OrderItems> findAll() {
        return orderItemsRepository.findAll();
    }

    public OrderItems findById(Long id) {
        return orderItemsRepository.findById(id).orElse(null);
    }

    public List<OrderItems> findByOrderId(int orderId) {
        return orderItemsRepository.findByOrderId(orderId);
    }

    public OrderItems save(OrderItems item) {
        return orderItemsRepository.save(item);
    }

    public void deleteById(Long id) {
        orderItemsRepository.deleteById(id);
    }

    public OrderItems updateQuantityAndPrice(Long id, Integer quantity, Double price) {
        OrderItems oi = orderItemsRepository.findById(id).orElse(null);
        if (oi == null) return null;
        if (quantity != null && quantity > 0) {
            oi.setQuantity(quantity);
        }
        if (price != null && price >= 0) {
            oi.setPrice(price);
        }
        return orderItemsRepository.save(oi);
    }
}
