package org.example.repository;


import jakarta.persistence.EntityManager;
import org.example.entity.Task;
import org.example.entity.Token;
import org.example.enums.UserRole;
import org.example.repository.base.Repository;

import java.util.ArrayList;
import java.util.List;

public class TaskRepositoryImpl extends Repository implements TaskRepository,StatisticOfEntity {

    @Override
    public void createTask(Task task) {
        executeInTransaction((em) -> em.persist(task));
    }

    @Override
    public Task readTask(Long id) {
        EntityManager em = emf.createEntityManager();

        Task task = em.find(Task.class, id);
        em.close();
        return task;
    }

    @Override
    public void   updateTask(Task TASK,UserRole role) {
        executeInTransaction((em) ->
                {
                    em.merge(TASK);
                        if(TASK.getCreatedBy() != TASK.getAssignedTo() || UserRole.MANAGER != role ) {
                            Token token = TASK.getAssignedTo().getToken();
                            token.setUpdateTokenCount(token.getUpdateTokenCount()-1);
                            em.merge(token);
                        }

                });
    }

    @Override
    public void deleteTask(Long id , UserRole role) {
        executeInTransaction(em -> {
            Task task = em.find(Task.class, id);
            if (task != null) {

                if(task.getCreatedBy() != task.getAssignedTo() || role != UserRole.MANAGER ){
                    Token token = task.getAssignedTo().getToken();
                    token.setDeletionTokenCount(token.getDeletionTokenCount()-1);
                    em.merge(token);
                }
                em.remove(task);
            }
        });
    }

    @Override
    public List<Task> listTasks() {
        EntityManager em = emf.createEntityManager();
        List<Task> tasks = em.createQuery("SELECT T from Task T", Task.class).getResultList();
        em.close();
        return tasks;
    }

    @Override
    public List<Task> listTasksByUser(Long id) {
        EntityManager entityManager = null;
        List<Task> tasks = new ArrayList<>();

        try {
            entityManager = emf.createEntityManager();
            tasks = entityManager.createQuery("SELECT T FROM Task T WHERE T.assignedTo.id = :id", Task.class)
                    .setParameter("id", id)
                    .getResultList();
        } finally {
            if (entityManager != null) {
                entityManager.close();
            }
        }

        return tasks;
    }


    @Override
    public Long getCount() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT COUNT(t) FROM Task t", Long.class).getSingleResult();
        } finally {
            em.close(); // Close the EntityManager to avoid resource leaks
        }
    }

}
