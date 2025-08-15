package com.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

	/**
	 * Hashes a plain-text password using BCrypt with a work factor of 12.
	 */
	public static String hashPassword(String plain) {
		// gensalt(12)
		return BCrypt.hashpw(plain, BCrypt.gensalt(12));
	}

	/**
	 * Checks if a plain-text password matches the stored hashed password.
	 * 
	 */
	public static boolean checkPassword(String plain, String hashed) {
		// If hashed password is null or not in BCrypt format, reject immediately
		if (hashed == null || !hashed.startsWith("$2a$")) {
			return false;
		}
		// Verify the password using BCrypt's built-in check function
		return BCrypt.checkpw(plain, hashed);
	}
}
