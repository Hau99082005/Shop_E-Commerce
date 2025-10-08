package com.shop.developer.modules.products.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.shop.developer.modules.products.models.Products;
import java.util.List;

@Repository
public interface ProductsRepository extends JpaRepository<Products, Long> {
    List<Products> findByStatus(Boolean status);
    
    @Query("SELECT p FROM Products p WHERE p.category_id = :categoryId")
    List<Products> findByCategoryId(@Param("categoryId") Integer categoryId);
    
    @Query("SELECT p FROM Products p WHERE p.status = :status AND p.category_id = :categoryId")
    List<Products> findByStatusAndCategoryId(@Param("status") Boolean status, @Param("categoryId") Integer categoryId);
}
