package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entity.Request;
import org.example.entity.Task;
import org.example.entity.Token;
import org.example.entity.User;
import org.example.enums.UserRole;
import org.example.service.*;

import java.io.IOException;

@WebServlet(name = "request", urlPatterns = "/request")
public class RequestServlet extends HttpServlet {
    private TaskService taskService = new TaskServiceImpl();
    private RequestService requestService = new RequestServiceImpl();
    private UserService userService = new UserServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            User authUser = (User) req.getSession().getAttribute("authenticatedUser");
            Long id = Long.parseLong(req.getParameter("id").trim());

            Request request = new Request();

            if (req.getParameter("_method") == null) {
                Task task = taskService.readTask(id);
                if (task != null && task.getAssignedTo().getId() == authUser.getId()) {
                    taskService.updateTask(task, UserRole.USER);
                    if (task.getRequest() == null && task.getAssignedTo().getToken().getUpdateTokenCount() > 0) {
                        request.setTask(task);
                        requestService.createRequest(request);
                    }
                }
            } else if (req.getParameter("_method").equalsIgnoreCase("accept") && authUser.getRole() == UserRole.MANAGER) {
                request = requestService.readRequest(Long.parseLong(req.getParameter("id")));
                request.setStatus('A');
                requestService.updateRequest(request);
                Task task = request.getTask();
                User user = userService.readUser(Long.parseLong(req.getParameter("newAssign").trim()));
                task.setAssignedTo(user);
                taskService.updateTask(task, UserRole.MANAGER);

            } else if (req.getParameter("_method").equalsIgnoreCase("reject") && authUser.getRole() == UserRole.MANAGER) {
                request = requestService.readRequest(Long.parseLong(req.getParameter("id")));
                request.setStatus('R');
                requestService.updateRequest(request);
            }
        } catch (NumberFormatException e) {
            System.out.println(e.getMessage());
        }


        resp.sendRedirect("tasks");

    }
}
