package com.example.techwiz.jparepository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.techwiz.model.SolutionSteps;

public interface SolutionStepsRepository extends JpaRepository<SolutionSteps, Integer>{
    List<SolutionSteps> findBySolutions_Id(Integer id);
}
