package org.example.service;

import org.example.entity.User;

public interface LoginService {
    public User authenticate(String username, String password);
}
