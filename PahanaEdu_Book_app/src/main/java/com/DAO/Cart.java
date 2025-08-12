package com.DAO;

import com.entity.CartItem;
import java.util.List;

public interface Cart {
	void addItem(CartItem item);

	void removeItem(int itemId);

	List<CartItem> getItems();

	void updateQuantity(int itemId, int quantity);

	void clearCart();
}
