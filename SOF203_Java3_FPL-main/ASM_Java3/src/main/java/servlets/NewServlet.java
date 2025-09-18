package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import DAO.NewsDAO;
import DAO.NewslettersDAO;
import Model.News;
import Model.Newsletters;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet({
    "/NewServlet",         
    "/news/trangchu",
    "/news/vanhoa",
    "/news/phapluat",
    "/news/thethao",
    "/news/chitiet"
})
public class NewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private List<News> lNews;

    public NewServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();
        String page = "trangchu.jsp";
        lNews = NewsDAO.getAllNewsOnHome();

        if (uri.contains("/vanhoa")) {
            lNews = NewsDAO.getNewsByCategory("VH");
            page = "vanhoa.jsp";
        } else if (uri.contains("/phapluat")) {
            lNews = NewsDAO.getNewsByCategory("PL");
            page = "phapluat.jsp";
        } else if (uri.contains("/thethao")) {
            lNews = NewsDAO.getNewsByCategory("TT");
            page = "thethao.jsp";
        } else if (uri.contains("/chitiet")) {
            String id = request.getParameter("id");
            if (id == null || id.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/news/trangchu");
                return;
            }
            NewsDAO.incrementViewCount(id);
            News detail = NewsDAO.getNewsById(id);
            request.setAttribute("news", detail);

            HttpSession session = request.getSession();
            @SuppressWarnings("unchecked")
            LinkedList<String> recentIds = (LinkedList<String>) session.getAttribute("recentView");
            if (recentIds == null) recentIds = new LinkedList<>();
            recentIds.remove(id);
            recentIds.addFirst(id);
            if (recentIds.size() > 5) recentIds.removeLast();
            session.setAttribute("recentView", recentIds);

            page = "chitiet.jsp";
        }

        List<News> top5    = NewsDAO.getTop5ViewCount();
        List<News> latest5 = NewsDAO.getLatest5();
        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        LinkedList<String> recentIds = (LinkedList<String>) session.getAttribute("recentView");
        List<News> recent5 = new ArrayList<>();
        if (recentIds != null) {
            for (String rid : recentIds) {
                News n = NewsDAO.getNewsById(rid);
                if (n != null) recent5.add(n);
            }
        }

        request.setAttribute("top5", top5);
        request.setAttribute("latest5", latest5);
        request.setAttribute("recent5", recent5);
        request.setAttribute("page", page);
        request.setAttribute("lNews", lNews);
        request.getRequestDispatcher("/views/layout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("newsletter");
        String message;
        if (email != null && !email.trim().isEmpty()) {
            email = email.trim();
            NewslettersDAO dao = new NewslettersDAO();
            Newsletters existing = dao.findById(email);

            if (existing == null) {
                dao.create(new Newsletters(email, true));
                message = "Đăng ký email thành công!";
            } else {
                message = "Email đã tồn tại trong danh sách!";
            }
        } else {
            message = "Vui lòng nhập email hợp lệ!";
        }

        request.setAttribute("message", message);
        doGet(request, response);
    }
}
