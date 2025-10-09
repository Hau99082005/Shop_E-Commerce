package com.shop.developer.modules.gallery.Impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.shop.developer.modules.gallery.models.Gallery;
import com.shop.developer.modules.gallery.repositories.GalleryRepository;



@RestController
@RequestMapping("/api/gallery")
@CrossOrigin(origins = "*") // Cho phép gọi từ frontend hoặc Postman
@Service
public class GalleryService {
    @Autowired
    private GalleryRepository galleryRepository;
    
    public List<Gallery> getAllGallerys() { //lấy tất cả nhiều ảnh của sản phẩm 
        return galleryRepository.findAll();
    }
    
    public List<Gallery> getActiveGallerys() {
        return galleryRepository.findByStatus(true); //lấy danh sách ảnh từ trạng thái 
    }
    
    public Optional<Gallery> getGalleryById(Long id) {
        return galleryRepository.findById(id); // lấy danh sách nhiều ảnh từ id sản phẩm
    }
    
    public Gallery saveGallery(Gallery gallery) {
        return galleryRepository.save(gallery);
    }
    
    public void deleteGallery(Long id) {
        galleryRepository.deleteById(id);
    }
}
