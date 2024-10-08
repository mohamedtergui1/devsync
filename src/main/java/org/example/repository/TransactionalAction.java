package org.example.repository;

import jakarta.persistence.EntityManager;

public @FunctionalInterface interface TransactionalAction {
    void execute(EntityManager em);
}