package com.shop.developer.modules.banner.repositories;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.shop.developer.modules.banner.models.Banner;

@Repository
public interface  BannerRespository extends JpaRepository<Banner, Long> {
    List<Banner> findByStatus(Boolean status);
}
