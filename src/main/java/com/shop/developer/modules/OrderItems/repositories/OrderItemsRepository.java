package com.shop.developer.modules.OrderItems.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.shop.developer.modules.OrderItems.models.OrderItems;

@Repository
public interface OrderItemsRepository extends JpaRepository<OrderItems, Long> {
     List<OrderItems> findByOrder_id(int order_id);
}
