package com.shop.developer.modules.banner.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.shop.developer.modules.banner.Impl.BannerService;
import com.shop.developer.modules.banner.models.Banner;


@RestController
@RequestMapping("/api/banner")
@CrossOrigin(origins = "*") // Cho phép gọi từ frontend(client) hoặc Postman
public class BannerController {
    @Autowired
    private BannerService bannerService;

    // Lấy tất cả banners
    @GetMapping
    public List<Banner> getAllBanners() {
        return bannerService.getAllBanners();
    }

    // Lấy banners đang hoạt động
    @GetMapping("/active")
    public List<Banner> getActiveBanners() {
        return bannerService.getActiveBanners();
    }

    // Lấy banners theo ID
    @GetMapping("/{id}")
    public Banner getBannerById(@PathVariable Long id) {
        return bannerService.getBannerById(id).orElse(null);
    }

    // Tạo mới banners
    @PostMapping
    public Banner createBanner(@RequestBody Banner banner) {
        return bannerService.saveBanner(banner);
    }

    // Cập nhật banner
    @PutMapping("/{id}")
    public Banner updateBanner(@PathVariable Long id, @RequestBody Banner banner) {
        banner.setId(id);
        return bannerService.saveBanner(banner);
    }

    // Xóa banner
    @DeleteMapping("/{id}")
    public void deleteBanner(@PathVariable Long id) {
        bannerService.deleteBanner(id);
    }
}
