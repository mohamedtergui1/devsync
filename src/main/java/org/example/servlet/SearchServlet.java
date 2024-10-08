package org.example.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entity.User;
import org.example.service.UserService;
import org.example.service.UserServiceImpl;

import java.io.IOException;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws  IOException {
        UserService userService = new UserServiceImpl();
        String query = req.getParameter("query");
        List<User> users = userService.search(query);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        objectMapper.writeValue(resp.getOutputStream(), users);
    }
}
