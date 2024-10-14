package org.example.repository;

import jakarta.persistence.EntityManager;
import org.example.entity.Request;
import org.example.repository.base.Repository;

public class RequestRepositoryImpl extends Repository implements RequestRepository {
    @Override
    public void createRequest(Request request) {
        executeInTransaction(
                em -> em.persist(request)
        );
    }

    @Override
    public Request readRequest(Long id) {
        EntityManager entityManagerntity= emf.createEntityManager();
        return entityManagerntity.find(Request.class, id);

    }

    @Override
    public void updateRequest(Request request) {
        executeInTransaction(
                em -> em.merge(request)
        );
    }
}
