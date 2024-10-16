package org.example.service.request;


import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.example.entity.Request;
@Stateless
public class RequestServiceImpl implements RequestService {
    @PersistenceContext(unitName = "jpa")
    EntityManager em;
    @Override
    public void createRequest(Request request) {
        em.persist(request);
    }

    @Override
    public Request readRequest(long id) {
        return em.find(Request.class, id);
    }

    @Override
    public void updateRequest(Request request) {
        em.merge(request);
    }
}
