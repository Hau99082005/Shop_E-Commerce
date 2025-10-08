package com.shop.developer.modules.categories.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.shop.developer.modules.categories.models.Categories;
import java.util.List;

@Repository
public interface CategoriesRepository extends JpaRepository<Categories, Long> {
    List<Categories> findByStatus(Boolean status);
}
