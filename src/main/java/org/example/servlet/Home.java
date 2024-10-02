package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.repository.UserRepositoryImpl;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/home")
public class Home extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        new UserRepositoryImpl();
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Home Page</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1>Welcome to the Home Page!</h1>");
        out.println("<p>This is a simple servlet response.</p>");
        out.println("<p>Test message: Hello, World!</p>");
        out.println("</body>");
        out.println("</html>");
    }
}
