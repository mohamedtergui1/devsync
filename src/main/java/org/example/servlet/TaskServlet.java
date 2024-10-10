package org.example.servlet;

import jakarta.ejb.EJB;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.example.entity.Task;
import org.example.service.TaskService;
import org.example.service.TaskServiceImpl;

import java.io.IOException;
import java.util.List;
@WebServlet(name = "tasks" , urlPatterns = "/tasks")
public class TaskServlet  extends HttpServlet {
    @EJB
    TaskService taskService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Task> tasks =  taskService.listTasks();
        req.setAttribute("tasks", tasks);
        req.getRequestDispatcher("tasks.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
