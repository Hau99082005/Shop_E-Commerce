package com.shop.developer;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.shop.developer.modules.categories.Impl.CategoriesService;
import com.shop.developer.modules.categories.models.Categories;
import com.shop.developer.modules.products.Impl.ProductsService;
import com.shop.developer.modules.products.models.Products;

@Controller
public class ProductsDetails {

    @Autowired
    private ProductsService productsService;

    @Autowired
    private CategoriesService categoriesService;

    @GetMapping("/product/{id}")
    public String detail(@PathVariable Long id, Model model) {
        Optional<Products> productOpt = productsService.getProductById(id);
        if (productOpt.isEmpty()) {
            return "redirect:/";
        }

        Products product = productOpt.get();
        model.addAttribute("product", product);

        List<Categories> categories = categoriesService.getActiveCategories();
        model.addAttribute("categories", categories);

        List<Products> relatedProducts = productsService.getProductsByCategory(product.getCategory_id());
        relatedProducts.removeIf(p -> p.getId().equals(id));
        if (relatedProducts.size() > 8) {
            relatedProducts = relatedProducts.subList(0, 8);
        }
        model.addAttribute("relatedProducts", relatedProducts);

        // Optionally, if you add a gallery service later:
        // model.addAttribute("galleryList", galleryService.findByProductId(product.getId()));

        return "product-detail";
    }
}