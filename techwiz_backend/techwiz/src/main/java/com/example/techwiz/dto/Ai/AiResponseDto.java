package com.example.techwiz.dto.Ai;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class AiResponseDto {
    private Integer matchedProblemId;
    private Integer confidence;
    private String reasoning;
    private String recommendedSolution;
    private List<String> prioritySteps;
    private String fallbackAdvice;

    public AiResponseDto() {
    }

    public AiResponseDto(Integer matchedProblemId, Integer confidence, String reasoning, 
                        String recommendedSolution, List<String> prioritySteps, String fallbackAdvice) {
        this.matchedProblemId = matchedProblemId;
        this.confidence = confidence;
        this.reasoning = reasoning;
        this.recommendedSolution = recommendedSolution;
        this.prioritySteps = prioritySteps;
        this.fallbackAdvice = fallbackAdvice;
    }

    public Integer getMatchedProblemId() {
        return matchedProblemId;
    }

    public void setMatchedProblemId(Integer matchedProblemId) {
        this.matchedProblemId = matchedProblemId;
    }

    public Integer getConfidence() {
        return confidence;
    }

    public void setConfidence(Integer confidence) {
        this.confidence = confidence;
    }

    public String getReasoning() {
        return reasoning;
    }

    public void setReasoning(String reasoning) {
        this.reasoning = reasoning;
    }

    public String getRecommendedSolution() {
        return recommendedSolution;
    }

    public void setRecommendedSolution(String recommendedSolution) {
        this.recommendedSolution = recommendedSolution;
    }

    public List<String> getPrioritySteps() {
        return prioritySteps;
    }

    public void setPrioritySteps(List<String> prioritySteps) {
        this.prioritySteps = prioritySteps;
    }

    public String getFallbackAdvice() {
        return fallbackAdvice;
    }

    public void setFallbackAdvice(String fallbackAdvice) {
        this.fallbackAdvice = fallbackAdvice;
    }
}
