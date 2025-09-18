package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Model.Users;
import util.Jdbc;

public class UserDAO {

    // 1. Lấy danh sách tất cả người dùng (giữ nguyên)
    public static List<Users> getAllUsers() {
        List<Users> list = new ArrayList<>();
        String sql = "SELECT Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role FROM Users";
        try (PreparedStatement pre = Jdbc.getConnection().prepareStatement(sql);
             ResultSet rs = pre.executeQuery()) {
            while (rs.next()) {
                Users u = new Users(
                    rs.getString("Id"),
                    rs.getString("Password"),
                    rs.getString("Fullname"),
                    rs.getDate("Birthday"),
                    rs.getBoolean("Gender"),
                    rs.getString("Mobile"),
                    rs.getString("Email"),
                    rs.getBoolean("Role")
                );
                list.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Kiểm tra đăng nhập bằng Id (hoặc email, nếu muốn)
    public boolean checkLogin(String input, String password) {
        String sql = "SELECT * FROM Users WHERE Id = ? AND Password = ?";
        try (PreparedStatement pre = Jdbc.getConnection().prepareStatement(sql)) {
            pre.setString(1, input);
            pre.setString(2, password);
            try (ResultSet rs = pre.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 3. Tìm người dùng theo Id (không dùng email)
    public Users findById(String id) {
        String sql = "SELECT Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role "
                   + "FROM Users WHERE Id = ?";
        try (PreparedStatement pre = Jdbc.getConnection().prepareStatement(sql)) {
            pre.setString(1, id);
            try (ResultSet rs = pre.executeQuery()) {
                if (rs.next()) {
                    return new Users(
                        rs.getString("Id"),
                        rs.getString("Password"),
                        rs.getString("Fullname"),
                        rs.getDate("Birthday"),
                        rs.getBoolean("Gender"),
                        rs.getString("Mobile"),
                        rs.getString("Email"),
                        rs.getBoolean("Role")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Bạn có thể xóa hoặc để nguyên phương thức này nếu không dùng nữa
    public Users findByUsernameOrEmail(String input) {
        // giữ nguyên nếu cần lookup theo email, hoặc bỏ hẳn
        return null;
    }
}
