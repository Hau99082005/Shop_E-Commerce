package com.shop.developer.modules.gallery.controllers;

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

import com.shop.developer.modules.gallery.Impl.GalleryService;
import com.shop.developer.modules.gallery.models.Gallery;



@RestController
@RequestMapping("/api/gallery")
@CrossOrigin(origins = "*") // Cho phép gọi từ frontend hoặc Postman

public class GalleryController {
    @Autowired
    private GalleryService galleryService;

    // Lấy tất cả gallery
    @GetMapping
    public List<Gallery> getAllGallerys() {
        return galleryService.getAllGallerys();
    }

    // Lấy gallery theo ID
    @GetMapping("/{id}")
    public Gallery getGalleryById(@PathVariable Long id) {
        return galleryService.getGalleryById(id).orElse(null);
    }

    // Tạo mới gallery
    @PostMapping
    public Gallery createGallery(@RequestBody Gallery gallery) {
        return galleryService.saveGallery(gallery);
    }

    // Cập nhật gallery
    @PutMapping("/{id}")
    public Gallery updateGallery(@PathVariable Long id, @RequestBody Gallery gallery) {
        gallery.setId(id);
        return galleryService.saveGallery(gallery);
    }

    // Xóa gallery
    @DeleteMapping("/{id}")
    public void deleteGallery(@PathVariable Long id) {
        galleryService.deleteGallery(id);
    }
}
