package org.example.repository;

import org.example.entity.User;

public interface TokenRepository {
    void createToken(User user);
}
