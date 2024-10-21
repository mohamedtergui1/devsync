package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entity.Tag;
import org.example.service.StatisticService;
import org.example.service.StatisticServiceImpl;

import java.io.IOException;
import java.util.Map;
@WebServlet(urlPatterns = "/statistic")
public class StatisticServlet extends HttpServlet {
    StatisticService service = new StatisticServiceImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String,Long> counts = service.getStatisticscOUNT();
        Map<Tag,Long> countTasksbyTag = service.getCountTasksByTag();
        req.setAttribute("counts", counts);
        //req.setAttribute("countTasksbyTag", countTasksbyTag);
        req.getRequestDispatcher("mainStatistic.jsp").forward(req, resp);
    }
}
