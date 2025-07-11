package com.example.techwiz.jparepository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.techwiz.model.Problems;

public interface ProblemRepository extends JpaRepository<Problems, Integer>{
   List<Problems> findByFeaturedTrue();
   List<Problems> findByCategories_Id(Integer id);
}
