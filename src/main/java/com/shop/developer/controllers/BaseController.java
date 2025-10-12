package com.shop.developer.controllers;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
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
import org.springframework.web.multipart.MultipartFile;

import com.shop.developer.modules.banner.Impl.BannerService;
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
    private BannerService bannerService;

    @Autowired
    private BannerRespository bannerRespository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private HttpSession httpSession;

    // Các hàm dùng chung cho các controller khác
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
        if (products != null && products.size() >= 100) {
            products = products.subList(0, 100);
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
                .collect(java.util.stream.Collectors.toList());
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
        User user = new User();
        user.setEmail(email);
        user.setPassword(passwordEncoder.encode(password));
        user.setRole(role);
        user.setPhone(phone);
        user.setName(name);
        userRepository.save(user);
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

    @GetMapping("/admin")
    public String adminDashboard(Model model) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        List<Categories> categories = categoriesService.getActiveCategories();
        model.addAttribute("categories", categories);
        return "admin/dashboard/index";
    }

    @GetMapping("/admin/users")
    public String adminUsers(Model model) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        List<User> users = userRepository.findAll();
        List<Categories> categories = categoriesService.getActiveCategories();
        model.addAttribute("categories", categories);
        model.addAttribute("users", users);
        return "admin/users/index";
    }

    @GetMapping("/admin/banners")
    public String adminBanners(Model model) {
        Object users = httpSession.getAttribute("user");
        if(users == null || !(users instanceof com.shop.developer.modules.users.models.User) ||
        !"admin".equals(((com.shop.developer.modules.users.models.User) users).getRole())) {
           return "redirect:/login";
        }
        List<Banner> banners = bannerService.getAllBanners();
        model.addAttribute("banners", banners);
        return "admin/banners/index";
    }

    @GetMapping("/admin/banners/{id}/edit")
    public String editBannerForm(@PathVariable Long id, Model model) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        java.util.Optional<Banner> opt = bannerService.getBannerById(id);
        if (opt.isEmpty()) {
            return "redirect:/admin/banners";
        }
        model.addAttribute("banner", opt.get());
        return "admin/banners/edit";
    }

    // ADMIN: PRODUCTS CRUD
    @GetMapping("/admin/products")
    public String adminProducts(Model model) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        List<Products> products = productsService.getAllProducts();
        List<Categories> categories = categoriesService.getAllCategories();
        model.addAttribute("products", products);
        model.addAttribute("categories", categories);
        return "admin/products/index";
    }

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

    @GetMapping("/admin/products/{id}/delete")
    public String deleteProduct(@PathVariable Long id) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        Optional<Products> opt = productsService.getProductById(id);
        if (opt.isPresent()) {
            Products p = opt.get();
            try {
                String img = p.getImage();
                if (img != null && !img.isBlank()) {
                    Path uploadDir = Paths.get("src/main/webapp/assets/images");
                    Files.createDirectories(uploadDir);
                    Path path = uploadDir.resolve(img);
                    Files.deleteIfExists(path);
                }
            } catch (Exception ignore) {}
            productsService.deleteProduct(id);
        }
        return "redirect:/admin/products";
    }

    @GetMapping("/admin/banners/{id}/delete")
    public String deleteBanner(@PathVariable Long id) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        java.util.Optional<Banner> opt = bannerService.getBannerById(id);
        if (opt.isPresent()) {
            Banner b = opt.get();
            try {
                String img = b.getImage();
                if (img != null && !img.isBlank()) {
                    String realUploadRoot = httpSession.getServletContext().getRealPath("/assets/images");
                    if (realUploadRoot != null) {
                        java.nio.file.Path p = java.nio.file.Paths.get(realUploadRoot).resolve(img);
                        java.nio.file.Files.deleteIfExists(p);
                    }
                }
            } catch (Exception ignore) {}
            bannerService.deleteBanner(id);
        }
        return "redirect:/admin/banners";
    }

    @PostMapping("/admin/banners/{id}/edit")
    public String updateBanner(
        @PathVariable Long id,
        @RequestParam String title,
        @RequestParam(required = false) Boolean status,
        @RequestParam(name = "oldImage", required = false) String oldImage,
        @RequestParam(name = "image", required = false) MultipartFile image
    ) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        java.util.Optional<Banner> opt = bannerService.getBannerById(id);
        if (opt.isEmpty()) {
            return "redirect:/admin/banners";
        }
        Banner banner = opt.get();
        banner.setTitle(title);
        banner.setStatus(status != null ? status : Boolean.FALSE);

        String imageToSave = oldImage;
        try {
            if (image != null && !image.isEmpty()) {
                String original = image.getOriginalFilename();
                String safe = (original == null ? "image" : original).replaceAll("[^a-zA-Z0-9_.-]", "_");
                String filename = System.currentTimeMillis() + "_" + safe;
                String realUploadRoot = httpSession.getServletContext().getRealPath("/assets/images");
                Path uploadDir = Paths.get(realUploadRoot);
                Files.createDirectories(uploadDir);
                Path target = uploadDir.resolve(filename);
                Files.copy(image.getInputStream(), target, StandardCopyOption.REPLACE_EXISTING);
                imageToSave = filename;
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }

        banner.setImage(imageToSave);
        bannerService.saveBanner(banner);
        return "redirect:/admin/banners";
    }
    //create banner 
     @GetMapping("/admin/banners/create")
    public String createBannerForm(Model model) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        Banner banner = new Banner();
        banner.setStatus(Boolean.TRUE);
        model.addAttribute("banner", banner);
        return "admin/banners/create";
    }

    @PostMapping("/admin/banners/create")
    public String storeBanner(
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
            return "redirect:/admin/banner/create";
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
            return "redirect:/admin/banners/create";
        }
        Banner banner = new Banner();
        banner.setTitle(name);
        banner.setImage(filename);
        banner.setStatus(status != null ? status : Boolean.TRUE);
        bannerService.saveBanner(banner);
        return "redirect:/admin/banners";
    }


    @GetMapping("/admin/users/{id}/delete")
    public String deleteUser(@PathVariable Long id) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        if (id != null) {
            userRepository.deleteById(id);
        }
        return "redirect:/admin/users";
    }
}