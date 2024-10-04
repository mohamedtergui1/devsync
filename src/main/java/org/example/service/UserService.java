package org.example.service;

import org.example.entity.User;

import java.util.List;

public interface UserService {
    void createUser(User user);
    User readUser(long id);
    List<User> listUsers();
    void updateUser(User user);
    void deleteUser(Long id);

    List<User> search(String query);
}
