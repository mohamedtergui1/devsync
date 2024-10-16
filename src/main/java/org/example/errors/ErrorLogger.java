package org.example.errors;


import jakarta.ejb.Remote;

import java.util.Map;


public interface ErrorLogger {
    void logError(String errorKey, String errorMessage);

    Map<String, String> getErrorMap();

    void clearErrors(String errorKey);

    void clearAllErrors();
}
