package util;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class Jdbc {
	static String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	static String dburl = "jdbc:sqlserver://localhost;databaseName=NewDB_Java3;encrypt=false;";
	static String username = "sa";
	static String password = "songlong";
	
	static {
		try { // nạp driver
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			//throw new RuntimeException(e);
			System.out.println(e.getMessage());
		}
	}
	/**Mở kết nối*/
	public static Connection getConnection() throws SQLException {
		return DriverManager.getConnection(dburl, username, password);
	}
	/**Thao tác dữ liệu*/
	public static int executeUpdate(String sql, Object... values) throws SQLException {
		Connection connection = getConnection();
		PreparedStatement statement = connection.prepareStatement(sql);
		for (int i = 0; i < values.length; i++) {
			statement.setObject(i + 1, values[i]);
		}
		return statement.executeUpdate();
	}
	/**Truy vấn dữ liệu*/
	public static ResultSet executeQuery(String sql, Object...values) throws SQLException {
		Connection connection = getConnection();
		PreparedStatement statement = connection.prepareStatement(sql);
		for (int i = 0; i < values.length; i++) {
			statement.setObject(i + 1, values[i]);
		}
		return statement.executeQuery();
	}
	
	public static void main(String[] args) {
		try {
			Connection connection = Jdbc.getConnection();
			System.out.println("connect !");
			
//			String sql ;
//			
//			sql = "update news set viewcount = viewcount + 1 where id = ?";
//			int k =  Jdbc.executeUpdate(sql, "n014");
//			if (k>0) System.out.println("updated !");
//			
//			sql = "select * from news where home=1";
//			ResultSet rs = Jdbc.executeQuery(sql, args);
//			while (rs.next())
//				System.out.println(rs.getString("id") + " - " + rs.getString("title") + " - " + rs.getInt("viewcount"));
//			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}

