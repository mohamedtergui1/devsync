package org.example.repository;

import jakarta.ejb.Local;
import org.example.entity.User;

public interface FindUserBYEmail {
    public User findUserByEmail(String email);
}
