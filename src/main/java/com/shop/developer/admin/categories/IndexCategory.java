package com.shop.developer.admin.categories;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.shop.developer.modules.categories.Impl.CategoriesService;
import com.shop.developer.modules.categories.models.Categories;

import jakarta.servlet.http.HttpSession;

@Controller
public class IndexCategory {

    @Autowired
    private CategoriesService categoriesService;

    @Autowired
    private HttpSession httpSession;

    @GetMapping("/admin/categories")
    public String adminCategories(Model model) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        model.addAttribute("categories", categoriesService.getAllCategories());
        return "admin/categories/index";
    }

    @GetMapping("/admin/categories/{id}/toggle")
    public String toggleCategory(@PathVariable Long id) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        java.util.Optional<Categories> opt = categoriesService.getCategoryById(id);
        if (opt.isPresent()) {
            Categories c = opt.get();
            c.setStatus(Boolean.TRUE.equals(c.getStatus()) ? Boolean.FALSE : Boolean.TRUE);
            categoriesService.saveCategory(c);
        }
        return "redirect:/admin/categories";
    }
}
