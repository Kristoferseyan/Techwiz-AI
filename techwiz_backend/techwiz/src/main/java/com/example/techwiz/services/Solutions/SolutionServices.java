package com.example.techwiz.services.Solutions;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.techwiz.jparepository.SolutionsRepository;

@Service
public class SolutionServices {
    @Autowired
    private SolutionsRepository solutionsRepository;
}
