package com.shop.developer.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.shop.developer.modules.categories.Impl.CategoriesService;

import jakarta.servlet.http.HttpSession;

@Controller
public class Dashboard {

    @Autowired
    private CategoriesService categoriesService;

    @Autowired
    private HttpSession httpSession;

    @GetMapping("/admin/dashboard")
    public String index(Model model) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        model.addAttribute("categories", categoriesService.getActiveCategories());
        return "admin/dashboard/index";
    }
}
