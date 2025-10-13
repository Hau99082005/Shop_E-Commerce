package com.shop.developer.modules.order.Impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.math.BigDecimal;
import com.shop.developer.util.StringHelper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.developer.Cart;
import com.shop.developer.modules.OrderItems.models.OrderItems;
import com.shop.developer.modules.OrderItems.repositories.OrderItemsRepository;
import com.shop.developer.modules.order.models.Order;
import com.shop.developer.modules.order.repositories.OrderRepository;

@Service
public class OrderService {
    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderItemsRepository orderItemsRepository;

    public List<Order> findAll() {
        return orderRepository.findAll();
    }

    public Order findById(Long id) {
        return orderRepository.findById(id).orElse(null);
    }

    public List<Order> findByUserId(int userId) {
        return orderRepository.findByUserId(userId);
    }

    public Order findByCode(String code) {
        return orderRepository.findByCode(code).orElse(null);
    }

    public Order save(Order order) {
        return orderRepository.save(order);
    }

    public void deleteById(Long id) {
        orderRepository.deleteById(id);
    }

    public Order updateStatus(Long id, Boolean status) {
        Order o = orderRepository.findById(id).orElse(null);
        if (o != null) {
            o.setStatus(status);
            return orderRepository.save(o);
        }
        return null;
    }

    // Checkout: tạo Order + OrderItems từ giỏ hàng (session)
    public Order createOrderFromCart(Map<Long, Cart.CartLine> cart, Integer userIdNullable) {
        if (cart == null || cart.isEmpty()) return null;

        int userId = userIdNullable != null ? userIdNullable : 0;

        // Tạo Order
        Order order = new Order();
        order.setCode(generateOrderCode());
        order.setStatus(true);
        order.setUserId(userId);
        order = orderRepository.save(order);

        // Tạo OrderItems từ các dòng cart
        List<OrderItems> items = new ArrayList<>();
        for (Map.Entry<Long, Cart.CartLine> e : cart.entrySet()) {
            Cart.CartLine line = e.getValue();
            if (line == null || line.getProduct() == null) continue;

            OrderItems oi = new OrderItems();
            oi.setOrderId(order.getId().intValue());
            oi.setProductId(line.getProduct().getId().intValue());
            oi.setQuantity(line.getQuantity());

            double unitPrice = line.getProduct().getPrice() != null ? line.getProduct().getPrice() : 0.0;
            oi.setPrice(BigDecimal.valueOf(unitPrice)); // lưu đơn giá (đơn vị gốc), khi hiển thị nhân 1000
            items.add(oi);
        }

        if (!items.isEmpty()) {
            orderItemsRepository.saveAll(items);
        }

        return order;
    }

    private String generateOrderCode() {
        return "ORD-" + StringHelper.randomString(8).toUpperCase();
    }
}
