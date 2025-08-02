package com.DB;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnecter {
	private static Connection con;

	public static Connection getcon() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");

			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/PahanaEdu_ebilling", "root", "root");
		} catch (Exception e) {
			System.out.println("DB Connection Error: " + e.getMessage());
			e.printStackTrace();
		}
		return con;
	}
}
