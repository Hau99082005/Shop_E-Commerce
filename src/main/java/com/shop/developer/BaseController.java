package com.shop.developer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class BaseController {

    private final JdbcTemplate jdbcTemplate;
    @Autowired
    public BaseController(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @GetMapping("/home")
    public String home() {
      String sql = """
    CREATE TABLE IF NOT EXISTS blog_detail (
        id INT PRIMARY KEY AUTO_INCREMENT,
        blog_id INT NOT NULL,
        content TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (blog_id) REFERENCES blog(id) ON DELETE CASCADE
    )
    """;
        jdbcTemplate.execute(sql);
        return "Đã tạo bảng blog thành công!";
    }
}
