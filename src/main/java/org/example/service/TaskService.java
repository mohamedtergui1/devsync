package org.example.service;

import org.example.entity.Task;

import java.util.List;

public interface TaskService {
    void createTag(Task task);

    Task readTask(long id);

    List<Task> listTasks();

    void updateTask(Task task);

    void deleteTask(Long id);
}
