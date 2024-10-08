package org.example.servlet;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entity.User;
import org.example.enums.UserRole;
import org.example.service.UserService;
import org.example.service.UserServiceImpl;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.util.List;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
    @Inject()
    private  UserService userService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<User> users = userService.listUsers();
        req.setAttribute("users", users);
        req.getRequestDispatcher("/main.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User newUser = new User();

        if(req.getParameter("_method") == null) {
            newUser.setPassword(BCrypt.hashpw(req.getParameter("password"), BCrypt.gensalt()));
            mapData(req, newUser);
            userService.createUser(newUser);
        } else {
            if (req.getParameter("_method").equalsIgnoreCase("delete"))
                Delete(req, resp);
            else if (req.getParameter("_method").equalsIgnoreCase("put")){
                Put(req, resp);
            }
        }
        resp.sendRedirect("");
    }

    private void mapData(HttpServletRequest req, User newUser) {
        newUser.setUsername(req.getParameter("username"));
        newUser.setFirstName(req.getParameter("firstName"));
        newUser.setLastName(req.getParameter("lastName"));
        newUser.setEmail(req.getParameter("email"));
        newUser.setRole(UserRole.valueOf(req.getParameter("role")));
    }

    protected void Delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        userService.deleteUser(Long.parseLong(req.getParameter("id")));
    }

    protected void Put(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User newUser = new User();
        newUser.setId(Long.valueOf(req.getParameter("id")));
        if(req.getParameter("password") != null && !req.getParameter("password").isEmpty()) {
            String plainPassword = req.getParameter("password");
            String hashedPassword = BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));
            newUser.setPassword(hashedPassword);
        }
        else {
            newUser.setPassword(userService.readUser(newUser.getId()).getPassword());
        }
        mapData(req, newUser);
        userService.updateUser(newUser);
    }
}