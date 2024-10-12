package org.example.service;

import org.example.entity.Task;
import org.example.enums.UserRole;

import java.util.List;

public interface TaskService {
    void createTask(Task task);

    Task readTask(long id);

    List<Task> listTasks();

    void updateTask(Task task, UserRole userRole);

    void deleteTask(Long id, UserRole userRole);

    List<Task> listTasksByUser(Long id);
}
