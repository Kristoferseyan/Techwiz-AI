package com.example.techwiz.jparepository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.techwiz.model.Categories;


public interface CategoryRepository extends JpaRepository<Categories, Integer> {
    Optional<Categories> findByName(String name);
}
