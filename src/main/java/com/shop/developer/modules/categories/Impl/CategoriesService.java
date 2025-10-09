package com.shop.developer.modules.categories.Impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.shop.developer.modules.categories.models.Categories;
import com.shop.developer.modules.categories.repositories.CategoriesRepository;
@RestController
@RequestMapping("/categories")
@CrossOrigin(origins = "*") // Cho phép gọi từ frontend hoặc Postman
@Service
public class CategoriesService {
    
    @Autowired
    private CategoriesRepository categoriesRepository;
    
    public List<Categories> getAllCategories() {
        return categoriesRepository.findAll();
    }
    
    public List<Categories> getActiveCategories() {
        return categoriesRepository.findByStatus(true);
    }
    
    public Optional<Categories> getCategoryById(Long id) {
        return categoriesRepository.findById(id);
    }
    
    public Categories saveCategory(Categories category) {
        return categoriesRepository.save(category);
    }
    
    public void deleteCategory(Long id) {
        categoriesRepository.deleteById(id);
    }
}
