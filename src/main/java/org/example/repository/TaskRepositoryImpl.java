package org.example.repository;

import jakarta.persistence.EntityManager;


import org.example.entity.Task;

import java.util.List;

public class TaskRepositoryImpl extends Repository  implements TaskRepository {


    @Override
    public void createTask(Task task) {
        executeInTransaction((em)-> em.persist(task));
    }

    @Override
    public Task readTask(Long id) {
       EntityManager  entityManager = emf.createEntityManager();
       Task task = entityManager.find(Task.class, id);
       entityManager.close();
       return  task;
    }

    @Override
    public void updateTask(Task TASK) {
       executeInTransaction((em)-> em.merge(TASK));
    }

    @Override
    public void deleteTask(Long id) {
       executeInTransaction(em-> {
           Task task = em.find(Task.class, id);
           if(task != null) {
               em.remove(task);
           }
       });
    }

    @Override
    public List<Task> listTasks() {
        EntityManager  entityManager = emf.createEntityManager();
        List<Task> tasks = entityManager.createQuery("SELECT T from Task T", Task.class).getResultList();
        entityManager.close();
        return  tasks ;
    }


}
