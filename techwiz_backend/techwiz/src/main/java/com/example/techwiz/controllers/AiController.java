package com.example.techwiz.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.techwiz.dto.Ai.ProblemMatchDto;
import com.example.techwiz.jparepository.ProblemRepository;
import com.example.techwiz.model.Problems;
import com.example.techwiz.services.AI.OllamaService;
import com.example.techwiz.utils.PromptBuilder;

@RestController
@RequestMapping("/ai")
public class AiController {

    @Autowired private OllamaService ollamaService;
    @Autowired private PromptBuilder promptBuilder;
    @Autowired private ProblemRepository problemRepository;

    @PostMapping("/match")
    public ResponseEntity<String> matchProblem(@RequestBody ProblemMatchDto request) {
        List<Problems> problems = problemRepository.findAll();
        String prompt = promptBuilder.buildPrompt(request, problems);
        String result = ollamaService.sendPrompt(prompt, "openhermes"); 
        return ResponseEntity.ok(result);
    }
}
