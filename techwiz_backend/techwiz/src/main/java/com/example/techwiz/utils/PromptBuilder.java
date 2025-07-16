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
        sb.append("Important: Use only the numeric ID (e.g., 31), not a string like \"ID: 31\".\n\n");

        sb.append("Instructions:\n");
        sb.append("Analyze the user report and match it with the most relevant known problem. Return the result in JSON format exactly like this:\n");
        sb.append("{\n");
        sb.append("  \"matchedProblemId\": <integer>,\n");
        sb.append("  \"confidence\": <number from 0 to 100>,\n");
        sb.append("  \"reasoning\": \"Explain briefly why this problem matches\",\n");
        sb.append("  \"recommendedSolution\": \"Title of the matched solution\",\n");
        sb.append("  \"prioritySteps\": [\"Step 1\", \"Step 2\", \"Step 3\"]\n");
        sb.append("}\n\n");
        sb.append("If you are not confident (under 60%), return null for matchedProblemId and suggest general troubleshooting advice.\n");

        return sb.toString();
    }

    private String nullSafe(String value) {
        return value != null ? value : "Not specified";
    }
}