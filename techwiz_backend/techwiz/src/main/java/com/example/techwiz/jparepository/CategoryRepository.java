package com.example.techwiz.jparepository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.techwiz.model.Categories;

public interface CategoryRepository extends JpaRepository<Categories, Integer> {
    
}
