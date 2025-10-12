package com.shop.developer.admin.products;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.shop.developer.modules.categories.Impl.CategoriesService;
import com.shop.developer.modules.products.Impl.ProductsService;

import jakarta.servlet.http.HttpSession;

@Controller
public class IndexProducts {

    @Autowired
    private ProductsService productsService;

    @Autowired
    private CategoriesService categoriesService;

    @Autowired
    private HttpSession httpSession;

    @GetMapping("/admin/products")
    public String adminProducts(Model model) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        model.addAttribute("products", productsService.getAllProducts());
        model.addAttribute("categories", categoriesService.getAllCategories());
        return "admin/products/index";
    }
}
