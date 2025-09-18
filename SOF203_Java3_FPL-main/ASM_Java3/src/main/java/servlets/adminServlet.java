package servlets;

import java.io.IOException;
import java.util.List;

import DAO.NewsDAO;
import DAO.NewslettersDAO;
import DAO.UserDAO;
import Model.News;
import Model.Users;
import Model.Newsletters;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet({"/admin/tintuc", "/admin/loaitin", "/admin/nguoidung", "/admin/newsletter"})
public class adminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Users user = session == null ? null : (Users) session.getAttribute("user");

        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        String uri = request.getRequestURI();

        if (!user.isRole() && !uri.contains("/admin/loaitin")) {
            response.sendRedirect(request.getContextPath() + "/admin/loaitin");
            return;
        }

        String menu;
        if (uri.contains("/admin/tintuc")) {
            menu = "tintuc.jsp";
            List<News> listNews = NewsDAO.getAllNews();
            request.setAttribute("listNews", listNews);

        } else if (uri.contains("/admin/loaitin")) {
            menu = "loaitin.jsp";
            List<Users> userList = UserDAO.getAllUsers();
            request.setAttribute("userList", userList);

        } else if (uri.contains("/admin/nguoidung")) {
            menu = "nguoidung.jsp";
            List<Newsletters> subscribers = new NewslettersDAO().findAll();
            request.setAttribute("subscribers", subscribers);

        } else {  // /admin/newsletter
            menu = "newsletter.jsp";
        }

        request.setAttribute("menu", menu);
        request.getRequestDispatcher("/views/admin.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();

        if (uri.contains("/admin/nguoidung")) {
            String email        = request.getParameter("email");
            String enabledParam = request.getParameter("enabled");
            String action       = request.getParameter("action");
            String deleteEmail  = request.getParameter("delete");

            NewslettersDAO dao = new NewslettersDAO();

            if (action != null && email != null && enabledParam != null) {
                boolean enabled = "1".equals(enabledParam);
                Newsletters nl = new Newsletters(email, enabled);
                switch (action) {
                    case "add":    dao.create(nl); break;
                    case "edit":   dao.update(nl); break;
                    case "delete": dao.deleteById(email); break;
                }
            } else if (deleteEmail != null && !deleteEmail.isEmpty()) {
                dao.deleteById(deleteEmail);
            }

            response.sendRedirect(request.getContextPath() + "/admin/nguoidung");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/tintuc");
        }
    }
}
