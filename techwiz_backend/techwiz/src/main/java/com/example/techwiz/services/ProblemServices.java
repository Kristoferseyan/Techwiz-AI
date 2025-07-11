package com.example.techwiz.services;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.techwiz.dto.Problems.ProblemsDto;
import com.example.techwiz.jparepository.ProblemRepository;
import com.example.techwiz.mapper.ProblemMapper;
import com.example.techwiz.model.Problems;

@Service
public class ProblemServices {
    @Autowired
    private ProblemRepository problemRepository;

    public List<ProblemsDto> displayProblems(){
        List<Problems> problems = problemRepository.findAll();
        
        return problems.stream()
                    .map(ProblemMapper::toDto)
                    .collect(Collectors.toList());
    }
}
