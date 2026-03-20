package com.shop.developer;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.shop.developer.modules.OrderItems.models.OrderItems;
import com.shop.developer.modules.OrderItems.repositories.OrderItemsRepository;
import com.shop.developer.modules.order.models.Order;
import com.shop.developer.modules.order.repositories.OrderRepository;
import com.shop.developer.modules.products.models.Products;
import com.shop.developer.modules.products.repositories.ProductsRepository;
import com.shop.developer.modules.users.models.User;
import com.shop.developer.util.Helper;

import jakarta.servlet.http.HttpSession;

@Controller
public class MyOrders {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderItemsRepository orderItemsRepository;

    @Autowired
    private ProductsRepository productsRepository;

    @GetMapping("/my-orders")
    public String myOrders(HttpSession session, Model model) {
        Object u = session.getAttribute("user");
        if (!(u instanceof User)) return "redirect:/login";

        User user = (User) u;
        List<Order> orders = orderRepository.findByUserId(user.getId().intValue());
        if (orders == null) orders = new ArrayList<>();

        Map<Long, Double> totalsMap = new HashMap<>();
        Map<Long, Integer> countMap = new HashMap<>();
        for (Order o : orders) {
            List<OrderItems> items = orderItemsRepository.findByOrderId(o.getId().intValue());
            totalsMap.put(o.getId(), Helper.total(items));
            countMap.put(o.getId(), items.stream().mapToInt(OrderItems::getQuantity).sum());
        }

        model.addAttribute("orders", orders);
        model.addAttribute("totalsMap", totalsMap);
        model.addAttribute("countMap", countMap);
        return "my-orders";
    }

    @GetMapping("/my-orders/{id}")
    public String orderDetail(@PathVariable Long id, HttpSession session, Model model) {
        Object u = session.getAttribute("user");
        if (!(u instanceof User)) return "redirect:/login";

        User user = (User) u;
        Order order = orderRepository.findById(id).orElse(null);
        if (order == null || order.getUserId() != user.getId().intValue()) return "redirect:/my-orders";

        List<OrderItems> items = orderItemsRepository.findByOrderId(order.getId().intValue());
        if (items == null) items = new ArrayList<>();

        Set<Long> pids = new HashSet<>();
        for (OrderItems it : items) pids.add((long) it.getProductId());

        Map<Integer, Products> productsMap = new HashMap<>();
        if (!pids.isEmpty()) {
            for (Products p : productsRepository.findAllById(pids)) {
                if (p != null) productsMap.put(p.getId().intValue(), p);
            }
        }

        double total = Helper.total(items);
        model.addAttribute("order", order);
        model.addAttribute("items", items);
        model.addAttribute("productsMap", productsMap);
        model.addAttribute("total", total);
        return "my-order-detail";
    }
}
