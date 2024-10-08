package org.example.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class Repository {
    protected final EntityManagerFactory emf;
    public Repository() {
        emf = Persistence.createEntityManagerFactory("jpa");
    }
    protected void executeInTransaction(TransactionalAction action) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            action.execute(em);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

}
