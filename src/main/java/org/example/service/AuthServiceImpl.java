package org.example.service;

import org.example.entity.User;
import org.example.repository.FindUserByEmail;
import org.example.repository.UserRepositoryImpl;
import org.mindrot.jbcrypt.BCrypt;

public class AuthServiceImpl implements AuthService {

    // Directly instantiate the repository
    private FindUserByEmail findUserByEmail = new UserRepositoryImpl();

    @Override
    public User login(String username, String password) {
        // Find the user by email (assuming username is the email)
        User user = findUserByEmail.findUserByEmail(username);

        if (user == null) {
            throw new RuntimeException("Invalid credentials: User not found.");
        }


        if (!BCrypt.checkpw(password, user.getPassword())) {
            throw new RuntimeException("Invalid credentials: Incorrect password.");
        }

        return user;  // Successful login
    }
}
