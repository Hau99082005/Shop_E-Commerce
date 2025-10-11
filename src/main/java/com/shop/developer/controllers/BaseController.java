package com.shop.developer.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.developer.modules.banner.models.Banner;
import com.shop.developer.modules.banner.repositories.BannerRespository;
import com.shop.developer.modules.categories.Impl.CategoriesService;
import com.shop.developer.modules.categories.models.Categories;
import com.shop.developer.modules.products.Impl.ProductsService;
import com.shop.developer.modules.products.models.Products;
import com.shop.developer.modules.users.models.User;
import com.shop.developer.modules.users.repositories.UserRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class BaseController {

    @Autowired
    private CategoriesService categoriesService;

    @Autowired
    private ProductsService productsService;

    @Autowired
    private BannerRespository bannerRespository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private HttpSession httpSession;

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

        // Lấy danh sách sản phẩm: ưu tiên active, nếu rỗng thì lấy tất cả để đảm bảo hiển thị
        List<Products> products = productsService.getActiveProducts();
        if (products == null || products.isEmpty()) {
            products = productsService.getAllProducts();
        }
        if (products != null && products.size() > 8) {
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

    @GetMapping("/categories")
    public String allCategories(Model model) {
        List<Categories> categories = categoriesService.getActiveCategories();
        model.addAttribute("categories", categories);
        return "categories"; // Renders WEB-INF/views/categories.jsp
    }

    @GetMapping("/login")
    public String login(Model model) {
        List<Categories> categories = categoriesService.getActiveCategories();
        model.addAttribute("categories", categories);
        return "login"; // Renders WEB-INF/views/login.jsp
    }

    @GetMapping("/register")
    public String register(Model model) {
        List<Categories> categories = categoriesService.getActiveCategories();
        model.addAttribute("categories", categories);
        return "register"; // Renders WEB-INF/views/register.jsp
    }

    @PostMapping("/register")
    public String handleRegister(
        @RequestParam String email,
        @RequestParam String password,
        @RequestParam String confirm,
        @RequestParam(required = false, defaultValue = "user") String role,
        @RequestParam String phone,
        @RequestParam(required = false) String name,
        Model model
    ) {
        if (!password.equals(confirm)) {
            model.addAttribute("error", "Mật khẩu nhập lại không khớp");
            return "register";
        }
        if (userRepository.findByEmail(email).isPresent()) {
            model.addAttribute("error", "Email đã tồn tại");
            return "register";
        }
        // Create user
        User user = new User();
        user.setEmail(email);
        user.setPassword(passwordEncoder.encode(password));
        user.setRole(role);
        user.setPhone(phone);
        user.setName(name);
        userRepository.save(user);

        // Auto login -> set session and go home
        httpSession.setAttribute("user", user);
        return "redirect:/";
    }

    @PostMapping("/login")
    public String handleLogin(
        @RequestParam String email,
        @RequestParam String password,
        Model model
    ) {
        Optional<User> userOpt = userRepository.findByEmail(email);
        if (userOpt.isEmpty()) {
            model.addAttribute("error", "Tài khoản không tồn tại");
            return "login";
        }
        User user = userOpt.get();
        if (!passwordEncoder.matches(password, user.getPassword())) {
            model.addAttribute("error", "Mật khẩu không đúng");
            return "login";
        }
        httpSession.setAttribute("user", user);
        return "redirect:/";
    }

    @GetMapping("/logout")
    public String handleLogout() {
        httpSession.invalidate();
        return "redirect:/login";
    }
}