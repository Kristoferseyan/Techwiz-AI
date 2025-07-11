package com.example.techwiz.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.techwiz.services.Categories.CategoryServices;


@RestController
@RequestMapping("/category")
public class CategoryController {
    @Autowired CategoryServices categoryServices;

    @PreAuthorize("hasAnyRole('SUPERADMIN', 'ADMIN', 'USER')")
    @GetMapping()
    public ResponseEntity getCategories() {
        return ResponseEntity.ok(categoryServices.displayCategories());
    }
    
}
