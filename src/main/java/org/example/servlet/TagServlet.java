package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entity.Tag;
import org.example.entity.User;
import org.example.service.TagService;
import org.example.service.TagServiceImpl;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "tags",urlPatterns = "/tags")
public class TagServlet extends HttpServlet {
    TagService tagService = new TagServiceImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Tag>  tags =  tagService.listTags();
        req.setAttribute("tags", tags);
        req.getRequestDispatcher("tags.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        if(req.getParameter("_method") == null) {
            tagService.createTag(new Tag(req.getParameter("name")));
        } else {
            if (req.getParameter("_method").equalsIgnoreCase("delete"))
                delete(req, resp);
            else if (req.getParameter("_method").equalsIgnoreCase("put")){
                put(req, resp);
            }
        }
        resp.sendRedirect("tags");
    }

    private void put(HttpServletRequest req, HttpServletResponse resp) {
        System.out.println(req.getParameter("_method"));
        System.out.println(req.getParameter("name"));
        System.out.println(req.getParameter("id"));
        Tag tag = new Tag(req.getParameter("name"));
        tag.setId(Long.parseLong((req.getParameter("id"))));
        tagService.updateTag(tag);

    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) {
        Long id = Long.valueOf((req.getParameter("id")));
        tagService.deleteTag(id);
    }
}
