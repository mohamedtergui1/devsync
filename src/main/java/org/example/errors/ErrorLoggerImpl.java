package org.example.errors;

import jakarta.inject.Singleton;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Singleton
public class ErrorLoggerImpl implements ErrorLogger {
    // Using ConcurrentHashMap to ensure thread safety
    private ConcurrentHashMap<String, String> errorMap = new ConcurrentHashMap<>();

    public void logError(String errorKey, String errorMessage) {
        errorMap.computeIfAbsent(errorKey, k -> errorMessage);
    }

    public Map<String, String> getErrorMap() {
        return errorMap;
    }

    public void clearErrors(String errorKey) {
        errorMap.remove(errorKey);
    }

    public void clearAllErrors() {
        errorMap.clear();
    }
}
