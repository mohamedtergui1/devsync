package org.example.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.entity.User;
import org.example.service.LoginService;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @EJB
    private LoginService loginService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");


        User authenticatedUser = loginService.authenticate(email, password);

        if (authenticatedUser != null) {

            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            session = request.getSession(true);
            session.setAttribute("loggedInUser", authenticatedUser);

        } else {

            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}
