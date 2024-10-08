package org.example.repository.base;

import jakarta.persistence.EntityManager;

public @FunctionalInterface interface TransactionalAction {
    void execute(EntityManager em);
}