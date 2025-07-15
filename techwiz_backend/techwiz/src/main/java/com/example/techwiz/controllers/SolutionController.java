package com.example.techwiz.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.techwiz.services.Solutions.SolutionServices;


@RestController
@RequestMapping("/solutions")
public class SolutionController {
    @Autowired SolutionServices solutionServices;

    @GetMapping("/getSolutionsByProblemId/{id}")
    public ResponseEntity<?> getSolutionsByProblemId(@PathVariable Integer id) {
        return ResponseEntity.ok(solutionServices.getSolutionsByProblemId(id));
    }
    
}
