package org.example.service;

import org.example.entity.Request;
import org.example.entity.Request;
import org.example.enums.UserRole;
import org.example.repository.RequestRepository;
import org.example.repository.RequestRepositoryImpl;

public class RequestServiceImpl implements RequestService {
    RequestRepository  requestRepository = new RequestRepositoryImpl();
    @Override
    public void createRequest(Request request) {
        requestRepository.createRequest(request);
    }

    @Override
    public Request readRequest(long id) {
        return requestRepository.readRequest(id);
    }

    @Override
    public void updateRequest(Request request) {
            requestRepository.updateRequest(request);
    }
}
