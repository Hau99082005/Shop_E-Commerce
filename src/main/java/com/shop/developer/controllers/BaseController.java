package com.shop.developer.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.developer.modules.banner.models.Banner;
import com.shop.developer.modules.banner.repositories.BannerRespository;
import com.shop.developer.modules.categories.Impl.CategoriesService;
import com.shop.developer.modules.categories.models.Categories;
import com.shop.developer.modules.products.Impl.ProductsService;
import com.shop.developer.modules.products.models.Products;

@Controller
public class BaseController {

    @Autowired
    private CategoriesService categoriesService;

    @Autowired
    private ProductsService productsService;

    @Autowired
    private BannerRespository bannerRespository;

    // ✅ Các hàm dùng chung cho các controller khác (vẫn giữ lại)
    protected ResponseEntity<Map<String, Object>> successResponse(Object data) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("data", data);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    protected ResponseEntity<Map<String, Object>> errorResponse(String message, HttpStatus status) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", false);
        response.put("error", message);
        return new ResponseEntity<>(response, status);
    }

    protected void logAction(String message) {
        System.out.println("[BaseController] " + message);
    }

    @GetMapping("/")
    public String home(Model model) {
        // Lấy danh sách banner đang hoạt động
        List<Banner> banners = bannerRespository.findByStatus(true);
        model.addAttribute("banners", banners);

        // Lấy danh sách categories đang hoạt động
        List<Categories> categories = categoriesService.getActiveCategories();
        model.addAttribute("categories", categories);

        // Lấy danh sách sản phẩm đang hoạt động (giới hạn 8 sản phẩm đầu tiên)
        List<Products> products = productsService.getActiveProducts();
        if (products.size() > 8) {
            products = products.subList(0, 8);
        }
        model.addAttribute("products", products);

        return "index";
    }

    @GetMapping("/category/{id}")
    public String categoryProducts(@PathVariable Long id, Model model) {
        Optional<Categories> categoryOpt = categoriesService.getCategoryById(id);
        if (categoryOpt.isEmpty()) {
            return "redirect:/";
        }

        Categories category = categoryOpt.get();
        model.addAttribute("category", category);

        List<Products> products = productsService.getProductsByCategory(id.intValue());
        model.addAttribute("products", products);

        List<Categories> categories = categoriesService.getActiveCategories();
        model.addAttribute("categories", categories);

        return "category";
    }

    @GetMapping("/product/{id}")
    public String productDetail(@PathVariable Long id, Model model) {
        Optional<Products> productOpt = productsService.getProductById(id);
        if (productOpt.isEmpty()) {
            return "redirect:/";
        }

        Products product = productOpt.get();
        model.addAttribute("product", product);

        List<Categories> categories = categoriesService.getActiveCategories();
        model.addAttribute("categories", categories);

        List<Products> relatedProducts = productsService.getProductsByCategory(product.getCategory_id().intValue());
        relatedProducts.removeIf(p -> p.getId().equals(id));
        if (relatedProducts.size() > 4) {
            relatedProducts = relatedProducts.subList(0, 4);
        }
        model.addAttribute("relatedProducts", relatedProducts);

        return "product-detail";
    }

    @GetMapping("/products")
    public String allProducts(@RequestParam(required = false) String search, Model model) {
        List<Products> products;

        if (search != null && !search.trim().isEmpty()) {
            products = productsService.getActiveProducts();
            products = products.stream()
                .filter(p -> p.getName().toLowerCase().contains(search.toLowerCase()))
                .toList();
            model.addAttribute("search", search);
        } else {
            products = productsService.getActiveProducts();
        }

        model.addAttribute("products", products);

        List<Categories> categories = categoriesService.getActiveCategories();
        model.addAttribute("categories", categories);

        return "products";
    }
}
