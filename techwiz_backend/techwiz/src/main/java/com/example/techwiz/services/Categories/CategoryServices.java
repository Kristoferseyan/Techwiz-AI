package com.example.techwiz.services.Categories;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.techwiz.dto.Categories.CategoriesDto;
import com.example.techwiz.jparepository.CategoryRepository;
import com.example.techwiz.mapper.CategoryMapper;
import com.example.techwiz.model.Categories;

@Service
public class CategoryServices {
    @Autowired
    private CategoryRepository categoryRepository;

    public List<CategoriesDto> displayCategories(){
        List<Categories> categories = categoryRepository.findAll();

        return categories.stream()
                            .map(CategoryMapper::toDto)
                            .collect(Collectors.toList());
    }


    
}
