package com.shop.developer.admin.products;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.shop.developer.modules.products.Impl.ProductsService;
import com.shop.developer.modules.products.models.Products;

import jakarta.servlet.http.HttpSession;

@Controller
public class DeleteProducts {

    @Autowired
    private ProductsService productsService;

    @Autowired
    private HttpSession httpSession;

    @GetMapping("/admin/products/{id}/delete")
    public String deleteProduct(@PathVariable Long id) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        java.util.Optional<Products> opt = productsService.getProductById(id);
        if (opt.isPresent()) {
            Products p = opt.get();
            try {
                String img = p.getImage();
                if (img != null && !img.isBlank()) {
                    java.nio.file.Path uploadDir = java.nio.file.Paths.get("src/main/webapp/assets/images");
                    java.nio.file.Files.createDirectories(uploadDir);
                    java.nio.file.Path path = uploadDir.resolve(img);
                    java.nio.file.Files.deleteIfExists(path);
                }
            } catch (Exception ignore) {}
            productsService.deleteProduct(id);
        }
        return "redirect:/admin/products";
    }
}
