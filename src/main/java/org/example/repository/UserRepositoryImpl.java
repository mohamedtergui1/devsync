package org.example.repository;

import jakarta.persistence.EntityManager;

import org.example.entity.User;


import java.util.List;

public class UserRepositoryImpl extends Repository implements UserRepository {



    @Override
    public void createUser(User user) {
        executeInTransaction((em)-> em.persist(user));
    }

    @Override
    public User readUser(Long id) {
        EntityManager em = emf.createEntityManager();
        User user = em.find(User.class, id);
        em.close();
        return user;
    }

    @Override
    public void updateUser(User user) {
         executeInTransaction((em)-> em.merge(user));
    }

    @Override
    public void deleteUser(Long id) {
        executeInTransaction((em)-> {
            User user = em.find(User.class, id);
            if(user != null) {
                em.remove(user);
            }
        });
    }

    @Override
    public List<User> listUsers() {
        EntityManager em = emf.createEntityManager();
        List<User> users = em.createQuery("SELECT u FROM User u", User.class).getResultList();
        em.close();
        return users;
    }

    @Override
    public List<User> search(String query) {
        List<User> users = null;
        EntityManager em = emf.createEntityManager();
        try {
            users = em.createQuery("SELECT u FROM User u WHERE u.username LIKE :query or u.firstName LIKE :query or u.lastName lIKE :query", User.class)
                    .setParameter("query", "%" + query + "%")
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return users;
    }

}
