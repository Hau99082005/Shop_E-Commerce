package com.shop.developer.modules.categories.controllers;

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

import com.shop.developer.modules.categories.models.Categories;
import com.shop.developer.modules.categories.services.CategoriesService;

@RestController
@RequestMapping("/categories")
@CrossOrigin(origins = "*") // Cho phép gọi từ frontend hoặc Postman
public class CategoriesController {

    @Autowired
    private CategoriesService categoriesService;

    // Lấy tất cả categories
    @GetMapping
    public List<Categories> getAllCategories() {
        return categoriesService.getAllCategories();
    }

    // Lấy category theo ID
    @GetMapping("/{id}")
    public Categories getCategoryById(@PathVariable Long id) {
        return categoriesService.getCategoryById(id).orElse(null);
    }

    // Tạo mới category
    @PostMapping
    public Categories createCategory(@RequestBody Categories category) {
        return categoriesService.saveCategory(category);
    }

    // Cập nhật category
    @PutMapping("/{id}")
    public Categories updateCategory(@PathVariable Long id, @RequestBody Categories category) {
        category.setId(id);
        return categoriesService.saveCategory(category);
    }

    // Xóa category
    @DeleteMapping("/{id}")
    public void deleteCategory(@PathVariable Long id) {
        categoriesService.deleteCategory(id);
    }
}
