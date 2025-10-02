package com.shop.developer.databases.seeders;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.shop.developer.modules.categories.models.Categories;
import com.shop.developer.modules.users.models.User;
import com.shop.developer.modules.users.repositories.UserRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Component
public class DatabaseSeeders implements CommandLineRunner{

    private static final Logger logger = LoggerFactory.getLogger(DatabaseSeeders.class);

     @PersistenceContext
     private EntityManager entityManager;

     @Autowired
     private PasswordEncoder passwordEncoder;
     
    @Autowired
    private UserRepository userRepository; //trường hợp nếu k sử dụng autowired thì sử dụng khai báo contructor
    // public DatabaseSeeders(UserRepository userRepository) {
    //     super();
    //     this.userRepository = userRepository;
    // }

    @Transactional
    @Override
    public void run(String... args) throws Exception {
      
        if(isTableEmpty()) {
            String password = "22082005";
            String passwordEncode = passwordEncoder.encode(password);
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

        ////cách 4: truyền dữ liệu có tham số vào users
        User user = new User("Hau99082005@gmail.com", passwordEncode, "0367722389", "Thôn Thống Nhất - Xã Hải Bình - Tỉnh Quảng Trị", "", "admin");
        userRepository.save(user); //Phương thức user dùng để lưu 1 đối tượng entity(có thể là model) vào database
        logger.info("Seeding user data completed.");   
    }

    if (isCategoriesTableEmpty()) {
    Categories category = new Categories();
    category.setName("Thời trang nam");
    category.setThumbnail("687f3967b7c2fe6a134a2c11894eea4b@resize_w640_nl.webp");
    category.setStatus(true);
    entityManager.persist(category); // hoặc dùng repository
    logger.info("✅ Seeding categories completed.");
}
    }

    private boolean isTableEmpty() {
        Long count = (Long) entityManager.createQuery("SELECT COUNT(id) FROM User").getSingleResult();
        return count == 0;
    }
    private boolean isCategoriesTableEmpty() {
    Long count = (Long) entityManager.createQuery("SELECT COUNT(c.id) FROM Categories c").getSingleResult();
    return count == 0;
}
}
