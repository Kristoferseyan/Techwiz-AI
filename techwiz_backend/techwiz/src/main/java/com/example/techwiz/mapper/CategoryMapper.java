package com.example.techwiz.mapper;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import com.example.techwiz.dto.Categories.CategoriesDto;
import com.example.techwiz.dto.Problems.ProblemsDto;
import com.example.techwiz.model.Categories;

public class CategoryMapper {
    public static CategoriesDto toDto(Categories category) {
        CategoriesDto dto = new CategoriesDto();
        dto.setName(category.getName());

        if (category.getProblems() != null) {
            List<ProblemsDto> problemDtos = category.getProblems().stream()
                .map(ProblemMapper::toDto)
                .collect(Collectors.toList());
            dto.setProblems(problemDtos);
        } else {
            dto.setProblems(Collections.emptyList());
        }

        return dto;
    }
}
