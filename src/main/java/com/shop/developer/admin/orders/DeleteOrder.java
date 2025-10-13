package com.shop.developer.admin.orders;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shop.developer.modules.OrderItems.models.OrderItems;
import com.shop.developer.modules.OrderItems.repositories.OrderItemsRepository;
import com.shop.developer.modules.order.repositories.OrderRepository;

@Controller
@RequestMapping("/admin/orders")
public class DeleteOrder {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderItemsRepository orderItemsRepository;

    @GetMapping("/{id}/delete")
    public String delete(@PathVariable Long id) {
        if (id != null) {
            int oid = id.intValue();
            List<OrderItems> items = orderItemsRepository.findByOrderId(oid);
            if (items != null && !items.isEmpty()) {
                orderItemsRepository.deleteAll(items);
            }
            orderRepository.deleteById(id);
        }
        return "redirect:/admin/orders";
    }
}
