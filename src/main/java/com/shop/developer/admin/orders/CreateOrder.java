package com.shop.developer.admin.orders;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.developer.modules.order.models.Order;
import com.shop.developer.modules.order.repositories.OrderRepository;
import com.shop.developer.modules.users.models.User;
import com.shop.developer.modules.users.repositories.UserRepository;
import com.shop.developer.util.StringHelper;

@Controller
@RequestMapping("/admin/orders")
public class CreateOrder {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/create")
    public String createForm(Model model) {
        Order order = new Order();
        order.setStatus(true);
        order.setCode(StringHelper.randomString(8).toUpperCase());
        model.addAttribute("order", order);
        model.addAttribute("mode", "create");
        java.util.List<User> users = userRepository.findAll();
        model.addAttribute("users", users);
        return "admin/orders/edit";
    }

    @PostMapping("/create")
    public String create(@RequestParam(required = false) String code,
                         @RequestParam(name = "userId", required = false, defaultValue = "0") Integer userId,
                         @RequestParam(name = "status", required = false, defaultValue = "true") Boolean status) {
        Order order = new Order();
        order.setCode((code != null && !code.isBlank()) ? code : ("ORD-" + StringHelper.randomString(8).toUpperCase()));
        order.setUserId(userId != null ? userId : 0);
        order.setStatus(status != null ? status : true);
        orderRepository.save(order);
        return "redirect:/admin/orders";
    }
}
