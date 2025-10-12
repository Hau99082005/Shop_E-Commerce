package com.shop.developer.admin.categories;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.shop.developer.modules.categories.Impl.CategoriesService;
import com.shop.developer.modules.categories.models.Categories;

import jakarta.servlet.http.HttpSession;

@Controller
public class EditCategory {

    @Autowired
    private CategoriesService categoriesService;

    @Autowired
    private HttpSession httpSession;

    @GetMapping("/admin/categories/{id}/edit")
    public String editCategoryForm(@PathVariable Long id, Model model) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        Optional<Categories> opt = categoriesService.getCategoryById(id);
        if (opt.isEmpty()) {
            return "redirect:/admin/categories";
        }
        model.addAttribute("category", opt.get());
        return "admin/categories/edit";
    }

    @PostMapping("/admin/categories/{id}/edit")
    public String updateCategory(
        @PathVariable Long id,
        @RequestParam String name,
        @RequestParam(required = false) Boolean status,
        @RequestParam(name = "oldThumbnail", required = false) String oldThumbnail,
        @RequestParam(name = "image", required = false) MultipartFile image
    ) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        Optional<Categories> opt = categoriesService.getCategoryById(id);
        if (opt.isEmpty()) {
            return "redirect:/admin/categories";
        }
        Categories cat = opt.get();
        cat.setName(name);
        cat.setStatus(status != null ? status : Boolean.FALSE);

        String filenameToSave = oldThumbnail;
        try {
            if (image != null && !image.isEmpty()) {
                String original = image.getOriginalFilename();
                String safe = (original == null ? "image" : original).replaceAll("[^a-zA-Z0-9_.-]", "_");
                String filename = System.currentTimeMillis() + "_" + safe;
                Path uploadDir = Paths.get("src/main/webapp/assets/images");
                Files.createDirectories(uploadDir);
                Path target = uploadDir.resolve(filename);
                Files.copy(image.getInputStream(), target, StandardCopyOption.REPLACE_EXISTING);
                filenameToSave = filename;
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }

        cat.setThumbnail(filenameToSave);
        categoriesService.saveCategory(cat);
        return "redirect:/admin/categories";
    }
}
