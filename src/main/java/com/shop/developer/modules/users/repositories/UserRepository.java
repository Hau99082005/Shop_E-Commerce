package com.shop.developer.modules.users.repositories;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.shop.developer.modules.users.models.User;


@Repository
public interface UserRepository extends JpaRepository<User, Long>{
    Optional<User> findByEmail(String email);
}
