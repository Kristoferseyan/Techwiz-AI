package com.example.techwiz.utils;

import java.util.Comparator;
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

        sb.append("Only answer questions that are related to computer or laptop problems.\n");
        sb.append("You are a helpful technical support assistant. Your job is to match the user's reported issue with the best problem from the known database.\n\n");

        sb.append("User Report:\n");
        sb.append("Device: ").append(nullSafe(request.getDeviceType())).append("\n");
        sb.append("Description: ").append(nullSafe(request.getDescription())).append("\n\n");

        sb.append("Known Problems:\n");
        for (Problems problem : dbProblems) {
            sb.append("Problem ID: ").append(problem.getId()).append("\n");
            sb.append("Name: ").append(nullSafe(problem.getName())).append("\n");
            sb.append("Description: ").append(nullSafe(problem.getDescription())).append("\n");

            if (problem.getSolutions() != null) {
                for (Solutions solution : problem.getSolutions()) {
                    sb.append("  Solution Title: ").append(nullSafe(solution.getTitle())).append("\n");
                    sb.append("  Description: ").append(nullSafe(solution.getDescription())).append("\n");
                    if (solution.getSolutionSteps() != null) {
                        sb.append("  Steps:\n");
                        solution.getSolutionSteps().stream()
                            .sorted(Comparator.comparing(SolutionSteps::getStep_number))
                            .forEach(step -> sb.append("    - Step ").append(step.getStep_number())
                                .append(": ").append(nullSafe(step.getinstruction())).append("\n"));
                    }
                }
            }
            sb.append("\n");
        }

        sb.append("Respond ONLY with a valid JSON object — do not include explanations or notes outside the JSON.\n");
        sb.append("Important: Use only the exact JSON format shown below — no extra text, no code blocks.\n\n");

        sb.append("Respond ONLY with a valid JSON object — do not include explanations or notes outside the JSON.\n");
        sb.append("Important: Use only numeric IDs (e.g., 31), not strings like \"ID: 31\".\n\n");

        sb.append("Instructions:\n");
        sb.append("Analyze the user's report and return the result in the following JSON format:\n");
        sb.append("{\n");
        sb.append("  \"matchedProblems\": [\n");
        sb.append("    { \"id\": 1, \"name\": \"Matched Problem Name\" }\n");
        sb.append("  ],\n");
        sb.append("  \"relatedProblems\": [\n");
        sb.append("    { \"id\": 2, \"name\": \"Related Problem 1\" },\n");
        sb.append("    { \"id\": 3, \"name\": \"Related Problem 2\" }\n");
        sb.append("  ]\n");
        sb.append("}\n\n");
        sb.append("If there is no relevant match, return an empty array for \"matchedProblemIds\".\n");
        sb.append("If there are no related problems, return an empty list for \"relatedProblems\".\n");
        sb.append("Return ONLY valid JSON. No explanations, notes, or extra text.\n");

        return sb.toString();
    }

    private String nullSafe(String value) {
        return value != null ? value : "Not specified";
    }
}