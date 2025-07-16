package com.example.techwiz.utils;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.techwiz.dto.Ai.ProblemMatchDto;
import com.example.techwiz.model.Problems;
import com.example.techwiz.model.SolutionSteps;
import com.example.techwiz.model.Solutions;

@Service
public class PromptBuilder {

    public String buildPrompt(ProblemMatchDto request, List<Problems> dbProblems) {
        StringBuilder sb = new StringBuilder();

        sb.append("Task: Match this user-submitted problem to a known issue in the database.\n\n");

        sb.append("Device Type: ").append(request.getDeviceType()).append("\n");
        sb.append("Category: ").append(request.getCategory()).append("\n");
        sb.append("Description: ").append(request.getDescription()).append("\n");
        sb.append("Symptoms:\n");
        for (String symptom : request.getSymptoms()) {
            sb.append("- ").append(symptom).append("\n");
        }

        sb.append("\nKnown Problems:\n");
        for (Problems problem : dbProblems) {
            sb.append("[ID: ").append(problem.getId()).append("] ")
              .append(problem.getName()).append(" — ").append(problem.getDescription()).append("\n");

            for (Solutions solution : problem.getSolutions()) {
                sb.append("  Solution: ").append(solution.getTitle()).append("\n");
                sb.append("  Description: ").append(solution.getDescription()).append("\n");
                sb.append("  Steps:\n");

                for (SolutionSteps step : solution.getSolutionSteps()) {
                    sb.append("    - Step ").append(step.getStep_number()).append(": ").append(step.getinstruction()).append("\n");
                }
            }

            sb.append("\n");
        }

        sb.append("Based on the user report, return the ID of the closest matching problem and the recommended steps.\n");

        return sb.toString();
    }
}
