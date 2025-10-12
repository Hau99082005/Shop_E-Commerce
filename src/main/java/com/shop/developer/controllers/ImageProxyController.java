package com.shop.developer.controllers;

import java.io.IOException;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.StandardCharsets;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ImageProxyController {

    @GetMapping("/img-proxy")
    public ResponseEntity<byte[]> proxyImage(@RequestParam("url") String imageUrl) {
        try {
            // Giải mã URL nếu đã được mã hóa
            String decodedUrl = java.net.URLDecoder.decode(imageUrl, StandardCharsets.UTF_8.name());
            
            // Tạo kết nối đến URL ảnh
            URL url = new URL(decodedUrl);
            URLConnection connection = url.openConnection();
            connection.setRequestProperty("User-Agent", "Mozilla/5.0");
            
            // Đọc dữ liệu ảnh
            try (java.io.InputStream in = connection.getInputStream()) {
                byte[] imageBytes = in.readAllBytes();
                
                // Xác định kiểu MIME
                String contentType = connection.getContentType();
                if (contentType == null || contentType.isEmpty()) {
                    contentType = MediaType.IMAGE_JPEG_VALUE; // Mặc định là JPEG
                }
                
                // Trả về ảnh
                return ResponseEntity.ok()
                        .contentType(MediaType.parseMediaType(contentType))
                        .body(imageBytes);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }
}