package com.example.techwiz.jparepository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.techwiz.model.Solutions;

public interface SolutionsRepository extends JpaRepository<Solutions, Integer>{
    
}
