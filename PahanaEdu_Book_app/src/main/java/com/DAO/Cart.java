package com.DAO;

import com.entity.CartItem;
import java.util.List;

public interface Cart {

	/*
	 * Adds an item to the cart. If the item already exists, its quantity should be
	 * updated.
	 */

	void addItem(CartItem item);

	/**
	 * Removes an item from the cart by its ID.
	 */

	void removeItem(int itemId);

	/**
	 * Retrieves all items currently in the cart.
	 */

	List<CartItem> getItems();

	/**
	 * Updates the quantity of a specific item in the cart.
	 */

	void updateQuantity(int itemId, int quantity);

	/**
	 * Clears all items from the cart.
	 */
	void clearCart();
}
