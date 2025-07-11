package com.example.techwiz.mapper;

import com.example.techwiz.dto.Problems.ProblemsDto;
import com.example.techwiz.model.Problems;

public class ProblemMapper {
    public static Problems toEntity(ProblemsDto dto){
        Problems problems = new Problems();
        problems.setName(dto.getName());
        problems.setDescription(dto.getDescription());
        return problems;
    }

    public static ProblemsDto toDto(Problems problems){
        ProblemsDto dto = new ProblemsDto();
        dto.setName(problems.getName());
        dto.setDescription(problems.getDescription());
        return dto;
    }
}
