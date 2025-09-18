package servlets;

import DAO.UserDAO;
import Model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")  // QUAN TRỌNG: dùng đúng với form action
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username"); // email
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");

        if (userDAO.checkLogin(username, password)) {
            Users user = userDAO.findById(username);
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Ghi nhớ mật khẩu
            Cookie cUser = new Cookie("username", username);
            Cookie cPass = new Cookie("password", password);
            Cookie cRemember = new Cookie("remember", remember != null ? "on" : "");

            int age = (remember != null) ? 7 * 24 * 60 * 60 : 0;
            cUser.setMaxAge(age);
            cPass.setMaxAge(age);
            cRemember.setMaxAge(age);

            response.addCookie(cUser);
            response.addCookie(cPass);
            response.addCookie(cRemember);

            // Chuyển hướng theo vai trò
            if (user.isRole()) {
                response.sendRedirect(request.getContextPath() + "/admin/tintuc");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/loaitin");
            }
        } else {
            request.setAttribute("error", "Sai tài khoản hoặc mật khẩu!");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }
}
