package com.example.techwiz.mapper;

import com.example.techwiz.dto.Solutions.SolutionStepsDto;
import com.example.techwiz.model.SolutionSteps;

public class SolutionStepMapper {
    public static SolutionStepsDto toDto(SolutionSteps solutionSteps){
        SolutionStepsDto dto = new SolutionStepsDto();
        dto.setStep_number(solutionSteps.getStep_number());
        dto.setInstruction(solutionSteps.getinstruction());
        return dto;
    }
}
