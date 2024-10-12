package org.example.repository;

import org.example.entity.Task;
import org.example.enums.UserRole;

import java.util.List;

public interface TaskRepository {
    void createTask(Task TASK);

    Task readTask(Long id);

    void updateTask(Task TASK,UserRole role);

    void deleteTask(Long id, UserRole userRole);


    List<Task> listTasks();

    List<Task> listTasksByUser(Long id);
}
