package org.example.repository;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.example.entity.User;

import java.util.List;

@Stateless
public class UserRepositoryImpl implements UserRepository {

    @PersistenceContext(unitName = "jpa")
    private EntityManager em;  // Injecting the EntityManager

    @Override
    public void createUser(User user) {
        executeInTransaction((em) -> em.persist(user));
    }

    @Override
    public User readUser(Long id) {
        return em.find(User.class, id);
    }

    @Override
    public void updateUser(User user) {
        executeInTransaction((em) -> em.merge(user));
    }

    @Override
    public void deleteUser(Long id) {
        executeInTransaction((em) -> {
            User user = em.find(User.class, id);
            if (user != null) {
                em.remove(user);
            }
        });
    }

    @Override
    public List<User> listUsers() {
        return em.createQuery("SELECT u FROM User u", User.class).getResultList();
    }

    @Override
    public List<User> search(String query) {
        List<User> users = null;
        try {
            users = em.createQuery("SELECT u FROM User u WHERE u.username LIKE :query OR u.firstName LIKE :query OR u.lastName LIKE :query", User.class)
                    .setParameter("query", "%" + query + "%")
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    // Utility method for handling transactions
    private void executeInTransaction(EntityManagerAction action) {
        try {
            em.getTransaction().begin();
            action.execute(em);
            em.getTransaction().commit();
        } catch (RuntimeException e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;  // rethrow the exception after rollback
        }
    }

    // Functional interface for transaction actions
    @FunctionalInterface
    private interface EntityManagerAction {
        void execute(EntityManager em);
    }
}
