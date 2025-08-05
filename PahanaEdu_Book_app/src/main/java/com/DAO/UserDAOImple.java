package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import com.entity.User;
import com.util.PasswordUtil;

public class UserDAOImple implements UserDAO {

	private final Connection con;

	public UserDAOImple(Connection con) {
		this.con = con;
	}

	@Override
	public boolean usernameExists(String username) throws Exception {
		String sql = "SELECT user_id FROM users WHERE username = ?";
		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, username);
			try (ResultSet rs = ps.executeQuery()) {
				return rs.next();
			}
		}
	}

	@Override
	public int createUser(User user) throws Exception {
		String sql = "INSERT INTO users(username, password_hash, role, status) VALUES (?,?,?,?)";
		try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPasswordHash());
			ps.setString(3, user.getRole());
			ps.setString(4, user.getStatus());
			int affected = ps.executeUpdate();
			if (affected == 0) {
				throw new Exception("Creating user failed, no rows affected.");
			}
			try (ResultSet rs = ps.getGeneratedKeys()) {
				if (rs.next()) {
					return rs.getInt(1);
				} else {
					throw new Exception("Creating user failed, no ID obtained.");
				}
			}
		}
	}

	@Override
	public User login(String username, String plainPassword) {
		String sql = "SELECT user_id, username, password_hash, role, status FROM users WHERE username = ?";
		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, username);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					String storedHash = rs.getString("password_hash");
					if (PasswordUtil.checkPassword(plainPassword, storedHash)) {
						User user = new User();
						user.setUser_id(rs.getInt("user_id"));
						user.setUsername(rs.getString("username"));
						user.setPasswordHash(storedHash);
						user.setRole(rs.getString("role"));
						user.setStatus(rs.getString("status"));
						return user;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // login failed
	}

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
		return null;
	}
}
