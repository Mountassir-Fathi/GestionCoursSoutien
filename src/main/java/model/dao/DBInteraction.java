package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBInteraction {

	static Connection con;

	static int c = 0;

	public static void connect() {
		c++;
		if (c == 1) {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				String url = "jdbc:mysql://localhost:3306/centre_cours";
				con = DriverManager.getConnection(url, "root", "root");
				
			} catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

	public static void disconnect() {
		if (c == 1) {

			try {
				if (con != null) {
					con.setAutoCommit(true);
					con.close();
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		c--;

	}

	public static void closeStatement(ResultSet rSet) {
		try {
			rSet.getStatement().close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static int Maj(String sql) {
		int nb = 0;
		try {
			Statement st = con.createStatement();
			nb = st.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
			ResultSet rSet = st.getGeneratedKeys();
			if (rSet.next()) {
				nb = rSet.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			try {
				if(!con.getAutoCommit()) con.rollback();
				
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
		return nb;
	}

	public static ResultSet Select(String sql) {
		ResultSet rs = null;
		try {
			Statement st = con.createStatement();
			rs = st.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return rs;
	}

	public static void commit() {
		try {
			con.commit();
		} catch (SQLException e) {
			try {
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
	}

	public static void rollbak() {
		try {
			con.rollback();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void disableAutoCommit() {
		try {
			con.setAutoCommit(false);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
