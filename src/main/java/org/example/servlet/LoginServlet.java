package org.example.servlet;

import org.example.entity.User;
import org.example.service.AuthService;
import org.example.service.AuthServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import java.io.IOException;

@WebServlet("/login")  // The URL pattern for this servlet
public class LoginServlet extends HttpServlet {

    private AuthService authService;

    // Hibernate SessionFactory setup
    private static SessionFactory sessionFactory;

    @Override
    public void init() throws ServletException {
        super.init();
        // Initialize the AuthService (no DI or EJB, just direct instantiation)
        authService = new AuthServiceImpl();


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the parameters from the login form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            // Use AuthService to log in the user
            User user = authService.login(username, password);

            // Store the authenticated user in the session
                request.getSession().setAttribute("authenticatedUser", user);

            // Redirect to a welcome page after successful login
            response.sendRedirect("welcome.jsp");
        } catch (RuntimeException e) {
            // If login fails, forward back to the login page with an error message
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    @Override
    public void destroy() {
        // Close the SessionFactory when the servlet is destroyed
        sessionFactory.close();
    }
}
