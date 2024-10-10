package org.example.repository;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.example.entity.Task;

import java.util.List;

@Stateless
public class TaskRepositoryImpl implements TaskRepository {

    @PersistenceContext(unitName = "jpa")
    private EntityManager em;  // Injecting the EntityManager

    @Override
    public void createTask(Task task) {
        executeInTransaction((em) -> em.persist(task));
    }

    @Override
    public Task readTask(Long id) {
        return em.find(Task.class, id);
    }

    @Override
    public void updateTask(Task task) {
        executeInTransaction((em) -> em.merge(task));
    }

    @Override
    public void deleteTask(Long id) {
        executeInTransaction(em -> {
            Task task = em.find(Task.class, id);
            if (task != null) {
                em.remove(task);
            }
        });
    }

    @Override
    public List<Task> listTasks() {
        return em.createQuery("SELECT t FROM Task t", Task.class).getResultList();
    }

    // Utility method for handling transactions, since you aren't extending the base Repository class.
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
