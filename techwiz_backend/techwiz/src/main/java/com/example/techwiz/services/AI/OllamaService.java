package com.example.techwiz.services.AI;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.example.techwiz.dto.Ai.AiResponseDto;
import com.example.techwiz.dto.Ai.ProblemMatchWithRelatedDto;
import com.example.techwiz.model.Problems;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class OllamaService {

    private static final Logger logger = LoggerFactory.getLogger(OllamaService.class);

    @Value("${ollama.url:http://localhost:11434/api/generate}")
    private String ollamaUrl;

    @Value("${ollama.default.model:openhermes}")
    private String defaultModel;

    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();

    public AiResponseDto sendPromptForStructuredResponse(String prompt, String modelName) {
        logger.info(" Final prompt being sent to Ollama:\n{}", prompt);
        String responseText = sendPrompt(prompt, modelName);
        if (responseText.isEmpty()) {
            return fallbackResponse("Empty response from Ollama");
        }

        try {
            String json = extractJsonFromResponse(responseText);
            return objectMapper.readValue(json, AiResponseDto.class);
        } catch (Exception e) {
            logger.warn("Could not parse AI response: {}", e.getMessage());
            return fallbackResponse(responseText);
        }
    }
    public ProblemMatchWithRelatedDto sendPromptForRelatedResponse(String prompt, String modelName) {
        logger.info("Final prompt being sent to Ollama:\n{}", prompt);
        String responseText = sendPrompt(prompt, modelName);

        if (responseText.isEmpty()) {
            logger.warn("⚠️ Empty response from Ollama.");
            return new ProblemMatchWithRelatedDto();
        }

        try {
            String json = extractJsonFromResponse(responseText);
            return objectMapper.readValue(json, ProblemMatchWithRelatedDto.class);
        } catch (Exception e) {
            logger.warn("Could not parse LLM response: {}", e.getMessage());
            return new ProblemMatchWithRelatedDto();
        }
    }

    public String getCategoryFromPrompt(String description, List<String> categoryNames) {
        String categoryPrompt = """
            You are an AI assistant for tech support. Based on the user's issue:
            "%s"
            Choose the most appropriate category from the list below:

            %s

            Respond ONLY with the exact category name.
        """.formatted(description, String.join("\n", categoryNames));

        String rawResponse = sendPrompt(categoryPrompt, null);
        return extractCategoryName(rawResponse);
    }

        public List<Problems> filterProblemsByCategory(List<Problems> problems, String categoryName) {
            return problems.stream()
                .filter(p -> p.getCategories() != null &&
                            p.getCategories().getName().equalsIgnoreCase(categoryName))
                .collect(Collectors.toList());
        }

    private String sendPrompt(String prompt, String modelName) {
        if (prompt == null || prompt.isBlank()) return "";

        Map<String, Object> payload = new HashMap<>();
        payload.put("model", modelName != null ? modelName : defaultModel);
        payload.put("prompt", prompt);
        payload.put("stream", false);
        payload.put("options", modelOptions());

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        try {
            ResponseEntity<Map> response = restTemplate.exchange(
                ollamaUrl,
                HttpMethod.POST,
                new HttpEntity<>(payload, headers),
                Map.class
            );

            Map<String, Object> body = response.getBody();
            return body != null ? String.valueOf(body.get("response")) : "";
        } catch (RestClientException e) {
            logger.error("Ollama error: {}", e.getMessage());
            return "";
        }
    }

    private Map<String, Object> modelOptions() {
        Map<String, Object> options = new HashMap<>();
        options.put("temperature", 0.3);
        options.put("top_p", 0.9);
        options.put("top_k", 40);
        options.put("repeat_penalty", 1.1);
        options.put("num_predict", 1000);
        return options;
    }

    private String extractJsonFromResponse(String response) {
        int start = response.indexOf('{');
        int end = response.lastIndexOf('}');
        if (start != -1 && end != -1 && end > start) {
            return response.substring(start, end + 1);
        }
        throw new IllegalArgumentException("No valid JSON found");
    }

    private AiResponseDto fallbackResponse(String raw) {
        AiResponseDto dto = new AiResponseDto();
        dto.setMatchedProblemId(null);
        dto.setConfidence(50);
        dto.setReasoning("AI provided unstructured response");
        dto.setFallbackAdvice(raw);
        return dto;
    }

    private String extractCategoryName(String raw) {
        if (raw == null) return "";
        return raw.strip().split("\\n")[0].trim();
    }
}