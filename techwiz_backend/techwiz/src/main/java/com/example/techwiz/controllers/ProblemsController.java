package com.example.techwiz.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.techwiz.services.Problems.ProblemServices;



@RestController
@RequestMapping("/problems")
public class ProblemsController {
    @Autowired
    private ProblemServices problemServices;

    @PreAuthorize("hasAnyRole('ADMIN', 'USER', 'SUPERADMIN')")
    @GetMapping
    public ResponseEntity<?> getProblems() {
        return ResponseEntity.ok(problemServices.displayProblems());
    }

    @PreAuthorize("hasAnyRole('ADMIN', 'USER', 'SUPERADMIN')")
    @GetMapping("featured")
    public ResponseEntity<?> getFeaturedProblems(){
        return ResponseEntity.ok(problemServices.displayFeaturedProblems());
    }
    
}
