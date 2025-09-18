package DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Model.Category;
import util.Jdbc;

public class CategoryDAO {

    public static List<Category> getAll() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM Categories";
        try (PreparedStatement ps = Jdbc.getConnection().prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Category c = new Category();
                c.setId(rs.getString("Id"));
                c.setName(rs.getString("Name"));
                list.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
