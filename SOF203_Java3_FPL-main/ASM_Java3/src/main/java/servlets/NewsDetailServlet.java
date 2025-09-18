package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;
import DAO.NewsDAO;
import Model.News;

@WebServlet("/newsDetail")
public class NewsDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id == null) {
            // nếu không có id, quay về trang chủ
            resp.sendRedirect(req.getContextPath() + "/news/trangchu");
            return;
        }

        // 1. Tăng lượt xem
        NewsDAO.incrementViewCount(id);

        // 2. Lấy chi tiết và 2 list cơ bản
        News detail    = NewsDAO.getNewsById(id);
        List<News> top5    = NewsDAO.getTop5ViewCount();  // ORDER BY ViewCount DESC
        List<News> latest5 = NewsDAO.getLatest5();       // ORDER BY PostedDate DESC

        // 3. Quản lý “5 tin vừa xem” trong session
        HttpSession session = req.getSession();
        @SuppressWarnings("unchecked")
        LinkedList<String> recentIds = (LinkedList<String>) session.getAttribute("recentView");
        if (recentIds == null) {
            recentIds = new LinkedList<>();
        }
        recentIds.remove(id);
        recentIds.addFirst(id);
        if (recentIds.size() > 5) {
            recentIds.removeLast();
        }
        session.setAttribute("recentView", recentIds);
        List<News> recent5 = recentIds.stream()
                                      .map(NewsDAO::getNewsById)
                                      .filter(Objects::nonNull)
                                      .collect(Collectors.toList());

        // 4. Đẩy lên JSP
        req.setAttribute("detail",  detail);
        req.setAttribute("top5",    top5);
        req.setAttribute("latest5", latest5);
        req.setAttribute("recent5", recent5);

        req.getRequestDispatcher("/pages/detail.jsp")
           .forward(req, resp);
    }
}
