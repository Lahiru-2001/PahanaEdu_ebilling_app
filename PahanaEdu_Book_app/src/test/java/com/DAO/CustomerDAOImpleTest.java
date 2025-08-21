package com.DAO;

import com.DB.DBConnecter;
import com.entity.Customer;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.sql.PreparedStatement;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for CustomerDAOImple class.
 */
class CustomerDAOImpleTest {

    private static Connection con;
    // Shared database connection for all tests
    private static CustomerDAOImple customerDAO;
    // DAO instance under test

    @BeforeAll
    static void setupAll() throws Exception {
        // Runs once before all tests
        // Initialize database connection and DAO instance
        con = DBConnecter.getConnection();
        customerDAO = new CustomerDAOImple(con);
    }

    @BeforeEach
    void cleanupBefore() throws Exception {
        // Runs before each test
        // Clean up any test customer data to ensure test isolation
        try (PreparedStatement ps = con.prepareStatement(
                "DELETE FROM customers WHERE user_id = ? OR account_number = ?")) {
            ps.setInt(1, 999);
            ps.setString(2, "ACC999");
            ps.executeUpdate();
        }
    }

    @Test
    void testCreateAndGetCustomer() throws Exception {
        // Test creating a new customer and fetching it from the database
        Customer testCustomer = new Customer();
        testCustomer.setUser_Id(999);
        testCustomer.setAccount_Number("ACC999");
        testCustomer.setFirst_Name("lahiru");
        testCustomer.setLast_Name("kasun");
        testCustomer.setAddress("dankotuwa");
        testCustomer.setPhone_Number("0712345678");
        testCustomer.setStatus("ACTIVE");

        // Insert customer into the database
        boolean created = customerDAO.createCustomer(testCustomer);
        assertTrue(created, "Customer should be created successfully");

        // Verify the account number exists
        boolean exists = customerDAO.accountNumberExists("ACC999");
        assertTrue(exists, "Account number should exist after creation");

        // Fetch customer by user ID
        Customer fetched = customerDAO.getCustomerByUserId(999);
        assertNotNull(fetched, "Fetched customer should not be null");
        assertEquals("lahiru", fetched.getFirst_Name(), "First name should match");
        assertEquals("kasun", fetched.getLast_Name(), "Last name should match");
        assertEquals("ACC999", fetched.getAccount_Number(), "Account number should match");
        assertEquals("0712345678", fetched.getPhone_Number(), "Phone number should match");
        assertEquals("ACTIVE", fetched.getStatus(), "Status should match");
    }

    @Test
    void testAccountNumberDoesNotExist() throws Exception {
        // Test that a non-existent account number returns false
        boolean exists = customerDAO.accountNumberExists("NON_EXIST_ACC");
        assertFalse(exists, "Non-existent account should return false");
    }

    @Test
    void testGetCustomerByInvalidUserId() throws Exception {
        // Test fetching a customer with an invalid ID
        // Should return null
        Customer fetched = customerDAO.getCustomerByUserId(-1);
        assertNull(fetched, "Fetching with invalid user ID should return null");
    }

	/*
	 * @AfterEach void cleanupAfter() throws Exception { // Runs after each test //
	 * Remove test customer to prevent test data pollution try (PreparedStatement ps
	 * = con.prepareStatement(
	 * "DELETE FROM customers WHERE user_id = ? OR account_number = ?")) {
	 * ps.setInt(1, 999); ps.setString(2, "ACC999"); ps.executeUpdate(); } }
	 */

    @AfterAll
    static void tearDownAll() throws Exception {
        // Runs once after all tests
        // Close database connection
        if (con != null && !con.isClosed()) {
            con.close();
        }
    }
}
