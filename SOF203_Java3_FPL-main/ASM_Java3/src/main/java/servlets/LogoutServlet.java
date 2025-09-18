package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Hủy session
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Xóa cookie nếu có
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("username".equals(c.getName()) || "password".equals(c.getName()) || "remember".equals(c.getName())) {
                    c.setMaxAge(0);
                    c.setPath("/"); // bắt buộc để xóa đúng
                    response.addCookie(c);
                }
            }
        }

        // Quay về trang chủ
        response.sendRedirect(request.getContextPath() + "/news/trangchu");
    }
}
