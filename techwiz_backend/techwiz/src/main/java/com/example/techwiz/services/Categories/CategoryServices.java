package com.example.techwiz.services.Categories;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.techwiz.jparepository.CategoryRepository;

@Service
public class CategoryServices {
    @Autowired
    private CategoryRepository categoryRepository;

    
}
