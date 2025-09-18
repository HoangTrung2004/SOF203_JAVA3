package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

import Model.News;
import util.Jdbc;

public class NewsDAO {
    
    // Các câu lệnh SQL
    static String selectAllNews        = "SELECT * FROM News";
    static String selectAllNewsOnHome  = "SELECT * FROM News WHERE Home = 1";
    static String selectNewsByCategory = "SELECT * FROM News WHERE CategoryId = ?";
    static String selectNewsByAuthor   = "SELECT * FROM News WHERE Author = ?";
    static String selectNewsById       = "SELECT * FROM News WHERE Id = ?";
    static String selectTop5ViewCount  = "SELECT TOP 5 * FROM News ORDER BY ViewCount DESC";
    static String selectLatest5        = "SELECT TOP 5 * FROM News ORDER BY PostedDate DESC";
    static String updateViewCount      = "UPDATE News SET ViewCount = ViewCount + 1 WHERE Id = ?";
    
    static String insertNewsSql = 
          "INSERT INTO News (Id, Title, Content, Image, PostedDate, Author, ViewCount, CategoryId, Home) "
        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    static String updateNewsSql = 
          "UPDATE News SET Title=?, Content=?, Image=?, PostedDate=?, Author=?, ViewCount=?, CategoryId=?, Home=? "
        + "WHERE Id = ?";
    static String deleteNewsSql = "DELETE FROM News WHERE Id = ?";

    // 1. Lấy tất cả tin
    public static List<News> getAllNews() {
        List<News> list = new ArrayList<>();
        try (PreparedStatement pre = Jdbc.getConnection().prepareStatement(selectAllNews);
             ResultSet rs = pre.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Lấy danh sách tin hiển thị trên trang chủ
    public static List<News> getAllNewsOnHome() {
        List<News> list = new ArrayList<>();
        try (PreparedStatement pre = Jdbc.getConnection().prepareStatement(selectAllNewsOnHome);
             ResultSet rs = pre.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 3. Lấy bài viết theo chuyên mục
    public static List<News> getNewsByCategory(String categoryId) {
        List<News> list = new ArrayList<>();
        try (PreparedStatement pre = Jdbc.getConnection().prepareStatement(selectNewsByCategory)) {
            pre.setString(1, categoryId);
            try (ResultSet rs = pre.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 4. Lấy bài viết theo tác giả
    public static List<News> getNewsByAuthor(String author) {
        List<News> list = new ArrayList<>();
        try (PreparedStatement pre = Jdbc.getConnection().prepareStatement(selectNewsByAuthor)) {
            pre.setString(1, author);
            try (ResultSet rs = pre.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 5. Lấy bài viết theo Id
    public static News getNewsById(String id) {
        try (PreparedStatement pre = Jdbc.getConnection().prepareStatement(selectNewsById)) {
            pre.setString(1, id);
            try (ResultSet rs = pre.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 6. Tăng lượt xem
    public static void incrementViewCount(String id) {
        try (PreparedStatement pre = Jdbc.getConnection().prepareStatement(updateViewCount)) {
            pre.setString(1, id);
            pre.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 7. Lấy Top 5 tin xem nhiều nhất
    public static List<News> getTop5ViewCount() {
        List<News> list = new ArrayList<>();
        try (PreparedStatement pre = Jdbc.getConnection().prepareStatement(selectTop5ViewCount);
             ResultSet rs = pre.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 8. Lấy 5 tin mới nhất theo ngày đăng
    public static List<News> getLatest5() {
        List<News> list = new ArrayList<>();
        try (PreparedStatement pre = Jdbc.getConnection().prepareStatement(selectLatest5);
             ResultSet rs = pre.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 9. Thêm mới tin
//    public static void insertNews(News n) throws SQLException {
//        try (PreparedStatement stmt = Jdbc.getConnection().prepareStatement(insertNewsSql)) {
//            stmt.setString(1, n.getId());
//            stmt.setString(2, n.getTitle());
//            stmt.setString(3, n.getContent());
//            stmt.setString(4, n.getImage());
//            stmt.setDate(5, new java.sql.Date(n.getPostedDate().getTime()));
//            stmt.setString(6, n.getAuthor());
//            stmt.setInt(7, n.getViewCount());
//            stmt.setString(8, n.getCategoryId());
//            stmt.setBoolean(9, n.isHome());
//            stmt.executeUpdate();
//        }
//    }
    
    public static void insertNews(News n) {
        String sql = "INSERT INTO News (Id, Title, Content, Image, PostedDate, Author, ViewCount, CategoryId, Home) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = Jdbc.getConnection().prepareStatement(sql)) {
            stmt.setString(1, n.getId());
            stmt.setString(2, n.getTitle());
            stmt.setString(3, n.getContent());
            stmt.setString(4, n.getImage());
            stmt.setDate(5, new java.sql.Date(n.getPostedDate().getTime()));
            stmt.setString(6, n.getAuthor());
            stmt.setInt(7, n.getViewCount());
            stmt.setString(8, n.getCategoryId());
            stmt.setBoolean(9, n.isHome());

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                System.out.println("Insert thành công vào database.");
            } else {
                System.out.println("Không insert được tin.");
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi insertNews:");
            e.printStackTrace();
        }
    }


    // 10. Cập nhật tin
    public static void updateNews(News n) {
        try (PreparedStatement pre = Jdbc.getConnection().prepareStatement(updateNewsSql)) {
            pre.setString(1, n.getTitle());
            pre.setString(2, n.getContent());
            pre.setString(3, n.getImage());
            pre.setDate(4, new java.sql.Date(n.getPostedDate().getTime()));
            pre.setString(5, n.getAuthor());
            pre.setInt(6, n.getViewCount());
            pre.setString(7, n.getCategoryId());
            pre.setBoolean(8, n.isHome());
            pre.setString(9, n.getId());
            pre.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 11. Xóa tin
    public static void deleteNews(String id) {
        try (PreparedStatement pre = Jdbc.getConnection().prepareStatement(deleteNewsSql)) {
            pre.setString(1, id);
            pre.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Utility: map một ResultSet row thành một News object
    private static News mapRow(ResultSet rs) throws SQLException {
        return new News(
            rs.getString("Id"),
            rs.getString("Title"),
            rs.getString("Content"),
            rs.getString("Image"),
            rs.getDate("PostedDate"),
            rs.getString("Author"),
            rs.getInt("ViewCount"),
            rs.getString("CategoryId"),
            rs.getBoolean("Home")
        );
    }
}
