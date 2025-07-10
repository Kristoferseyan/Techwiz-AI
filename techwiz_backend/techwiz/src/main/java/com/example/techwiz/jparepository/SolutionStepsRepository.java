package com.example.techwiz.jparepository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.techwiz.model.SolutionSteps;

public interface SolutionStepsRepository extends JpaRepository<SolutionSteps, Integer>{
    
}
