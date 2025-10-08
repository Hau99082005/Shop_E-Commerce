package com.shop.developer.databases.seeders;
import java.util.Arrays;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.shop.developer.modules.banner.models.Banner;
import com.shop.developer.modules.categories.models.Categories;
import com.shop.developer.modules.gallery.models.Gallery;
import com.shop.developer.modules.products.models.Products;
import com.shop.developer.modules.users.models.User;
import com.shop.developer.modules.users.repositories.UserRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Component
public class DatabaseSeeders implements CommandLineRunner {

    private static final Logger logger = LoggerFactory.getLogger(DatabaseSeeders.class);

    @PersistenceContext
    private EntityManager entityManager;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserRepository userRepository;

    @Transactional
    @Override
    public void run(String... args) throws Exception {
         ////cách 1:
        //     entityManager.createNativeQuery("INSERT INTO users(email, password, phone, address, image, role) VALUES(?,?,?,?,?,?)")
        //     .setParameter(1, "hau99082005@gmail.com")
        //     .setParameter(2, passwordEncode)
        //     .setParameter(3, "0367722389")
        //     .setParameter(4, "Thôn Thống Nhất - Xã Hải Bình - Tỉnh Quảng Trị")
        //     .setParameter(5, "")
        //     .setParameter(6, "admin")
        //     .executeUpdate();

        //  System.out.println("password:...."+passwordEncode); 
         
        ////cách 2:
        // User user = new User();
        // user.setEmail("hau99082005@gmail.com");
        // user.setPassword(passwordEncode);
        // user.setPhone("0367722389");
        // user.setAddress("Thôn Thống Nhất - Xã Hải Bình - Tỉnh Quảng Trị");
        // user.setImage("");
        // user.setRole("admin");
        // entityManager.persist(user);
        ////cách 3: 
        // User user = new User();
        // user.setEmail("hau99082005@gmail.com");
        // user.setPassword(passwordEncode);
        // user.setPhone("0367722389");
        // user.setAddress("Thôn Thống Nhất - Xã Hải Bình - Tỉnh Quảng Trị");
        // user.setImage("");
        // user.setRole("admin");
        // userRepository.save(user); //phuowng thức save() này dùng để truyền vào 1 đối tượng entity(có thể là model) để lưu vào database

        // Seed user
        if (isUserTableEmpty()) {
            String password = "22082005";
            User user = new User();
            user.setEmail("hau99082005@gmail.com");
            user.setName("Lê Văn Hậu");
            user.setPassword(passwordEncoder.encode(password));
            user.setPhone("0367722389");
            user.setAddress("Thôn Thống Nhất - Xã Hải Bình - Tỉnh Quảng Trị");
            user.setImage("");
            user.setRole("admin");
            userRepository.save(user);
            logger.info("✅ Seeding user data completed.");
        }

        // Seed categories
        if (isCategoriesTableEmpty()) {
            List<Categories> categoriesList = Arrays.asList(
                new Categories(null, "Điện thoại & Phụ Kiện", "31234a27876fb89cd522d7e3db1ba5ca@resize_w640_nl.webp", true),
                new Categories(null, "Thời trang Nam", "687f3967b7c2fe6a134a2c11894eea4b@resize_w640_nl.webp", true),
                new Categories(null, "Thiết bị điện tử", "978b9e4cb61c611aaaf58664fae133c5@resize_w640_nl.webp", true),
                new Categories(null, "Máy tính & Laptop", "c3f3edfaa9f6dafc4825b77d8449999d@resize_w640_nl.webp", true),
                new Categories(null, "Máy ảnh và Máy quay phim", "ec14dd4fc238e676e43be2a911414d4d@resize_w640_nl.webp", true)
            );

            for (Categories c : categoriesList) {
                entityManager.persist(c);
            }

            logger.info("✅ Seeding categories data completed.");
        }

        //seed products
        if(isProductsTableEmpty()) {
           List<Products> productsList = Arrays.asList(
            new Products(null,"Áo thun body nam cổ tròn FLOMAN ver1 chất thun gân, áo thun thể thao gym form tôn dáng", "vn-11134207-7ras8-m111t8urpdejc0.webp", "Thiết kế lên form, không dư thừa, và đường chỉ sắc nét cùng bo viền không lộ, sản phẩm mang lại sự khoẻ khoắn và thoải mái cho người mặc.", 300.000, 400.000, 100, 100, 2, true),
            new Products(null,"Áo thun body nam cổ tròn FLOMAN ver1 chất thun gân, áo thun thể thao gym form tôn dáng", "vn-11134207-7ras8-m111t8urpdejc0.webp", "Thiết kế lên form, không dư thừa, và đường chỉ sắc nét cùng bo viền không lộ, sản phẩm mang lại sự khoẻ khoắn và thoải mái cho người mặc.", 300.000, 400.000, 100, 100, 2, true),
            new Products(null,"Áo thun body nam cổ tròn FLOMAN ver1 chất thun gân, áo thun thể thao gym form tôn dáng", "vn-11134207-7ras8-m111t8urpdejc0.webp", "Thiết kế lên form, không dư thừa, và đường chỉ sắc nét cùng bo viền không lộ, sản phẩm mang lại sự khoẻ khoắn và thoải mái cho người mặc.", 300.000, 400.000, 100, 100, 2, true),
            new Products(null,"Áo thun body nam cổ tròn FLOMAN ver1 chất thun gân, áo thun thể thao gym form tôn dáng", "vn-11134207-7ras8-m111t8urpdejc0.webp", "Thiết kế lên form, không dư thừa, và đường chỉ sắc nét cùng bo viền không lộ, sản phẩm mang lại sự khoẻ khoắn và thoải mái cho người mặc.", 300.000, 400.000, 100, 100, 2, true),
            new Products(null,"Áo thun body nam cổ tròn FLOMAN ver1 chất thun gân, áo thun thể thao gym form tôn dáng", "vn-11134207-7ras8-m111t8urpdejc0.webp", "Thiết kế lên form, không dư thừa, và đường chỉ sắc nét cùng bo viền không lộ, sản phẩm mang lại sự khoẻ khoắn và thoải mái cho người mặc.", 300.000, 400.000, 100, 100, 2, true),
            new Products(null,"Áo thun body nam cổ tròn FLOMAN ver1 chất thun gân, áo thun thể thao gym form tôn dáng", "vn-11134207-7ras8-m111t8urpdejc0.webp", "Thiết kế lên form, không dư thừa, và đường chỉ sắc nét cùng bo viền không lộ, sản phẩm mang lại sự khoẻ khoắn và thoải mái cho người mặc.", 300.000, 400.000, 100, 100, 2, true),
            new Products(null,"Áo thun body nam cổ tròn FLOMAN ver1 chất thun gân, áo thun thể thao gym form tôn dáng", "vn-11134207-7ras8-m111t8urpdejc0.webp", "Thiết kế lên form, không dư thừa, và đường chỉ sắc nét cùng bo viền không lộ, sản phẩm mang lại sự khoẻ khoắn và thoải mái cho người mặc.", 300.000, 400.000, 100, 100, 2, true),
            new Products(null,"Áo thun body nam cổ tròn FLOMAN ver1 chất thun gân, áo thun thể thao gym form tôn dáng", "vn-11134207-7ras8-m111t8urpdejc0.webp", "Thiết kế lên form, không dư thừa, và đường chỉ sắc nét cùng bo viền không lộ, sản phẩm mang lại sự khoẻ khoắn và thoải mái cho người mặc.", 300.000, 400.000, 100, 100, 2, true),
            new Products(null,"Áo thun body nam cổ tròn FLOMAN ver1 chất thun gân, áo thun thể thao gym form tôn dáng", "vn-11134207-7ras8-m111t8urpdejc0.webp", "Thiết kế lên form, không dư thừa, và đường chỉ sắc nét cùng bo viền không lộ, sản phẩm mang lại sự khoẻ khoắn và thoải mái cho người mặc.", 300.000, 400.000, 100, 100, 2, true),
            new Products(null,"Áo thun body nam cổ tròn FLOMAN ver1 chất thun gân, áo thun thể thao gym form tôn dáng", "vn-11134207-7ras8-m111t8urpdejc0.webp", "Thiết kế lên form, không dư thừa, và đường chỉ sắc nét cùng bo viền không lộ, sản phẩm mang lại sự khoẻ khoắn và thoải mái cho người mặc.", 300.000, 400.000, 100, 100, 2, true),
            new Products(null,"Áo thun body nam cổ tròn FLOMAN ver1 chất thun gân, áo thun thể thao gym form tôn dáng", "vn-11134207-7ras8-m111t8urpdejc0.webp", "Thiết kế lên form, không dư thừa, và đường chỉ sắc nét cùng bo viền không lộ, sản phẩm mang lại sự khoẻ khoắn và thoải mái cho người mặc.", 300.000, 400.000, 100, 100, 2, true),
            new Products(null,"Áo thun body nam cổ tròn FLOMAN ver1 chất thun gân, áo thun thể thao gym form tôn dáng", "vn-11134207-7ras8-m111t8urpdejc0.webp", "Thiết kế lên form, không dư thừa, và đường chỉ sắc nét cùng bo viền không lộ, sản phẩm mang lại sự khoẻ khoắn và thoải mái cho người mặc.", 300.000, 400.000, 100, 100, 2, true),
            new Products(null,"Áo thun body nam cổ tròn FLOMAN ver1 chất thun gân, áo thun thể thao gym form tôn dáng", "vn-11134207-7ras8-m111t8urpdejc0.webp", "Thiết kế lên form, không dư thừa, và đường chỉ sắc nét cùng bo viền không lộ, sản phẩm mang lại sự khoẻ khoắn và thoải mái cho người mặc.", 300.000, 400.000, 100, 100, 2, true),
            new Products(null,"Áo thun body nam cổ tròn FLOMAN ver1 chất thun gân, áo thun thể thao gym form tôn dáng", "vn-11134207-7ras8-m111t8urpdejc0.webp", "Thiết kế lên form, không dư thừa, và đường chỉ sắc nét cùng bo viền không lộ, sản phẩm mang lại sự khoẻ khoắn và thoải mái cho người mặc.", 300.000, 400.000, 100, 100, 2, true)
           );

           for(Products p: productsList) {
            entityManager.persist(p);
           }

            logger.info("seeding products data completed.");
        }

        //seed gallery
        if(isGalleryTableEmpty()) {
            List<Gallery> galleryList = Arrays.asList(
                new Gallery(null, "vn-11134207-7ras8-m1pdq91ripg325.webp", 2),
                new Gallery(null, "vn-11134207-7ras8-m1pdq91rfwlbc4.webp", 2),
                new Gallery(null, "vn-11134207-7ras8-m3ahsqeyb9y9d5.webp", 2),
                new Gallery(null, "vn-11134207-7ras8-m1pdq91r8vgzc0.webp", 2),
                new Gallery(null, "vn-11134207-7ras8-m1pdq92v8nkja3.webp", 2),
                new Gallery(null, "vn-11134207-7ras8-m1pdq91rd36bf4.webp", 2),
                new Gallery(null, "vn-11134207-7r98o-lybna3p25oi53b.webp", 2)
            );

            for(Gallery g: galleryList) {
                entityManager.persist(g);
            }
            logger.info("seeding gallery data completed");
        }
        //seed banner
        if (isBannerTableEmpty()) {
        List<Banner> bannerList = Arrays.asList(
        new Banner(null, "banner", "banner.png", true),
        new Banner(null, "banner", "banner1.png", true),
        new Banner(null, "banner", "banner2.png", true)
      );

    for (Banner banner : bannerList) {
        entityManager.persist(banner);
    }

    logger.info("Seeding banner data completed");
     }

    }

    private boolean isUserTableEmpty() {
        Long count = (Long) entityManager.createQuery("SELECT COUNT(u.id) FROM User u").getSingleResult();
        return count == 0;
    }

    private boolean isCategoriesTableEmpty() {
        Long count = (Long) entityManager.createQuery("SELECT COUNT(c.id) FROM Categories c").getSingleResult();
        return count == 0;
    }

    private boolean isProductsTableEmpty() {
        Long count = (Long) entityManager.createQuery("SELECT COUNT(p.id) FROM Products p").getSingleResult();
        return count == 0;
    }

   private boolean isBannerTableEmpty() {
    Long count = (Long) entityManager.createQuery("SELECT COUNT(b) FROM Banner b").getSingleResult();
    return count == 0;
}


    private boolean isGalleryTableEmpty() {
        Long count = (Long) entityManager.createQuery("SELECT COUNT(g.id) FROM Gallery g").getSingleResult();
        return count == 0;
    }
}
