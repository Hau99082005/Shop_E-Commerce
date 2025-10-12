package com.shop.developer.admin.Banners;

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

import com.shop.developer.modules.banner.Impl.BannerService;
import com.shop.developer.modules.banner.models.Banner;

import jakarta.servlet.http.HttpSession;

@Controller
public class CreateBanner {

    @Autowired
    private BannerService bannerService;

    @Autowired
    private HttpSession httpSession;

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
}