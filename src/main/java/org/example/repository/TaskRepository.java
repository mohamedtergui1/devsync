package org.example.repository;

import org.example.entity.Task;

import java.util.List;

public interface TaskRepository {
    void createTask(Task TASK);

    Task readTask(Long id);

    void updateTask(Task TASK);

    void deleteTask(Long id);

    List<Task> listTasks();
}
