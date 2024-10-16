package org.example.service.user;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.example.entity.Task;
import org.example.entity.User;

import java.util.List;

@Stateless
public class UserServiceImpl implements UserService {

    @PersistenceContext(unitName = "jpa")
    private EntityManager em;

    @Override
    public void createUser(User user) {
        em.persist(user);
    }

    @Override
    public User readUser(Long id) {
        return em.find(User.class, id);
    }

    @Override
    public void updateUser(User user) {
         em.merge(user);
    }

    @Override
    public void deleteUser(Long id) {
            User user = em.find(User.class, id);
            if (user != null) {
                em.remove(user);
            }
    }

    @Override
    public List<User> listUsers() {
        return em.createQuery("SELECT u FROM User u", User.class).getResultList();
    }

    @Override
    public List<User> search(String query) {
          return em.createQuery("SELECT u FROM User u WHERE u.username LIKE :query OR u.firstName LIKE :query OR u.lastName LIKE :query", User.class)
                    .setParameter("query", "%" + query + "%")
                    .getResultList();

    }



}
