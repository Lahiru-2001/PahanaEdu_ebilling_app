package com.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {
	// Hash a plain password
	public static String hashPassword(String plain) {

		return BCrypt.hashpw(plain, BCrypt.gensalt(12)); // cost 12
	}

	// verify
	public static boolean checkPassword(String plain, String hashed) {
		if (hashed == null || !hashed.startsWith("$2a$")) {
			return false;
		}
		return BCrypt.checkpw(plain, hashed);
	}
}
