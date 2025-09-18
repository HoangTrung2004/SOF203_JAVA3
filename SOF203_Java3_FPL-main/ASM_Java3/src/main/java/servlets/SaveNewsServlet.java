package servlets;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import DAO.NewsDAO;
import Model.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/admin/saveloaitin")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 5 * 1024 * 1024,
    maxRequestSize = 10 * 1024 * 1024
)
public class SaveNewsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            News n = new News();
            n.setId(UUID.randomUUID().toString());
            n.setTitle(request.getParameter("title"));
            n.setContent(request.getParameter("content"));

            // Upload ảnh
            Part part = request.getPart("image");
            if (part != null && part.getSize() > 0) {
                String fileName = extractFileName(part);
                String uploadDir = request.getServletContext().getRealPath("/img");
                System.out.println("Upload path: " + uploadDir);
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();
                part.write(uploadDir + File.separator + fileName);
                n.setImage(fileName);
            }

            // Ngày đăng
            String postedDate = request.getParameter("postedDate");
            Date d = new SimpleDateFormat("yyyy-MM-dd").parse(postedDate);
            n.setPostedDate(d);

            // Tác giả
            n.setAuthor(request.getParameter("author"));

            // View count
            String vc = request.getParameter("viewCount");
            int viewCount = 0;
            if (vc != null && !vc.isEmpty()) {
                try {
                    viewCount = Integer.parseInt(vc);
                } catch (NumberFormatException e) {
                    System.err.println("Lỗi parse viewCount: " + e.getMessage());
                }
            }
            n.setViewCount(viewCount);

            n.setCategoryId(request.getParameter("categoryId"));
            n.setHome(request.getParameter("home") != null);

            // Debug object
            System.out.println("News obj: " + n);

            NewsDAO.insertNews(n);
            response.sendRedirect(request.getContextPath() + "/admin/tintuc");

        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/tintuc?error=true");
        }
    }

    private String extractFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}

