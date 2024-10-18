package org.example.service;

import jakarta.annotation.security.RolesAllowed;
import org.example.entity.User;
import org.example.repository.UserRepository;
import org.example.repository.UserRepositoryImpl;

import java.util.List;

public class UserServiceImpl implements UserService {

    private  UserRepository userRepository = new UserRepositoryImpl();

    public UserServiceImpl(UserRepository userRepository) {

    }
    public UserServiceImpl(){

    }

    @Override
    public void createUser(User user) {
        userRepository.createUser(user);
    }

    @Override
    public User readUser(long id) {
        return userRepository.readUser(id);
    }

    @Override
    public List<User> listUsers() {
        return userRepository.listUsers();
    }

    @Override
    public void updateUser(User user) {
        userRepository.updateUser(user);
    }

    @Override
    public void deleteUser(Long id) {
        userRepository.deleteUser(id);
    }

    @Override
    public List<User> search(String query) {
        return userRepository.search(query);
    }
}