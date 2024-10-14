package org.example.service;

import org.example.entity.Request;
import org.example.enums.UserRole;

import java.util.List;

public interface RequestService {
    void createRequest(Request request);

    Request readRequest(long id);

    void updateRequest(Request request);

}
