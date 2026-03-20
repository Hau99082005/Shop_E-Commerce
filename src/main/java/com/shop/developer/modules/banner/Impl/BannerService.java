package com.shop.developer.modules.banner.Impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.developer.modules.banner.models.Banner;
import com.shop.developer.modules.banner.repositories.BannerRespository;



@Service
public class BannerService {
     @Autowired
    private BannerRespository bannerRespository;
    
    public List<Banner> getAllBanners() {
        return bannerRespository.findAll();
    }
    
    public List<Banner> getActiveBanners() {
        return bannerRespository.findByStatus(true);
    }
    
    public Optional<Banner> getBannerById(Long id) {
        return bannerRespository.findById(id);
    }
    
    public Banner saveBanner(Banner banner) {
        return bannerRespository.save(banner);
    }
    
    public void deleteBanner(Long id) {
        bannerRespository.deleteById(id);
    }
}
