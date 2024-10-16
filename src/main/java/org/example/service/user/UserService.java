package org.example.service.user;

import org.example.entity.User;

import java.util.List;

public interface UserService {
    void createUser(User user);
    User readUser(Long id);
    void updateUser(User user);
    void deleteUser(Long id);
    List<User> listUsers();
    List<User> search(String query);

}
