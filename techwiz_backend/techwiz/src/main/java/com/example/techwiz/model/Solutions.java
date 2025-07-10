package com.example.techwiz.model;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name="solutions")
public class Solutions {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Integer id;
    private String title;
    private String description;

    @ManyToMany(mappedBy="solutions")
    private List<Problems> problems;

    @OneToMany(mappedBy="solutions", cascade=CascadeType.ALL, orphanRemoval=true)
    private List<SolutionSteps> solutionSteps;

    public Solutions() {
    }

    public Solutions(String description, Integer id, List<Problems> problems, List<SolutionSteps> solutionSteps, String title) {
        this.description = description;
        this.id = id;
        this.problems = problems;
        this.solutionSteps = solutionSteps;
        this.title = title;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<Problems> getProblems() {
        return problems;
    }

    public void setProblems(List<Problems> problems) {
        this.problems = problems;
    }

    public List<SolutionSteps> getSolutionSteps() {
        return solutionSteps;
    }

    public void setSolutionSteps(List<SolutionSteps> solutionSteps) {
        this.solutionSteps = solutionSteps;
    }
}
