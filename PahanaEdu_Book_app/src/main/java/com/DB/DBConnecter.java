package com.DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnecter {

	// Static block to load the MySQL JDBC driver when the class is first loaded
	static {
		try {
			// Dynamically load MySQL JDBC driver
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// If driver is not found, throw a runtime exception
			throw new RuntimeException("JDBC Driver load failed", e);
		}
	}

	// Private constructor to prevent object creation (Utility class pattern)
	private DBConnecter() {
	}

	/**
	 * This method returns a database connection to the MySQL database.
	 */
	public static Connection getConnection() throws SQLException {
		// Database URL: points to the 'PahanaEdu_ebilling' schema on localhost

		String url = "jdbc:mysql://localhost:3306/PahanaEdu_ebilling?serverTimezone=UTC&useSSL=false";

		// Connect to database using username 'root' and password 'root'
		return DriverManager.getConnection(url, "root", "root");
	}
}
