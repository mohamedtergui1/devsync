package org.example.service;

import jakarta.ejb.EJB;

import jakarta.ejb.Stateless;
import jakarta.inject.Inject;
import org.example.entity.Task;
import org.example.repository.TaskRepository;


import java.util.List;
@Stateless
public class TaskServiceImpl implements TaskService {
    @Inject
    TaskRepository taskRepository;

    @Override
    public void createTag(Task task) {
        taskRepository.createTask(task);
    }

    @Override
    public Task readTask(long id) {
        return taskRepository.readTask(id);
    }

    @Override
    public List<Task> listTasks() {
        return taskRepository.listTasks();
    }

    @Override
    public void updateTask(Task task) {
        taskRepository.updateTask(task);
    }

    @Override
    public void deleteTask(Long id) {
        taskRepository.deleteTask(id);
    }
}
