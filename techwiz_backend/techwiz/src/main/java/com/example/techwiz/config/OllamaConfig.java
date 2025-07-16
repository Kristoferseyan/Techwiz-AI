package com.example.techwiz.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "ollama")
public class OllamaConfig {
    
    private String url = "http://localhost:11434/api/generate";
    private String defaultModel = "openhermes";
    private int timeout = 30000;
    private int maxRetries = 3;
    private boolean enableFallback = true;
    
    // Available models configuration
    private String[] availableModels = {
        "openhermes", "llama2", "codellama", "mistral", "neural-chat"
    };

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getDefaultModel() {
        return defaultModel;
    }

    public void setDefaultModel(String defaultModel) {
        this.defaultModel = defaultModel;
    }

    public int getTimeout() {
        return timeout;
    }

    public void setTimeout(int timeout) {
        this.timeout = timeout;
    }

    public int getMaxRetries() {
        return maxRetries;
    }

    public void setMaxRetries(int maxRetries) {
        this.maxRetries = maxRetries;
    }

    public boolean isEnableFallback() {
        return enableFallback;
    }

    public void setEnableFallback(boolean enableFallback) {
        this.enableFallback = enableFallback;
    }

    public String[] getAvailableModels() {
        return availableModels;
    }

    public void setAvailableModels(String[] availableModels) {
        this.availableModels = availableModels;
    }

    public boolean isModelAvailable(String modelName) {
        if (modelName == null) return false;
        for (String model : availableModels) {
            if (model.equals(modelName)) {
                return true;
            }
        }
        return false;
    }
}
