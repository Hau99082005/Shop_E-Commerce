package com.shop.developer.modules.OrderItems.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.developer.modules.OrderItems.Impl.OrderItemsService;
import com.shop.developer.modules.OrderItems.models.OrderItems;

@Controller
@RequestMapping("/order-items")
public class OrderItemsController {
      @Autowired
    private OrderItemsService orderItemsService;

    // Liệt kê theo orderId (nếu có), hoặc tất cả
    @GetMapping
    public String index(@RequestParam(name = "orderId", required = false) Integer orderId,
        Model model) {
        List<OrderItems> items = (orderId != null && orderId > 0)
                ? orderItemsService.findByOrderId(orderId)
                : orderItemsService.findAll();
        model.addAttribute("items", items);
        // trỏ tới view thật (ví dụ: "orders/items"), hiện tại dùng trang tạm
        return "orders/items"; 
    }

    // Tạo mới một dòng chi tiết đơn
    @PostMapping("/create")
    public String create(@RequestParam("order_id") int orderId,
                         @RequestParam("product_id") int productId,
                         @RequestParam("quantity") int quantity,
                         @RequestParam("price") double price) {
        OrderItems orderItems = new OrderItems();
        orderItems.setOrderId(orderId);
        orderItems.setProductId(productId);
        orderItems.setQuantity(quantity);
        orderItems.setPrice(price);
        orderItemsService.save(orderItems);

        return "redirect:/order-items?orderId=" + orderId;
    }

    // Cập nhật số lượng/đơn giá
    @PostMapping("/update")
    public String update(@RequestParam("id") Long id,
                         @RequestParam(name = "quantity", required = false) Integer quantity,
                         @RequestParam(name = "price", required = false) Double price,
                         @RequestParam(name = "orderId", required = false) Integer orderId) {
        orderItemsService.updateQuantityAndPrice(id, quantity, price);
        return orderId != null
                ? "redirect:/order-items?orderId=" + orderId
                : "redirect:/order-items";
    }

    // Xóa một dòng
    @PostMapping("/delete")
    public String delete(@RequestParam("id") Long id,
                         @RequestParam(name = "orderId", required = false) Integer orderId) {
        orderItemsService.deleteById(id);
        return orderId != null
                ? "redirect:/order-items?orderId=" + orderId
                : "redirect:/order-items";
    }    
}
