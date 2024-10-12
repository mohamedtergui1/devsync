package org.example.service;

import org.example.entity.Task;

import java.util.List;

public interface TaskService {
    void createTask(Task task);

    Task readTask(long id);

    List<Task> listTasks();

    void updateTask(Task task);

    void deleteTask(Long id);

    List<Task> listTasksByUser(Long id);
}
