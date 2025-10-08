package com.shop.developer.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Cấu hình để truy cập static resources từ webapp (ưu tiên cao nhất)
        registry.addResourceHandler("/assets/**")
                .addResourceLocations("/assets/", "classpath:/static/assets/")
                .setCachePeriod(3600);
        
        registry.addResourceHandler("/images/**")
                .addResourceLocations("/images/", "classpath:/static/images/")
                .setCachePeriod(3600);
        
        // Fallback cho static resources
        registry.addResourceHandler("/css/**")
                .addResourceLocations("classpath:/static/css/");
        
        registry.addResourceHandler("/js/**")
                .addResourceLocations("classpath:/static/js/");
    }
}
