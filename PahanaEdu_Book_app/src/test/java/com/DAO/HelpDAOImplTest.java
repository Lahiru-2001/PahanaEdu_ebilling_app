package com.DAO;

import com.DB.DBConnecter;
import com.entity.Help;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for HelpDAOImpl.
 * 
 */
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class HelpDAOImplTest {

	private static Connection conn;
	// Shared database connection for all tests
	private static HelpDAOImpl helpDAO;
	// DAO instance under test

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		// Runs once before all tests
		// Initialize database connection and DAO instance
		conn = DBConnecter.getConnection();
		helpDAO = new HelpDAOImpl(conn);
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		// Runs once after all tests
		// Close database connection if open
		if (conn != null && !conn.isClosed()) {
			conn.close();
		}
	}

	@Test
	@Order(1)
	void testAddHelp_Success() throws Exception {
		// Test adding a valid Help record
		Help help = new Help();
		help.setCustomer_id(2);
		help.setTitle("Test Help");
		help.setContent("This is a test help message.");

		// Add help record using DAO
		boolean result = helpDAO.addHelp(help);
		assertTrue(result, "Help should be inserted successfully");

		// Verify the record exists in the database
		String sql = "SELECT * FROM help WHERE title = ? AND content = ?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, help.getTitle());
			ps.setString(2, help.getContent());
			try (ResultSet rs = ps.executeQuery()) {
				assertTrue(rs.next(), "Inserted help record should be found in DB");
			}
		}

		// Clean up test record after verification to avoid polluting DB
		try (PreparedStatement ps = conn.prepareStatement("DELETE FROM help WHERE title = ? AND content = ?")) {
			ps.setString(1, help.getTitle());
			ps.setString(2, help.getContent());
			ps.executeUpdate();
		}
	}

	@Test
	@Order(2)
	void testAddHelp_Failure_InvalidCustomer() {
		// Test adding a Help record with an invalid customer_id
		// This should fail and return false
		Help help = new Help();
		help.setCustomer_id(-999); // Invalid customer_id
		help.setTitle("Invalid Test Help");
		help.setContent("This should not be inserted.");

		boolean result = helpDAO.addHelp(help);
		assertFalse(result, "Help insert should fail for invalid customer_id");
	}
}
