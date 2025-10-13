package com.shop.developer;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.HashSet;
import java.util.HashMap;

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
import com.shop.developer.modules.products.models.Products;
import com.shop.developer.modules.products.repositories.ProductsRepository;
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

    @Autowired
    private ProductsRepository productsRepository;

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

        Set<Long> pids = new HashSet<>();
        for (OrderItems it : items) {
            if (it != null) pids.add((long) it.getProductId());
        }
        Map<Integer, String> productsMap = new HashMap<>();
        if (!pids.isEmpty()) {
            for (Products p : productsRepository.findAllById(pids)) {
                if (p != null && p.getId() != null) {
                    productsMap.put(p.getId().intValue(), p.getName());
                }
            }
        }

        model.addAttribute("order", order);
        model.addAttribute("items", items);
        model.addAttribute("total", total);
        model.addAttribute("productsMap", productsMap);
        return "checkout-sucess"; // trả về views
    }
}
