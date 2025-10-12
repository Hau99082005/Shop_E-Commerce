package com.shop.developer.admin.Banners;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.shop.developer.modules.banner.Impl.BannerService;
import com.shop.developer.modules.banner.models.Banner;

import jakarta.servlet.http.HttpSession;

@Controller
public class IndexBanner {

    @Autowired
    private BannerService bannerService;

    @Autowired
    private HttpSession httpSession;

    @GetMapping("/admin/banners")
    public String adminBanners(Model model) {
        Object users = httpSession.getAttribute("user");
        if(users == null || !(users instanceof com.shop.developer.modules.users.models.User) ||
        !"admin".equals(((com.shop.developer.modules.users.models.User) users).getRole())) {
           return "redirect:/login";
        }
        model.addAttribute("banners", bannerService.getAllBanners());
        return "admin/banners/index";
    }

    @GetMapping("/admin/banners/{id}/toggle")
    public String toggleBanner(@PathVariable Long id) {
        Object u = httpSession.getAttribute("user");
        if (u == null || !(u instanceof com.shop.developer.modules.users.models.User) ||
            !"admin".equals(((com.shop.developer.modules.users.models.User) u).getRole())) {
            return "redirect:/login";
        }
        java.util.Optional<Banner> opt = bannerService.getBannerById(id);
        if (opt.isPresent()) {
            Banner b = opt.get();
            b.setStatus(Boolean.TRUE.equals(b.getStatus()) ? Boolean.FALSE : Boolean.TRUE);
            bannerService.saveBanner(b);
        }
        return "redirect:/admin/banners";
    }
}
