package com.DAO;

import static org.junit.jupiter.api.Assertions.*;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.DB.DBConnecter;
import com.entity.User;
import com.util.PasswordUtil;

/**
 * Unit tests for UserDAOImple.
 */
class UserDAOImpleTest {

    private static Connection con;
    // Shared DB connection for all tests
    private static UserDAOImple userDAO;
    // DAO instance under test

    @BeforeAll
    static void setupDatabase() {
        // Runs once before all tests
        try {
            con = DBConnecter.getConnection();
            userDAO = new UserDAOImple(con);

            // Ensure users table exists
            Statement stmt = con.createStatement();
            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS users (" +
                    "user_id INT AUTO_INCREMENT PRIMARY KEY," +
                    "username VARCHAR(50) UNIQUE NOT NULL," +
                    "password_hash VARCHAR(255) NOT NULL," +
                    "role VARCHAR(20)," +
                    "status VARCHAR(20))");

            // Clean any test users before starting
            stmt.executeUpdate("DELETE FROM users WHERE username LIKE 'testuser%'");
            stmt.close();

        } catch (SQLException e) {
            fail("Database setup failed: " + e.getMessage());
        }
    }

    @BeforeEach
    void cleanBeforeEach() {
        // Runs before each test to ensure test isolation
        // Removes any test users that may have been left over from previous tests
        try (Statement stmt = con.createStatement()) {
            stmt.executeUpdate("DELETE FROM users WHERE username LIKE 'testuser%'");
        } catch (SQLException e) {
            fail("Failed to clean users: " + e.getMessage());
        }
    }

    @AfterAll
    static void closeConnection() {
        // Runs once after all tests
        // Close DB connection
        try {
            if (con != null && !con.isClosed()) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Test
    void testCreateUserAndUsernameExists() {
        // Test creating a user and checking if the username exists
        try {
            User user = new User();
            user.setUsername("testuser1");
            user.setPasswordHash(PasswordUtil.hashPassword("1234"));
            user.setRole("customer");
            user.setStatus("active");

            int id = userDAO.createUser(user);
            assertTrue(id > 0, "User ID should be generated and greater than 0");

            // Verify username exists in DB
            assertTrue(userDAO.usernameExists("testuser1"), "Username should exist after creation");
        } catch (Exception e) {
            fail("Exception occurred: " + e.getMessage());
        }
    }

    @Test
    void testLoginSuccessAndFailure() {
        // Test user login functionality
        try {
            User user = new User();
            user.setUsername("testuser2");
            user.setPasswordHash(PasswordUtil.hashPassword("mypassword")); 
            user.setRole("admin");
            user.setStatus("active");

            userDAO.createUser(user);

            // Successful login with correct credentials
            User loggedIn = userDAO.login("testuser2", "mypassword");
            assertNotNull(loggedIn, "Login should succeed with correct credentials");
            assertEquals("testuser2", loggedIn.getUsername(), "Logged in username should match");

            // Failed login with wrong password
            assertNull(userDAO.login("testuser2", "wrongpassword"), "Login should fail with wrong password");

            // Failed login with non-existent user
            assertNull(userDAO.login("nonexistuser", "any"), "Login should fail for non-existent user");
        } catch (Exception e) {
            fail("Exception occurred: " + e.getMessage());
        }
    }

    @Test
    void testGetUserByUsername() {
        // Test fetching a user by username
        try {
            User user = new User();
            user.setUsername("testuser1");
            user.setPasswordHash(PasswordUtil.hashPassword("1234"));
            user.setRole("customer");
            user.setStatus("active");

            userDAO.createUser(user);

            // Retrieve existing user
            User retrieved = userDAO.getUserByUsername("testuser1");
            assertNotNull(retrieved, "User should be retrieved successfully");
            assertEquals("testuser1", retrieved.getUsername());
            assertEquals("customer", retrieved.getRole());
            assertEquals("active", retrieved.getStatus());

            // Try retrieving non-existent user
            assertNull(userDAO.getUserByUsername("unknownuser"), "Fetching unknown user should return null");
        } catch (Exception e) {
            fail("Exception occurred: " + e.getMessage());
        }
    }
}
