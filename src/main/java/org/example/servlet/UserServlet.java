package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entity.User;
import org.example.enums.UserRole;
import org.example.service.UserService;
import org.example.service.UserServiceImpl;

import java.io.IOException;
import java.util.List;

@WebServlet("/user")
public class UserServlet extends HttpServlet {

    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // List all users
        List<User> users = userService.listUsers();
        req.setAttribute("users", users);
        req.getRequestDispatcher("/main.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Create a new user from request parameters
        User newUser = new User();
        newUser.setUsername(req.getParameter("username"));
        newUser.setPassword(req.getParameter("password")); // Hash this before saving
        newUser.setFirstName(req.getParameter("firstName"));
        newUser.setLastName(req.getParameter("lastName"));
        newUser.setEmail(req.getParameter("email"));
        newUser.setRole(UserRole.valueOf(req.getParameter("role"))); // Ensure this is safe

        userService.createUser(newUser);
        resp.sendRedirect("user"); // Redirect to the user list
    }
}
