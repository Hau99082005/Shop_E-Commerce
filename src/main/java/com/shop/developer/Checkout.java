package com.shop.developer;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.shop.developer.modules.OrderItems.models.OrderItems;
import com.shop.developer.modules.OrderItems.repositories.OrderItemsRepository;
import com.shop.developer.modules.order.Impl.OrderService;
import com.shop.developer.modules.order.models.Order;
import com.shop.developer.modules.users.models.User;
import com.shop.developer.util.Helper;

import jakarta.servlet.http.HttpSession;

@Controller
public class Checkout {

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderItemsRepository orderItemsRepository;

    @Autowired
    private HttpSession session;

    @SuppressWarnings("unchecked")
    @PostMapping("/checkout")
    public String doCheckout() {
        Object cartObj = session.getAttribute("CART");
        Map<Long, Cart.CartLine> cart = null;
        if (cartObj instanceof Map) {
            cart = (Map<Long, Cart.CartLine>) cartObj;
        }
        Integer userId = null;
        Object u = session.getAttribute("user");
        if (u instanceof User) {
            Long uid = ((User) u).getId();
            if (uid != null) userId = uid.intValue();
        }
        Order order = orderService.createOrderFromCart(cart, userId);
        if (order == null) {
            return "redirect:/cart";
        }
        // xoá giỏ hàng sau khi thanh toán thành công
        session.setAttribute("CART", new java.util.LinkedHashMap<Long, Cart.CartLine>());
        return "redirect:/checkout/success/" + order.getCode();
    }

    @GetMapping("/checkout/success/{code}")
    public String checkoutSuccess(@PathVariable("code") String code, Model model) {
        Order order = orderService.findByCode(code);
        if (order == null) {
            return "redirect:/";
        }
        List<OrderItems> items = orderItemsRepository.findByOrderId(order.getId().intValue());
        if (items == null) items = new ArrayList<>();
        double total = Helper.total(items);
        model.addAttribute("order", order);
        model.addAttribute("items", items);
        model.addAttribute("total", total);
        return "checkout-sucess"; // trả về views
    }
}
