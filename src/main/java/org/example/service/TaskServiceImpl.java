package org.example.service;

import org.example.entity.Task;
import org.example.enums.UserRole;
import org.example.repository.TaskRepository;
import org.example.repository.TaskRepositoryImpl;

import java.util.List;

public class TaskServiceImpl implements TaskService {
    public TaskRepository taskRepository = new TaskRepositoryImpl();

    @Override
    public void createTask(Task task) {
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
    public void updateTask(Task task,UserRole role) {
        taskRepository.updateTask(task,role);
    }

    @Override
    public void deleteTask(Long id, UserRole userRole) {
        taskRepository.deleteTask(id,userRole);
    }

    @Override
    public List<Task> listTasksByUser(Long id) {
        return taskRepository.listTasksByUser(id);
    }
}
