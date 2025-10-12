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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.shop.developer.modules.banner.Impl.BannerService;
import com.shop.developer.modules.banner.models.Banner;

import jakarta.servlet.http.HttpSession;

@Controller
public class EditBanner {

    @Autowired
    private BannerService bannerService;

    @Autowired
    private HttpSession httpSession;

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
}