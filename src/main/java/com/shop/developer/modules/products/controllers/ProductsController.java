package com.shop.developer.modules.products.controllers;

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

import com.shop.developer.modules.products.models.Products;
import com.shop.developer.modules.products.services.ProductsService;


@RestController
@RequestMapping("/api/products")
@CrossOrigin(origins = "*") 
public class ProductsController {
     @Autowired
    private ProductsService productsService;

    // Lấy tất cả products
    @GetMapping
    public List<Products> getAllProducts() {
        return productsService.getAllProducts();
    }

    // Lấy products theo ID
    @GetMapping("/{id}")
    public Products getProductsById(@PathVariable Long id) {
        return productsService.getProductById(id).orElse(null);
    }

    // Tạo mới products
    @PostMapping
    public Products createProducts(@RequestBody Products products) {
        return productsService.saveProduct(products);
    }

    // Cập nhật products
    @PutMapping("/{id}")
    public Products updateProducts(@PathVariable Long id, @RequestBody Products products) {
        products.setId(id);
        return productsService.saveProduct(products);
    }

    // Xóa products
    @DeleteMapping("/{id}")
    public void deleteProducts(@PathVariable Long id) {
        productsService.deleteProduct(id);
    }
    
}
