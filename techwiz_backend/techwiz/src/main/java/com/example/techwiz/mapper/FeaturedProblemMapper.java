package com.example.techwiz.mapper;

import com.example.techwiz.dto.Problems.ProblemsDto;
import com.example.techwiz.model.Problems;

public class FeaturedProblemMapper {
    public static ProblemsDto toDto(Problems problems){
        ProblemsDto dto = new ProblemsDto();
        dto.setName(problems.getName());
        dto.setDescription(problems.getDescription());
        dto.setFeatured(problems.isFeatured());
        return dto;
    }
}
