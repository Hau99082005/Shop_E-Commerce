package com.shop.developer;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.developer.modules.products.Impl.ProductsService;
import com.shop.developer.modules.products.models.Products;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/cart")
public class Cart {

    public static class CartLine {
        private final Products product;
        private int quantity;
        public CartLine(Products product, int quantity) {
            this.product = product;
            this.quantity = quantity;
        }
        public Products getProduct() { return product; }
        public int getQuantity() { return quantity; }
        public void setQuantity(int q) { this.quantity = q; }
        public double getLineTotal() {
            double price = product.getPrice() != null ? product.getPrice() : 0.0;
            return price * quantity * 1000;
        }
    }

    @Autowired
    private ProductsService productsService;

    @SuppressWarnings("unchecked")
    private Map<Long, CartLine> getCart(HttpSession session) {
        Object obj = session.getAttribute("CART");
        if (obj instanceof Map) {
            return (Map<Long, CartLine>) obj;
        }
        Map<Long, CartLine> map = new LinkedHashMap<>();
        session.setAttribute("CART", map);
        return map;
    }

    @GetMapping
    public String viewCart(HttpSession session, Model model) {
        Map<Long, CartLine> map = getCart(session);
        List<CartLine> items = new ArrayList<>(map.values());
        double total = items.stream().mapToDouble(CartLine::getLineTotal).sum();
        int totalQuantity = items.stream().mapToInt(CartLine::getQuantity).sum();
        model.addAttribute("items", items);
        model.addAttribute("total", total);
        model.addAttribute("totalQuantity", totalQuantity);
        return "cart"; // trả về views/cart.jsp
    }

    @PostMapping("/add")
    public String addToCart(@RequestParam("productId") Long productId,
                            @RequestParam(name = "quantity", required = false, defaultValue = "1") Integer quantity,
                            HttpSession session) {
        if (quantity == null || quantity < 1) quantity = 1;
        Map<Long, CartLine> map = getCart(session);
        CartLine line = map.get(productId);
        if (line == null) {
            Products p = productsService.getProductById(productId).orElse(null);
            if (p != null) {
                map.put(productId, new CartLine(p, quantity));
            }
       } else {
            line.setQuantity(line.getQuantity() + quantity);
        }
        return "redirect:/cart";
    }

    @PostMapping("/update")
    public String update(@RequestParam("productId") Long productId,
                         @RequestParam("quantity") Integer quantity,
                         HttpSession session) {
        Map<Long, CartLine> map = getCart(session);
        CartLine line = map.get(productId);
        if (line != null) {
            if (quantity != null && quantity > 0) line.setQuantity(quantity);
        }
        return "redirect:/cart";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam("productId") Long productId, HttpSession session) {
        Map<Long, CartLine> map = getCart(session);
        map.remove(productId);
        return "redirect:/cart";
    }
}
