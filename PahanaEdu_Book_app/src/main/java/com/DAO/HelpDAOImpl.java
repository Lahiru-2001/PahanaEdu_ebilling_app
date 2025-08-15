package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.entity.Help;

/**
 * Implementation of the HelpDAO interface. Handles database operations for the
 * help messages table.
 */
public class HelpDAOImpl implements HelpDAO {

	// Database connection instance
	private Connection conn;

	/**
	 * Constructor to initialize DAO with a database connection.
	 */
	public HelpDAOImpl(Connection conn) {
		this.conn = conn;
	}

	/**
	 * Inserts a new help record into the database.
	 */
	@Override
	public boolean addHelp(Help help) {
		boolean f = false; // Flag to indicate success/failure
		try {
			// SQL query for inserting help data
			String sql = "INSERT INTO help (customer_id, title, content) VALUES (?, ?, ?)";
			PreparedStatement ps = conn.prepareStatement(sql);

			// Set the values from the Help object
			ps.setInt(1, help.getCustomer_id());
			ps.setString(2, help.getTitle());
			ps.setString(3, help.getContent());

			// Execute update and check if exactly 1 row was affected
			int i = ps.executeUpdate();
			if (i == 1) {
				f = true; // Insertion successful
			}

		} catch (Exception e) {
			e.printStackTrace(); // Print any exceptions to the console (could be logged in production)
		}
		return f;
	}
}
