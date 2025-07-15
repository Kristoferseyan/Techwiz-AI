package com.example.techwiz.services.Problems;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.techwiz.dto.Problems.ProblemsDto;
import com.example.techwiz.jparepository.CategoryRepository;
import com.example.techwiz.jparepository.ProblemRepository;
import com.example.techwiz.mapper.FeaturedProblemMapper;
import com.example.techwiz.mapper.ProblemMapper;
import com.example.techwiz.model.Categories;
import com.example.techwiz.model.Problems;

@Service
public class ProblemServices {
    @Autowired
    private ProblemRepository problemRepository;
    @Autowired
    private CategoryRepository categoryRepository;

    public List<ProblemsDto> displayProblems(){
        List<Problems> problems = problemRepository.findAll();
        
        return problems.stream()
                    .map(ProblemMapper::toDto)
                    .collect(Collectors.toList());
    }

    public Page<ProblemsDto> displayPaginatedProblems(Pageable pageable){
        return problemRepository.findAll(pageable).map(ProblemMapper::toDto);
    }

    public List<ProblemsDto> displayFeaturedProblems(){
        List<Problems> featuredProblems = problemRepository.findByFeaturedTrue();
        return featuredProblems.stream()
                        .map(FeaturedProblemMapper::toDto)
                        .collect(Collectors.toList());
    }

    public List<ProblemsDto> displayProblemsByCategory(String categoryName){
        Categories categories = categoryRepository.findByName(categoryName)
            .orElseThrow(() -> new UsernameNotFoundException("Username not found"));

        List<Problems> problems = problemRepository.findByCategories_Id(categories.getId());

        return problems.stream()
                        .map(ProblemMapper::toDto)
                        .collect(Collectors.toList());
        
    }

}
