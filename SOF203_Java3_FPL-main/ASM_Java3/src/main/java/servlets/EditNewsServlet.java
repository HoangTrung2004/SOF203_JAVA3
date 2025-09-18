package servlets;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import DAO.NewsDAO;
import Model.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/admin/editnews")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1MB
    maxFileSize = 5 * 1024 * 1024,        // 5MB
    maxRequestSize = 10 * 1024 * 1024     // 10MB
)
public class EditNewsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Hiển thị form (GET)
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String id = req.getParameter("id");
        News n = NewsDAO.getNewsById(id);
        req.setAttribute("n", n);
        req.getRequestDispatcher("/pages/editnews.jsp").forward(req, resp);
    }

    // Xử lý submit (POST)
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        News n = new News();
        n.setId(req.getParameter("id"));
        n.setTitle(req.getParameter("title"));
        n.setContent(req.getParameter("content"));

        // --- xử lý file ảnh ---
        Part part = req.getPart("image");
        if (part != null && part.getSize() > 0) {
            String fileName = extractFileName(part);
            n.setImage(fileName);
            saveFile(part, req.getServletContext().getRealPath("/img"));
        } else {
            // nếu không chọn file mới, giữ lại ảnh cũ
            n.setImage(req.getParameter("existingImage"));
        }

        // Ngày đăng
        try {
            Date d = new SimpleDateFormat("yyyy-MM-dd")
                          .parse(req.getParameter("postedDate"));
            n.setPostedDate(d);
        } catch (Exception e) {
            // nếu parse lỗi, có thể để nguyên hoặc log
        }

        // Lượt xem (xử lý an toàn)
        String vc = req.getParameter("viewCount");
        int viewCount = 0;
        if (vc != null && !vc.isEmpty()) {
            try {
                viewCount = Integer.parseInt(vc);
            } catch (NumberFormatException e) {
                // log nếu muốn
            }
        }
        n.setViewCount(viewCount);

        n.setAuthor(req.getParameter("author"));
        n.setCategoryId(req.getParameter("categoryId"));
        n.setHome(req.getParameter("home") != null);

        NewsDAO.updateNews(n);
        resp.sendRedirect(req.getContextPath() + "/admin/tintuc");
    }

    private String extractFileName(Part part) {
        String cd = part.getHeader("content-disposition");
        for (String token : cd.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1)
                            .trim().replace("\"", "");
            }
        }
        return "";
    }

    private void saveFile(Part part, String uploadDir) throws IOException {
        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();
        part.write(uploadDir + File.separator + extractFileName(part));
    }
}
