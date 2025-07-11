package com.example.techwiz.dto.Categories;
import java.util.List;

import com.example.techwiz.dto.Problems.ProblemsDto;

public class CategoriesDto {
    private String name;
    private List<ProblemsDto> problems;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<ProblemsDto> getProblems() {
        return problems;
    }

    public void setProblems(List<ProblemsDto> problems) {
        this.problems = problems;
    }
    
    public int getProblemCount() {
        return problems != null ? problems.size() : 0;
    }
}


