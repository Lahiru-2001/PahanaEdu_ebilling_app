package com.DAO;

import com.entity.User;

/**
 * Data Access Object (DAO) interface for User entity. Defines the database
 * operations related to users.
 */
public interface UserDAO {

	/**
	 * Checks if a username already exists in the database.
	 * 
	 */
	boolean usernameExists(String username) throws Exception;

	/**
	 * Creates a new user in the database..
	 */
	int createUser(User user) throws Exception;

	/**
	 * Attempts to log in a user with the provided credentials.
	 * 
	 */
	User login(String username, String plainPassword);

	/**
	 * Retrieves a user by their username.
	 * 
	 */
	User getUserByUsername(String username) throws Exception;
}
