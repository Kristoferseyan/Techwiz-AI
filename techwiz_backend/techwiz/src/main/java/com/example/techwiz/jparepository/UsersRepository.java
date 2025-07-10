package com.example.techwiz.jparepository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.techwiz.model.Users;


public interface UsersRepository extends JpaRepository<Users, String>{
    Optional<Users> findByUsername(String username);
}
