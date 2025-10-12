package com.shop.developer.admin.Banners;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.shop.developer.modules.banner.Impl.BannerService;

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
}
