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

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<User> users = userService.listUsers();
        req.setAttribute("users", users);
        req.getRequestDispatcher("/main.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws  IOException {
        User newUser = new User();
        mapData(req, newUser);
        userService.createUser(newUser);
        resp.sendRedirect("user");
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws  IOException {
        User newUser = new User();
        newUser.setId((long) Integer.parseInt(req.getParameter("id")));
        mapData(req, newUser);
        userService.updateUser(newUser);
        resp.sendRedirect("user");
    }

    private void mapData(HttpServletRequest req, User newUser) {
        newUser.setUsername(req.getParameter("username"));
        newUser.setPassword(req.getParameter("password"));
        newUser.setFirstName(req.getParameter("firstName"));
        newUser.setLastName(req.getParameter("lastName"));
        newUser.setEmail(req.getParameter("email"));
        newUser.setRole(UserRole.valueOf(req.getParameter("role")));
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp)  {
        userService.deleteUser((long) Integer.parseInt(req.getParameter("id")));
    }
}
