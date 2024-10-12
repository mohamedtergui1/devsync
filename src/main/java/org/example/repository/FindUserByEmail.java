package org.example.repository;

import org.example.entity.User;

public interface FindUserByEmail {
    public User findUserByEmail(String email);
}
