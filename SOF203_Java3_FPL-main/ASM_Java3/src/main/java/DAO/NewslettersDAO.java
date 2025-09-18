package DAO;

import Model.Newsletters;
import util.Jdbc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NewslettersDAO {

    // Lấy toàn bộ danh sách
    public List<Newsletters> findAll() {
        List<Newsletters> list = new ArrayList<>();
        String sql = "SELECT email, enabled FROM newsletters";
        try (ResultSet rs = Jdbc.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new Newsletters(
                        rs.getString("email"),
                        rs.getBoolean("enabled")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Tìm theo email
    public Newsletters findById(String email) {
        String sql = "SELECT email, enabled FROM newsletters WHERE email = ?";
        try (ResultSet rs = Jdbc.executeQuery(sql, email)) {
            if (rs.next()) {
                return new Newsletters(
                        rs.getString("email"),
                        rs.getBoolean("enabled")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Tạo mới
    public void create(Newsletters n) {
        String sql = "INSERT INTO newsletters (email, enabled) VALUES (?, ?)";
        try {
            Jdbc.executeUpdate(sql, n.getEmail(), n.isEnabled());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Cập nhật trạng thái
    public void update(Newsletters n) {
        String sql = "UPDATE newsletters SET enabled = ? WHERE email = ?";
        try {
            Jdbc.executeUpdate(sql, n.isEnabled(), n.getEmail());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Xóa theo email
    public void deleteById(String email) {
        String sql = "DELETE FROM newsletters WHERE email = ?";
        try {
            Jdbc.executeUpdate(sql, email);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ✅ Kiểm tra email có tồn tại hay không
    public boolean exists(String email) {
        String sql = "SELECT 1 FROM newsletters WHERE email = ?";
        try (ResultSet rs = Jdbc.executeQuery(sql, email)) {
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Nếu có thì cập nhật, nếu chưa có thì thêm mới
    public void insertOrUpdate(Newsletters n) {
        if (exists(n.getEmail())) {
            update(n);
        } else {
            create(n);
        }
    }
}
