package com.shop.developer.admin.products;

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
import com.shop.developer.modules.products.Impl.ProductsService;
import com.shop.developer.modules.products.models.Products;

import jakarta.servlet.http.HttpSession;

@Controller
public class EditProducts {

    @Autowired
    private ProductsService productsService;

    @Autowired
    private CategoriesService categoriesService;

    @Autowired
    private HttpSession httpSession;

    @GetMapping("/admin/products/{id}/edit")
    public String editProductForm(@PathVariable Long id, Model model) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        Optional<Products> opt = productsService.getProductById(id);
        if (opt.isEmpty()) {
            return "redirect:/admin/products";
        }
        model.addAttribute("product", opt.get());
        model.addAttribute("categories", categoriesService.getAllCategories());
        return "admin/products/edit";
    }

    @PostMapping("/admin/products/{id}/edit")
    public String updateProduct(
        @PathVariable Long id,
        @RequestParam String name,
        @RequestParam String description,
        @RequestParam Double price,
        @RequestParam(required = false) Double price_old,
        @RequestParam Integer quantity,
        @RequestParam(name = "category_id") Integer categoryId,
        @RequestParam(required = false) Boolean status,
        @RequestParam(name = "oldImage", required = false) String oldImage,
        @RequestParam(name = "image", required = false) MultipartFile image
    ) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        Optional<Products> opt = productsService.getProductById(id);
        if (opt.isEmpty()) {
            return "redirect:/admin/products";
        }
        Products p = opt.get();
        p.setName(name);
        p.setDescription(description);
        p.setPrice(price);
        p.setPrice_old(price_old);
        p.setQuantity(quantity);
        p.setCategory_id(categoryId);
        p.setStatus(status != null ? status : Boolean.FALSE);

        String imageToSave = oldImage;
        try {
            if (image != null && !image.isEmpty()) {
                String original = image.getOriginalFilename();
                String safe = (original == null ? "image" : original).replaceAll("[^a-zA-Z0-9_.-]", "_");
                String filename = System.currentTimeMillis() + "_" + safe;
                Path uploadDir = Paths.get("src/main/webapp/assets/images");
                Files.createDirectories(uploadDir);
                Path target = uploadDir.resolve(filename);
                Files.copy(image.getInputStream(), target, StandardCopyOption.REPLACE_EXISTING);
                imageToSave = filename;
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        p.setImage(imageToSave);
        productsService.saveProduct(p);
        return "redirect:/admin/products";
    }
}

