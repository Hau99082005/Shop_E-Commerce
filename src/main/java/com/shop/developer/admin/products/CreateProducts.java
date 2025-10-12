package com.shop.developer.admin.products;

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

import com.shop.developer.modules.categories.Impl.CategoriesService;
import com.shop.developer.modules.products.Impl.ProductsService;
import com.shop.developer.modules.products.models.Products;

import jakarta.servlet.http.HttpSession;

@Controller
public class CreateProducts {

    @Autowired
    private ProductsService productsService;

    @Autowired
    private CategoriesService categoriesService;

    @Autowired
    private HttpSession httpSession;

    @GetMapping("/admin/products/create")
    public String createProductForm(Model model) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        Products product = new Products();
        product.setStatus(Boolean.TRUE);
        product.setQuantity(0);
        model.addAttribute("product", product);
        model.addAttribute("categories", categoriesService.getAllCategories());
        return "admin/products/create";
    }

    @PostMapping("/admin/products/create")
    public String storeProduct(
        @RequestParam String name,
        @RequestParam String description,
        @RequestParam Double price,
        @RequestParam(required = false) Double price_old,
        @RequestParam Integer quantity,
        @RequestParam(name = "category_id") Integer categoryId,
        @RequestParam(required = false) Boolean status,
        @RequestParam(name = "image") MultipartFile image
    ) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        if (image == null || image.isEmpty()) {
            return "redirect:/admin/products/create";
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
            return "redirect:/admin/products/create";
        }
        Products p = new Products();
        p.setName(name);
        p.setDescription(description);
        p.setPrice(price);
        p.setPrice_old(price_old);
        p.setQuantity(quantity);
        p.setCategory_id(categoryId);
        p.setStatus(status != null ? status : Boolean.TRUE);
        p.setView(0);
        p.setImage(filename);
        productsService.saveProduct(p);
        return "redirect:/admin/products";
    }
}
