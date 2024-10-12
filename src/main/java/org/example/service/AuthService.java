package org.example.service;

import org.example.entity.User;

public interface AuthService  {
    public User login(String username, String password);

}
