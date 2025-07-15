package com.example.techwiz.mapper;

import com.example.techwiz.dto.Solutions.SolutionsDto;
import com.example.techwiz.model.Solutions;

public class SolutionMapper {
    public static SolutionsDto toDto(Solutions solutions){
        SolutionsDto dto = new SolutionsDto();
        dto.setTitle(solutions.getTitle());
        dto.setDescription(solutions.getDescription());
        return dto;
    }
}
