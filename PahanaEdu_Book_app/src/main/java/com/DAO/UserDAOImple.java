package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import com.entity.User;
import com.util.PasswordUtil;

/**
 * Implementation of the UserDAO interface. Provides CRUD and authentication
 * operations for the users table.
 */
public class UserDAOImple implements UserDAO {

	// Database connection
	private final Connection con;

	/**
	 * Constructor to initialize the DAO with a database connection.
	 * 
	 */
	public UserDAOImple(Connection con) {
		this.con = con;
	}

	/**
	 * Checks whether a username already exists in the database.
	 */
	@Override
	public boolean usernameExists(String username) throws Exception {
		String sql = "SELECT user_id FROM users WHERE username = ?";
		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, username);
			try (ResultSet rs = ps.executeQuery()) {
				return rs.next(); // true if username exists
			}
		}
	}

	/**
	 * Creates a new user and returns the generated user_id.
	 */
	@Override
	public int createUser(User user) throws Exception {
		String sql = "INSERT INTO users(username, password_hash, role, status) VALUES (?,?,?,?)";
		try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPasswordHash()); // already hashed password
			ps.setString(3, user.getRole());
			ps.setString(4, user.getStatus());

			int affected = ps.executeUpdate();
			if (affected == 0) {
				throw new Exception("Creating user failed.");
			}

			try (ResultSet rs = ps.getGeneratedKeys()) {
				if (rs.next()) {
					return rs.getInt(1); // Return generated user_id
				} else {
					throw new Exception("Creating user failed.");
				}
			}
		}
	}

	/**
	 * Attempts to log in a user by verifying the plaintext password against the
	 * stored hashed password.
	 */
	@Override
	public User login(String username, String plainPassword) {
		String sql = "SELECT user_id, username, password_hash, role, status FROM users WHERE username = ?";
		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, username);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					String storedHash = rs.getString("password_hash");
					// Verify password using PasswordUtil
					if (PasswordUtil.checkPassword(plainPassword, storedHash)) {
						User user = new User();
						user.setUser_id(rs.getInt("user_id"));
						user.setUsername(rs.getString("username"));
						user.setPasswordHash(storedHash);
						user.setRole(rs.getString("role"));
						user.setStatus(rs.getString("status"));
						return user; // login successful
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // login failed
	}

	/**
	 * Retrieves a user object based on the username.
	 */
	@Override
	public User getUserByUsername(String username) throws Exception {
		String sql = "SELECT user_id, username, password_hash, role, status FROM users WHERE username = ?";
		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, username);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					User user = new User();
					user.setUser_id(rs.getInt("user_id"));
					user.setUsername(rs.getString("username"));
					user.setPasswordHash(rs.getString("password_hash"));
					user.setRole(rs.getString("role"));
					user.setStatus(rs.getString("status"));
					return user;
				}
			}
		}
		return null; // user not found
	}
}
