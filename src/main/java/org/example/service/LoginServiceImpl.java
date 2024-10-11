package org.example.service;

import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;
import org.example.entity.User;
import org.example.repository.FindUserBYEmail;
import org.mindrot.jbcrypt.BCrypt;

@Stateless
public class LoginServiceImpl implements LoginService {
    @Inject
    FindUserBYEmail findUserBYEmail;

    public User authenticate(String email, String password) {
        try {

            User user =  findUserBYEmail.findUserByEmail(email);

            if (user != null && BCrypt.checkpw(password, user.getPassword())) {
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
