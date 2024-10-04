package org.example.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import org.example.entity.User;
import org.hibernate.service.spi.InjectService;

import java.util.List;

public class UserRepositoryImpl implements UserRepository {

    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa");

    @Override
    public void createUser(User user) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(user);
        em.getTransaction().commit();
        em.close();
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
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.merge(user);
        em.getTransaction().commit();
        em.close();
    }

    @Override
    public void deleteUser(Long id) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        User user = em.find(User.class, id);
        if (user != null) {
            em.remove(user);
        }
        em.getTransaction().commit();
        em.close();
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
