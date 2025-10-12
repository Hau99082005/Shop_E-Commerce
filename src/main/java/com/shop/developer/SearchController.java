package com.shop.developer;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.developer.modules.categories.Impl.CategoriesService;
import com.shop.developer.modules.categories.models.Categories;
import com.shop.developer.modules.products.Impl.ProductsService;
import com.shop.developer.modules.products.models.Products;

@Controller
public class SearchController {

    @Autowired
    private ProductsService productsService;

    @Autowired
    private CategoriesService categoriesService;

    @GetMapping("/search")
    public String search(
        @RequestParam(required = false) String keyword,
        @RequestParam(required = false, name = "categoryId") Integer categoryId,
        Model model
    ) {
        String k = (keyword != null) ? keyword.trim() : "";
        List<Products> results = new ArrayList<>();

        if (!k.isEmpty()) {
            List<Products> source;
            if (categoryId == null || categoryId == 0) {
                source = productsService.getActiveProducts();
                if (source == null || source.isEmpty()) {
                    source = productsService.getAllProducts();
                }
            } else {
                source = productsService.getProductsByCategory(categoryId);
            }

            final String kw = k.toLowerCase(java.util.Locale.ROOT);
            if (source != null) {
                for (Products p : source) {
                    if (p.getName() != null && p.getName().toLowerCase(java.util.Locale.ROOT).contains(kw)) {
                        results.add(p);
                    }
                }
            }
        }

        List<Categories> categories = categoriesService.getActiveCategories();
        model.addAttribute("categories", categories);
        model.addAttribute("productList", results);
        model.addAttribute("keyword", k);
        model.addAttribute("categoryId", categoryId);
        return "search"; // Renders WEB-INF/views/search.jsp
    }
}