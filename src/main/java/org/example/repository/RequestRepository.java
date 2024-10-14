package org.example.repository;

import org.example.entity.Request;

public interface RequestRepository {
    void createRequest(Request request);

    Request readRequest(Long id);

    void updateRequest(Request request);
}
