package com.shop.developer.modules.categories.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shop.developer.modules.categories.models.Categories;
import com.shop.developer.modules.categories.repositories.CategoriesRepository;
import java.util.List;
import java.util.Optional;

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
