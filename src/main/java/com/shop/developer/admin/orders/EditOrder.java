package com.shop.developer.admin.orders;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.developer.modules.order.models.Order;
import com.shop.developer.modules.order.repositories.OrderRepository;
import com.shop.developer.modules.users.models.User;
import com.shop.developer.modules.users.repositories.UserRepository;

@Controller
@RequestMapping("/admin/orders")
public class EditOrder {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/{id}/edit")
    public String editForm(@PathVariable Long id, Model model) {
        Order order = orderRepository.findById(id).orElse(null);
        if (order == null) {
            return "redirect:/admin/orders";
        }
        model.addAttribute("order", order);
        model.addAttribute("mode", "edit");
        java.util.List<User> users = userRepository.findAll();
        model.addAttribute("users", users);
        return "admin/orders/edit";
    }

    @PostMapping("/{id}/edit")
    public String update(@PathVariable Long id,
                         @RequestParam(required = false) String code,
                         @RequestParam(name = "userId", required = false) Integer userId,
                         @RequestParam(name = "status", required = false) Boolean status) {
        Order order = orderRepository.findById(id).orElse(null);
        if (order == null) {
            return "redirect:/admin/orders";
        }
        if (code != null && !code.isBlank()) order.setCode(code);
        if (userId != null) order.setUserId(userId);
        if (status != null) order.setStatus(status);
        orderRepository.save(order);
        return "redirect:/admin/orders";
    }
}
