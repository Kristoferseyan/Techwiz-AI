package com.example.techwiz.dto.Ai;

import java.util.List;

public class ProblemMatchDto {
    private String deviceType;
    private String category;
    private String description;
    private List<String> symptoms;

    public ProblemMatchDto() {
    }

    public ProblemMatchDto(String deviceType, String category, String description, List<String> symptoms) {
        this.deviceType = deviceType;
        this.category = category;
        this.description = description;
        this.symptoms = symptoms;
    }

    public String getDeviceType() {
        return deviceType;
    }

    public void setDeviceType(String deviceType) {
        this.deviceType = deviceType;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<String> getSymptoms() {
        return symptoms;
    }

    public void setSymptoms(List<String> symptoms) {
        this.symptoms = symptoms;
    }
}