package servlets;

import DAO.NewsDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/deletenews")
public class DeleteNewsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id != null) {
            NewsDAO.deleteNews(id);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/tintuc");
    }
}
