package com.DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnecter {

	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("JDBC Driver load failed", e);
		}
	}

	private DBConnecter() {
		// no instantiation
	}

	public static Connection getConnection() throws SQLException {
		String url = "jdbc:mysql://localhost:3306/PahanaEdu_ebilling?serverTimezone=UTC&useSSL=false";
		return DriverManager.getConnection(url, "root", "root"); // adjust user/password as needed
	}
}
