package com.shop.developer.admin.categories;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.shop.developer.BaseController;
import com.shop.developer.modules.categories.Impl.CategoriesService;
import com.shop.developer.modules.categories.models.Categories;

import jakarta.servlet.http.HttpSession;

@Controller
public class CreateCategory extends BaseController {

    @Autowired
    private CategoriesService categoriesService;

    @Autowired
    private HttpSession httpSession;

    @GetMapping("/admin/categories/create")
    public String createCategoryForm(Model model) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        Categories category = new Categories();
        category.setStatus(Boolean.TRUE);
        model.addAttribute("category", category);
        return "admin/categories/create";
    }

    @PostMapping("/admin/categories/create")
    public String storeCategory(
        @RequestParam String name,
        @RequestParam(required = false) Boolean status,
        @RequestParam(name = "image") MultipartFile image
    ) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        if (image == null || image.isEmpty()) {
            return "redirect:/admin/categories/create";
        }
        String filename = null;
        try {
            String original = image.getOriginalFilename();
            String safe = (original == null ? "image" : original).replaceAll("[^a-zA-Z0-9_.-]", "_");
            filename = System.currentTimeMillis() + "_" + safe;
            Path uploadDir = Paths.get("src/main/webapp/assets/images");
            Files.createDirectories(uploadDir);
            Path target = uploadDir.resolve(filename);
            Files.copy(image.getInputStream(), target, StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException ex) {
            ex.printStackTrace();
            return "redirect:/admin/categories/create";
        }
        Categories cat = new Categories();
        cat.setName(name);
        cat.setThumbnail(filename);
        cat.setStatus(status != null ? status : Boolean.TRUE);
        categoriesService.saveCategory(cat);
        return "redirect:/admin/categories";
    }
}