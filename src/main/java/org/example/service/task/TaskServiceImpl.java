package org.example.service.task;

import jakarta.ejb.Stateless;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.example.entity.Task;
import org.example.errors.ErrorLogger;

import java.util.List;

@Stateless
public class TaskServiceImpl implements TaskService {

    @PersistenceContext(unitName = "jpa")
    private EntityManager em;
    @Inject
    ErrorLogger errorLogger;
    @Override
    public void createTask(Task task) {
        em.persist(task);
    }

    @Override
    public Task readTask(Long id) {
        return em.find(Task.class, id);
    }

    @Override
    public void updateTask(Task task) {
        em.merge(task);
    }

    @Override
    public void deleteTask(Long id) {
        Task task = em.find(Task.class, id);
        if (task != null) {
            em.remove(task);
        }
    }

    @Override
    public List<Task> listTasks() {
        return em.createQuery("SELECT t FROM Task t", Task.class).getResultList();
    }

    @Override
    public List<Task> listTasksByUser(Long id) {
        return em.createQuery("SELECT T FROM Task T WHERE T.assignedTo.id = :id", Task.class)
                .setParameter("id", id)
                .getResultList();
    }

}
