package com.shop.developer.modules.order.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.developer.Cart;
import com.shop.developer.modules.order.Impl.OrderService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/orders")
public class OrderController {
     @Autowired
    private OrderService orderService;

    // Danh sách đơn (đơn giản - có thể mở rộng filter theo user(người dùng))
    @GetMapping
    public String index(Model model) {
        model.addAttribute("orders", orderService.findAll());
        return "orders/index"; // Tạo view nếu cần, hoặc thay bằng JSON/API
    }

    // Checkout: tạo Order từ giỏ hàng (CART trong session) rồi clear giỏ
    @PostMapping("/checkout")
    public String checkout(HttpSession session,
                           @RequestParam(name = "userId", required = false) Integer userId) {

        @SuppressWarnings("unchecked")
        Map<Long, Cart.CartLine> cart = (Map<Long, Cart.CartLine>) session.getAttribute("CART");
        if (cart == null || cart.isEmpty()) {
            return "redirect:/cart";
        }

        var order = orderService.createOrderFromCart(cart, userId);
        System.out.println( order);//in ra hoá đơn trong server
        // Clear cart sau khi đặt hàng
        session.setAttribute("CART", null);

        // Có thể chuyển hướng sang trang chi tiết đơn nếu bạn có view: /orders/{id}
        // return "redirect:/orders/" + order.getId();
        return "redirect:/cart";
    }
}
