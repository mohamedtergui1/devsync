package org.example.service.auth;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.example.entity.User;
import org.mindrot.jbcrypt.BCrypt;

@Stateless
public class AuthServiceImpl implements AuthService {
    @PersistenceContext(unitName = "jpa")
    EntityManager em;

    @Override
    public User login(String email, String password) {
        if (email == null || password == null)
            return null;
        User user = em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class)
                .setParameter("email", email)
                .getSingleResult();
        if (user == null) {
            throw new RuntimeException("Invalid credentials: User not found.");
        }

        if (!BCrypt.checkpw(password, user.getPassword())) {
            throw new RuntimeException("Invalid credentials: Incorrect password.");
        }
        return user;
    }
}