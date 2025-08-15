package com.DAO;

import com.entity.Item;
import java.util.List;

/**
 * Data Access Object (DAO) interface for the Item entity. Defines the methods
 * required for interacting with the items table in the database.
 */
public interface ItemDAO {

	/**
	 * Adds a new item to the database.
	 * 
	 */
	boolean addItem(Item item) throws Exception;

	/**
	 * Checks whether an item with the given name already exists.
	 * 
	 */
	boolean isItemNameExists(String name) throws Exception;

	/**
	 * Retrieves all items from the database.
	 * 
	 */
	List<Item> getAllItems() throws Exception;

	/**
	 * Retrieves an item from the database by its ID.
	 * 
	 */
	Item getItemById(int item_id) throws Exception;

	/**
	 * Deletes an item from the database by its ID.
	 * 
	 */
	boolean deleteItemById(int item_id) throws Exception;

	/**
	 * Updates the details of an existing item in the database.
	 * 
	 */
	boolean updateItem(Item item) throws Exception;
}
