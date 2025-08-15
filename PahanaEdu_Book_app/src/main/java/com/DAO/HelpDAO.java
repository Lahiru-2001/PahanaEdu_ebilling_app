package com.DAO;

import com.entity.Help;

/**
 * 
 * Defines the database operations related to help messages.
 */
public interface HelpDAO {

	/**
	 * Adds a new help message to the database.
	 * 
	 */
	boolean addHelp(Help help);
}
