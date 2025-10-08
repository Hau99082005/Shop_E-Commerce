package com.shop.developer.modules.products.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shop.developer.modules.products.models.Products;
import com.shop.developer.modules.products.repositories.ProductsRepository;
import java.util.List;
import java.util.Optional;

@Service
public class ProductsService {
    
    @Autowired
    private ProductsRepository productsRepository;
    
    public List<Products> getAllProducts() {
        return productsRepository.findAll();
    }
    
    public List<Products> getActiveProducts() {
        return productsRepository.findByStatus(true);
    }
    
    public List<Products> getProductsByCategory(Integer categoryId) {
        return productsRepository.findByStatusAndCategoryId(true, categoryId);
    }
    
    public Optional<Products> getProductById(Long id) {
        return productsRepository.findById(id);
    }
    
    public Products saveProduct(Products product) {
        return productsRepository.save(product);
    }
    
    public void deleteProduct(Long id) {
        productsRepository.deleteById(id);
    }
}
