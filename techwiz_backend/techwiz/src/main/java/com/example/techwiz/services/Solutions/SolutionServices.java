package com.example.techwiz.services.Solutions;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.techwiz.dto.Solutions.SolutionsDto;
import com.example.techwiz.jparepository.ProblemRepository;
import com.example.techwiz.jparepository.SolutionsRepository;
import com.example.techwiz.mapper.SolutionMapper;
import com.example.techwiz.model.Problems;
import com.example.techwiz.model.Solutions;

@Service
public class SolutionServices {
    @Autowired
    private SolutionsRepository solutionsRepository;
    @Autowired
    private ProblemRepository problemRepository;

    public List<SolutionsDto> getSolutionsByProblemId(Integer id){
        Problems problems = problemRepository.findById(id).orElseThrow(() -> new IndexOutOfBoundsException("Id does not exist."));


        List<Solutions> solutions = problems.getSolutions();

        return solutions.stream().map(SolutionMapper::toDto).collect(Collectors.toList());
    }
}
