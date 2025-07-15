package com.example.techwiz.services.Solutions;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.techwiz.dto.Solutions.SolutionStepsDto;
import com.example.techwiz.jparepository.SolutionStepsRepository;
import com.example.techwiz.jparepository.SolutionsRepository;
import com.example.techwiz.mapper.SolutionStepMapper;
import com.example.techwiz.model.SolutionSteps;
import com.example.techwiz.model.Solutions;

@Service
public class SolutionStepServices {
    @Autowired
    private SolutionStepsRepository solutionStepsRepository;
    @Autowired
    private SolutionsRepository solutionRepository;

    public List<SolutionStepsDto> getSolutionStepsBySolutionId(Integer id){
        Solutions solutions = solutionRepository.findById(id).orElseThrow(() -> new IndexOutOfBoundsException("Id not found"));

        List<SolutionSteps> solutionSteps = solutionStepsRepository.findBySolutions_Id(solutions.getId());

        return solutionSteps.stream().map(SolutionStepMapper::toDto).collect(Collectors.toList());

    }
}
