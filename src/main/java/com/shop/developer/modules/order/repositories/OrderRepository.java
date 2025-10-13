package com.shop.developer.modules.order.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.shop.developer.modules.order.models.Order;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long>{
    Optional<Order> findByCode(String code);
    List<Order> findByUser_id(int user_id);
}
