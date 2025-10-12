package com.shop.developer.admin.Banners;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.shop.developer.modules.banner.Impl.BannerService;
import com.shop.developer.modules.banner.models.Banner;

import jakarta.servlet.http.HttpSession;

@Controller
public class DeleteBanner {

    @Autowired
    private BannerService bannerService;

    @Autowired
    private HttpSession httpSession;

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
}