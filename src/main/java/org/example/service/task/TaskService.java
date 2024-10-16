package org.example.service.task;

import org.example.entity.Task;

import java.util.List;


public interface TaskService {
    void createTask(Task TASK);

    Task readTask(Long id);

    void updateTask(Task TASK);

    void deleteTask(Long id);

    List<Task> listTasks();

    List<Task> listTasksByUser(Long id);
}
