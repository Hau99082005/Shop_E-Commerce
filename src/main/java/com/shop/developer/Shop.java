package com.shop.developer;

import java.util.ArrayList;
import java.util.Collections;
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
public class Shop {

    @Autowired
    private ProductsService productsService;

    @Autowired
    private CategoriesService categoriesService;

    @GetMapping("/shop")
    public String shop(
            @RequestParam(name = "categoryId", required = false) Integer categoryId,
            @RequestParam(name = "page", required = false, defaultValue = "1") Integer page,
            Model model) {

        List<Products> source;
        if (categoryId == null || categoryId == 0) {
            source = productsService.getActiveProducts();
            if (source == null || source.isEmpty()) {
                source = productsService.getAllProducts();
            }
        } else {
            source = productsService.getProductsByCategory(categoryId);
        }
        if (source == null) source = new ArrayList<>();

        final int pageSize = 12;
        int total = source.size();
        int numberPage = (int) Math.ceil(total / (double) pageSize);
        if (numberPage == 0) numberPage = 1;
        if (page == null || page < 1) page = 1;
        if (page > numberPage) page = numberPage;

        int from = Math.max(0, (page - 1) * pageSize);
        int to = Math.min(total, from + pageSize);
        List<Products> productsPage = (from < to) ? source.subList(from, to) : Collections.emptyList();

        List<Categories> categories = categoriesService.getActiveCategories();
        model.addAttribute("categories", categories);
        model.addAttribute("productList", productsPage);
        model.addAttribute("page", page);
        model.addAttribute("total", total);
        model.addAttribute("numberPage", numberPage);
        model.addAttribute("categoryId", categoryId);

        return "shop"; // Renders WEB-INF/views/shop.jsp
    }

}
