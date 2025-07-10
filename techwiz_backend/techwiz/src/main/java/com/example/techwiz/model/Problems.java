package com.example.techwiz.model;

import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name="problems")
public class Problems {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Integer id;
    private String name;
    private String description;

    @ManyToOne
    @JoinColumn(name="category_id", nullable=false)
    private Categories categories;

    @ManyToMany(fetch=FetchType.EAGER)
    @JoinTable(
        name = "problem_solutions",
        joinColumns=@JoinColumn(name="problem_id"),
        inverseJoinColumns=@JoinColumn(name="solution_id")
    )
    private List<Solutions> solutions;

    public Problems() {
    }

    public Problems(Categories categories, String description, Integer id, String name, List<Solutions> solutions) {
        this.categories = categories;
        this.description = description;
        this.id = id;
        this.name = name;
        this.solutions = solutions;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Categories getCategories() {
        return categories;
    }

    public void setCategories(Categories categories) {
        this.categories = categories;
    }

    public List<Solutions> getSolutions() {
        return solutions;
    }

    public void setSolutions(List<Solutions> solutions) {
        this.solutions = solutions;
    }
}
