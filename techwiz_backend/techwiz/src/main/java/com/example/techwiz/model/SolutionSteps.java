package com.example.techwiz.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name="solution_steps")
public class SolutionSteps {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Integer id;
    private Integer step_number;
    private String instruction;
    
    @ManyToOne
    @JoinColumn(name="solution_id", nullable=false)
    private Solutions solutions;

    public SolutionSteps() {
    }

    public SolutionSteps(Integer id, String instruction, Solutions solutions, Integer step_number) {
        this.id = id;
        this.instruction = instruction;
        this.solutions = solutions;
        this.step_number = step_number;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getStep_number() {
        return step_number;
    }

    public void setStep_number(Integer step_number) {
        this.step_number = step_number;
    }

    public String getinstruction() {
        return instruction;
    }

    public void setinstruction(String instruction) {
        this.instruction = instruction;
    }

    public Solutions getSolutions() {
        return solutions;
    }

    public void setSolutions(Solutions solutions) {
        this.solutions = solutions;
    }
}
