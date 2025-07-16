package com.example.techwiz.dto.Ai;

import java.util.List;

public class ProblemMatchWithRelatedDto {
    private List<Integer> matchedProblemIds;
    private List<RelatedProblemDto> relatedProblems;


    public List<Integer> getMatchedProblemIds() {
        return matchedProblemIds;
    }

    public void setMatchedProblemIds(List<Integer> matchedProblemIds) {
        this.matchedProblemIds = matchedProblemIds;
    }

    public List<RelatedProblemDto> getRelatedProblems() {
        return relatedProblems;
    }

    public void setRelatedProblems(List<RelatedProblemDto> relatedProblems) {
        this.relatedProblems = relatedProblems;
    }

    public static class RelatedProblemDto {
        private Integer id;
        private String name;

        public RelatedProblemDto() {}
        public RelatedProblemDto(Integer id, String name) {
            this.id = id;
            this.name = name;
        }

        public Integer getId() { return id; }
        public void setId(Integer id) { this.id = id; }
        public String getName() { return name; }
        public void setName(String name) { this.name = name; }
    }
}