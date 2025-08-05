package com.entity;

public class User {

	private int user_id;
	private String username;
	private String passwordHash;
	private String role; // "admin" or "customer"
	private String status; // e.g., "Active"

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPasswordHash() {
		return passwordHash;
	}

	public void setPasswordHash(String passwordHash) {
		this.passwordHash = passwordHash;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "User [user_id=" + user_id + ", username=" + username + ", passwordHash=" + passwordHash + ", role="
				+ role + ", status=" + status + "]";
	}
}
