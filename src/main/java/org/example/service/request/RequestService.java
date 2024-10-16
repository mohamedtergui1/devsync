package org.example.service.request;

import org.example.entity.Request;

public interface RequestService {
    void createRequest(Request request);

    Request readRequest(long id);

    void updateRequest(Request request);
}
