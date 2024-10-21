package org.example.service;

import jakarta.ejb.Schedule;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Persistence;
import org.example.entity.Request;
import org.example.entity.Task;
import org.example.entity.Token;
import org.example.enums.TaskStatus;

import java.time.LocalDateTime;
import java.util.List;

@Stateless
public class AutoServiceImpl implements AutoService {


    @Schedule(hour = "0", minute = "0", persistent = false)
    public void editToken() {
        EntityManager em = Persistence.createEntityManagerFactory("jpa").createEntityManager();
        try {
            em.getTransaction().begin();
            List<Token> tokens = em.createQuery("from Token", Token.class).getResultList();
            for (Token token : tokens) {
                token.setUpdateTokenCount(2);
                em.merge(token);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Schedule(hour = "*", minute = "0", second = "0", persistent = false)
    public void checkRequestDate() {
        EntityManager em = Persistence.createEntityManagerFactory("jpa").createEntityManager();
        try {
            LocalDateTime time = LocalDateTime.now().plusHours(12);

            List<Request> requests = em.createQuery("FROM Request r WHERE r.status = :status AND r.dueDate > :time", Request.class)
                    .setParameter("status", TaskStatus.COMPLETED)
                    .setParameter("time", time)
                    .getResultList();

            em.getTransaction().begin();
            for (Request request : requests) {
                Token token = request.getTask().getAssignedTo().getToken();
                token.setUpdateTokenCount(token.getUpdateTokenCount() + 2);
                token.setDeletionTokenCount(token.getDeletionTokenCount() + 1);
                em.merge(token);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
        } finally {
            em.close();
        }
    }

    @Schedule( second = "0", persistent = false)
    public void checkTaskDueDate() {
        EntityManager em = Persistence.createEntityManagerFactory("jpa").createEntityManager();
        try {

            List<Task> tasks = em.createQuery("from Task t WHERE t.status != :status AND t.dueDate < CURRENT_TIMESTAMP", Task.class)
                    .setParameter("status", TaskStatus.COMPLETED)
                    .getResultList();

            for (Task task : tasks) {
                task.setStatus(TaskStatus.OVERDUE);
                em.merge(task);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            em.close();
        }
    }



    @Schedule(dayOfMonth = "1", hour = "0", minute = "0", persistent = false)
    public void deleteToken() {
        EntityManager em = Persistence.createEntityManagerFactory("jpa").createEntityManager();
        try {
            em.getTransaction().begin();
            List<Token> tokens = em.createQuery("from Token", Token.class).getResultList();
            for (Token token : tokens) {
                token.setDeletionTokenCount(1);
                em.merge(token);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}
