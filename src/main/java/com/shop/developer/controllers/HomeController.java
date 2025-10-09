package com.shop.developer.controllers;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
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
public class HomeController {
    
    @Autowired
    private CategoriesService categoriesService;
    
    @Autowired
    private ProductsService productsService;
    
    @Autowired
    private BannerRespository bannerRespository;
    
    // Trang chủ - hiển thị danh sách categories và sản phẩm mới nhất
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
    
    // Trang hiển thị danh sách sản phẩm theo category
    @GetMapping("/category/{id}")
    public String categoryProducts(@PathVariable Long id, Model model) {
        // Lấy thông tin category
        Optional<Categories> categoryOpt = categoriesService.getCategoryById(id);
        if (categoryOpt.isEmpty()) {
            return "redirect:/";
        }
        
        Categories category = categoryOpt.get();
        model.addAttribute("category", category);
        
        // Lấy danh sách sản phẩm theo category
        List<Products> products = productsService.getProductsByCategory(id.intValue());
        model.addAttribute("products", products);
        
        // Lấy danh sách categories để hiển thị menu
        List<Categories> categories = categoriesService.getActiveCategories();
        model.addAttribute("categories", categories);
        
        return "category";
    }
    
    // Trang hiển thị chi tiết sản phẩm
    @GetMapping("/product/{id}")
    public String productDetail(@PathVariable Long id, Model model) {
        Optional<Products> productOpt = productsService.getProductById(id);
        if (productOpt.isEmpty()) {
            return "redirect:/";
        }
        
        Products product = productOpt.get();
        model.addAttribute("product", product);
        
        // Lấy danh sách categories để hiển thị menu
        List<Categories> categories = categoriesService.getActiveCategories();
        model.addAttribute("categories", categories);
        
        // Lấy các sản phẩm cùng category (giới hạn 4 sản phẩm)
        List<Products> relatedProducts = productsService.getProductsByCategory(product.getCategory_id().intValue());
        relatedProducts.removeIf(p -> p.getId().equals(id)); // Loại bỏ sản phẩm hiện tại
        if (relatedProducts.size() > 4) {
            relatedProducts = relatedProducts.subList(0, 4);
        }
        model.addAttribute("relatedProducts", relatedProducts);
        
        return "product-detail";
    }
    
    // Trang hiển thị tất cả sản phẩm
    @GetMapping("/products")
    public String allProducts(@RequestParam(required = false) String search, Model model) {
        List<Products> products;
        
        if (search != null && !search.trim().isEmpty()) {
            // Tìm kiếm sản phẩm theo tên (cần implement thêm method trong repository)
            products = productsService.getActiveProducts();
            products = products.stream()
                .filter(p -> p.getName().toLowerCase().contains(search.toLowerCase()))
                .toList();
            model.addAttribute("search", search);
        } else {
            products = productsService.getActiveProducts();
        }
        
        model.addAttribute("products", products);
        
        // Lấy danh sách categories để hiển thị menu
        List<Categories> categories = categoriesService.getActiveCategories();
        model.addAttribute("categories", categories);
        
        return "products";
    }
}
