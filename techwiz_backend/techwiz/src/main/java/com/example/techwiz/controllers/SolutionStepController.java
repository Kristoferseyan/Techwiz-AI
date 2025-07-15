package com.example.techwiz.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.techwiz.services.Solutions.SolutionStepServices;

import jakarta.validation.Valid;


@RestController
@RequestMapping("/solution-steps")
public class SolutionStepController {
    @Autowired private SolutionStepServices solutionStepServices;

    @GetMapping("/getSolutionStepBySolutionId/{id}")
    public ResponseEntity<?> getSolutionStepsBySolutionId(@Valid @PathVariable Integer id) {
        return ResponseEntity.ok(solutionStepServices.getSolutionStepsBySolutionId(id));
    }
    
}
