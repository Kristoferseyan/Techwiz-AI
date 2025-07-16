package com.example.techwiz.controllers;

import java.util.List;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.techwiz.dto.Ai.AiResponseDto;
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
            // 1. Fetch problems and categories
            List<Problems> allProblems = problemRepository.findAll();
            List<String> allCategoryNames = categoryRepository.findAll()
                .stream()
                .map(Categories::getName)
                .toList();

            // 2. Predict the best-fit category using LLM
            String predictedCategory = ollamaService.getCategoryFromPrompt(request.getDescription(), allCategoryNames);

            // 3. Filter by that category
            List<Problems> filteredProblems = ollamaService.filterProblemsByCategory(allProblems, predictedCategory);

            // 4. Build prompt and send to LLM
            String prompt = promptBuilder.buildPrompt(request, filteredProblems);
            AiResponseDto aiResult = ollamaService.sendPromptForStructuredResponse(prompt, null);

            // 5. Prepare the response DTO
            ProblemMatchWithRelatedDto response = new ProblemMatchWithRelatedDto();

            if (aiResult.getMatchedProblemId() != null) {
                response.setMatchedProblemIds(List.of(aiResult.getMatchedProblemId()));
            } else {
                response.setMatchedProblemIds(List.of());
            }

            List<ProblemMatchWithRelatedDto.RelatedProblemDto> related = filteredProblems.stream()
                .filter(p -> aiResult.getMatchedProblemId() == null || !p.getId().equals(aiResult.getMatchedProblemId()))
                .map(p -> new ProblemMatchWithRelatedDto.RelatedProblemDto(p.getId(), p.getName()))
                .collect(Collectors.toList());

            response.setRelatedProblems(related);

            logger.info("AI match done (Category: {}) → Match ID: {}, Confidence: {}%",
                predictedCategory,
                aiResult.getMatchedProblemId(),
                aiResult.getConfidence()
            );

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            logger.error("Error during AI matching", e);

            ProblemMatchWithRelatedDto errorResponse = new ProblemMatchWithRelatedDto();
            errorResponse.setMatchedProblemIds(List.of());
            errorResponse.setRelatedProblems(List.of());

            return ResponseEntity.ok(errorResponse);
        }
    }
    
    private AiResponseDto createErrorResponse(String errorMessage) {
        AiResponseDto errorResponse = new AiResponseDto();
        errorResponse.setMatchedProblemId(null);
        errorResponse.setConfidence(0);
        errorResponse.setReasoning("Error occurred during processing");
        errorResponse.setFallbackAdvice("Unable to process request: " + errorMessage + 
                                      ". Please try again or contact support for assistance.");
        return errorResponse;
    }
}
