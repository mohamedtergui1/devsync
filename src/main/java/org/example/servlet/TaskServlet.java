package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.example.entity.Tag;
import org.example.entity.Task;
import org.example.entity.User;
import org.example.enums.TaskStatus;
import org.example.enums.UserRole;
import org.example.service.*;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
@WebServlet(name = "tasks" , urlPatterns = "/tasks")
public class TaskServlet  extends HttpServlet {
    TaskService taskService = new TaskServiceImpl();
    UserService userService = new UserServiceImpl();
    TagService tagService = new TagServiceImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User authenticatedUser = (User) req.getSession().getAttribute("authenticatedUser");
        if( authenticatedUser == null ) {
            resp.sendRedirect("login.jsp");
            return;
        }

        List<Task> tasks =  authenticatedUser.getRole() == UserRole.MANAGER ?  taskService.listTasks() : taskService.listTasksByUser(authenticatedUser.getId());
        List<User> users =  userService.listUsers();
        List<Tag> tags = tagService.listTags();
        req.setAttribute("tasks", tasks);
        req.setAttribute("users", users);
        req.setAttribute("tags", tags);
        req.getRequestDispatcher("tasks.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        if(req.getParameter("_method") == null) {
            String dueDateStr = req.getParameter("due_date");

            if (dueDateStr == null || dueDateStr.isEmpty()) {
                req.setAttribute("error", "Due date is required");
                doGet(req, resp);
                return;
            }


            DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
            LocalDateTime dueDate = LocalDateTime.parse(dueDateStr, formatter);


            LocalDateTime now = LocalDateTime.now();
            LocalDateTime threeDaysLater = now.plusDays(3);


            if (!dueDate.isAfter(threeDaysLater)) {
                req.setAttribute("error", "Due date must be within 3 days from now");
                doGet(req, resp);
                return;
            }
            User auth = (User) req.getSession().getAttribute("authenticatedUser");
            Task task = new Task();
            mapData(req, task);
            if (auth.getRole() == UserRole.MANAGER)
                 task.setAssignedTo(userService.readUser(Long.parseLong(req.getParameter("assigned_to"))));
            else
                task.setAssignedTo(auth);

            task.setCreatedBy(auth);

            task.setCompleted(false);
            task.setStatus(TaskStatus.PENDING);

            taskService.createTask(task);
        } else {
            if (req.getParameter("_method").equalsIgnoreCase("delete"))
                taskService.deleteTask(Long.parseLong(req.getParameter("id")));
            else if (req.getParameter("_method").equalsIgnoreCase("put")){
                String dueDateStr = req.getParameter("due_date");

                if (dueDateStr == null || dueDateStr.isEmpty()) {
                    req.setAttribute("error", "Due date is required");
                    doGet(req, resp);
                    return;
                }


                DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
                LocalDateTime dueDate = LocalDateTime.parse(dueDateStr, formatter);


                LocalDateTime now = LocalDateTime.now();
                LocalDateTime threeDaysLater = now.plusDays(3);


                if (!dueDate.isAfter(threeDaysLater)) {
                    req.setAttribute("error", "Due date must be within 3 days from now");
                    doGet(req, resp);
                    return;
                }
                put(req, resp);
            }
        }
        resp.sendRedirect("tasks");
    }
    public void put(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        User auth = (User) req.getSession().getAttribute("authenticatedUser");
        Task task = taskService.readTask(Long.parseLong(req.getParameter("id")));
        mapData(req, task);

        if (auth.getRole() == UserRole.MANAGER)
            task.setAssignedTo(userService.readUser(Long.parseLong(req.getParameter("assigned_to"))));
        
        // Get the selected tag IDs from the request
        

        taskService.updateTask(task);
    }

    private void mapData(HttpServletRequest req, Task task) {
        task.setTitle(req.getParameter("title"));
        task.setDescription(req.getParameter("description"));
        task.setDueDate(LocalDateTime.parse(req.getParameter("due_date")));
        String[] selectedTags = req.getParameterValues("tags[]");
        List<Tag> tags = new ArrayList<>();

        if (selectedTags != null) {
            for (String tagId : selectedTags) {
                tags.add(tagService.readTag(Long.parseLong(tagId)));
            }
        }
        task.setTags(tags);
    }
}
