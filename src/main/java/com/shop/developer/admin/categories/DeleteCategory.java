package com.shop.developer.admin.categories;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.shop.developer.modules.categories.Impl.CategoriesService;

import jakarta.servlet.http.HttpSession;

@Controller
public class DeleteCategory {

    @Autowired
    private CategoriesService categoriesService;

    @Autowired
    private HttpSession httpSession;

    @GetMapping("/admin/categories/{id}/delete")
    public String deleteCategory(@PathVariable Long id) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        if (id != null) {
            categoriesService.deleteCategory(id);
        }
        return "redirect:/admin/categories";
    }
}
