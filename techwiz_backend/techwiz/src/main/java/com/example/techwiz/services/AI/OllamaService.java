package com.example.techwiz.services.AI;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class OllamaService {

    private final String OLLAMA_URL = "http://localhost:11434/api/generate";

    public String sendPrompt(String prompt, String modelName) {
        
        Map<String, Object> payload = new HashMap<>();
        payload.put("model", modelName);          
        payload.put("prompt", prompt);            
        payload.put("stream", false);             

        
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        
        HttpEntity<Map<String, Object>> request = new HttpEntity<>(payload, headers);
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Map> response = restTemplate.exchange(
                OLLAMA_URL,
                HttpMethod.POST,
                request,
                Map.class
        );

        Map<String, Object> body = response.getBody();
        return (body != null && body.containsKey("response")) ? (String) body.get("response") : "";
    }
}