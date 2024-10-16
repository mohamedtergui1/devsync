package org.example.service.auth;

import org.example.entity.User;

public interface AuthService {
    User login  (String email, String password);
}
