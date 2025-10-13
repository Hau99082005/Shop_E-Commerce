package com.shop.developer.admin.orders;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shop.developer.modules.order.models.Order;
import com.shop.developer.modules.order.repositories.OrderRepository;
import com.shop.developer.modules.users.models.User;
import com.shop.developer.modules.users.repositories.UserRepository;
import com.shop.developer.modules.OrderItems.models.OrderItems;
import com.shop.developer.modules.OrderItems.repositories.OrderItemsRepository;
import com.shop.developer.modules.products.models.Products;
import com.shop.developer.modules.products.repositories.ProductsRepository;
import com.shop.developer.util.Helper;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
@RequestMapping("/admin/orders")
public class IndexOrder {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private OrderItemsRepository orderItemsRepository;

    @Autowired
    private ProductsRepository productsRepository;

    @GetMapping
    public String index(Model model) {
        List<Order> orders = orderRepository.findAll();
        model.addAttribute("orders", orders);

        List<User> users = userRepository.findAll();
        Map<Integer, String> usersMap = new HashMap<>();
        for (User u : users) {
            if (u != null && u.getId() != null) {
                usersMap.put(u.getId().intValue(), u.getName() != null && !u.getName().isBlank() ? u.getName() : u.getEmail());
            }
        }
        model.addAttribute("usersMap", usersMap);
        return "admin/orders/index";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        Order order = orderRepository.findById(id).orElse(null);
        if (order == null) {
            return "redirect:/admin/orders";
        }
        java.util.List<OrderItems> items = orderItemsRepository.findByOrderId(order.getId().intValue());
        if (items == null) items = java.util.Collections.emptyList();
        double total = Helper.total(items);

        // Build products map id -> name for display
        java.util.Set<Long> pids = new java.util.HashSet<>();
        for (OrderItems it : items) {
            if (it != null) pids.add((long) it.getProductId());
        }
        java.util.Map<Integer, String> productsMap = new java.util.HashMap<>();
        if (!pids.isEmpty()) {
            for (Products p : productsRepository.findAllById(pids)) {
                if (p != null && p.getId() != null) {
                    productsMap.put(p.getId().intValue(), p.getName());
                }
            }
        }

        String userName = String.valueOf(order.getUserId());
        if (order.getUserId() > 0) {
            User u = userRepository.findById((long) order.getUserId()).orElse(null);
            if (u != null) {
                userName = (u.getName() != null && !u.getName().isBlank()) ? u.getName() : u.getEmail();
            }
        }
        model.addAttribute("order", order);
        model.addAttribute("items", items);
        model.addAttribute("total", total);
        model.addAttribute("userName", userName);
        model.addAttribute("productsMap", productsMap);
        return "admin/orders/items";
    }
}
