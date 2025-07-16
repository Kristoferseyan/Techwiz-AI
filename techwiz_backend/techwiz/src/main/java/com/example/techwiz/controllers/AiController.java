package com.example.techwiz.controllers;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.techwiz.dto.Ai.ProblemMatchDto;
import com.example.techwiz.dto.Ai.ProblemMatchWithRelatedDto;
import com.example.techwiz.jparepository.CategoryRepository;
import com.example.techwiz.jparepository.ProblemRepository;
import com.example.techwiz.model.Categories;
import com.example.techwiz.model.Problems;
import com.example.techwiz.services.AI.OllamaService;
import com.example.techwiz.utils.PromptBuilder;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/ai")
public class AiController {

    private static final Logger logger = LoggerFactory.getLogger(AiController.class);

    @Autowired private OllamaService ollamaService;
    @Autowired private PromptBuilder promptBuilder;
    @Autowired private ProblemRepository problemRepository;
    @Autowired private CategoryRepository categoryRepository;

    @PreAuthorize("hasAnyRole('ADMIN', 'USER', 'SUPERADMIN')")
    @PostMapping("/match")
    public ResponseEntity<ProblemMatchWithRelatedDto> matchProblem(@Valid @RequestBody ProblemMatchDto request) {
        logger.info("Received AI match request for device: {}, category: {}", 
                request.getDeviceType(), request.getCategory());

        try {
            // 1. Fetch all problems and categories
            List<Problems> allProblems = problemRepository.findAll();
            List<String> allCategoryNames = categoryRepository.findAll()
                .stream()
                .map(Categories::getName)
                .toList();

            // 2. Predict category from prompt
            String predictedCategory = ollamaService.getCategoryFromPrompt(request.getDescription(), allCategoryNames);

            // 3. Filter problems by predicted category
            List<Problems> filteredProblems = ollamaService.filterProblemsByCategory(allProblems, predictedCategory);

            // 4. Build prompt and send to LLM
            String prompt = promptBuilder.buildPrompt(request, filteredProblems);
            ProblemMatchWithRelatedDto aiResult = ollamaService.sendPromptForRelatedResponse(prompt, null);

            logger.info("AI match done (Category: {}) → Matches: {} | Related: {}",
                predictedCategory,
                aiResult.getMatchedProblems() != null ? aiResult.getMatchedProblems().size() : 0,
                aiResult.getRelatedProblems() != null ? aiResult.getRelatedProblems().size() : 0
            );

            // 5. Return what the AI already structured — no need to re-map
            return ResponseEntity.ok(aiResult);

        } catch (Exception e) {
            logger.error("Error during AI matching", e);

            ProblemMatchWithRelatedDto errorResponse = new ProblemMatchWithRelatedDto();
            errorResponse.setMatchedProblems(List.of());
            errorResponse.setRelatedProblems(List.of());
            return ResponseEntity.ok(errorResponse);
        }
    }
}