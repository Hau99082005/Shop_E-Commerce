package com.shop.developer.modules.gallery.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.shop.developer.modules.gallery.models.Gallery;

@Repository
public interface GalleryRepository extends JpaRepository<Gallery, Long> { 
    List<Gallery> findByStatus(Boolean status);
}
