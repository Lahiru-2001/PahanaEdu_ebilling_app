package com.DAO;

import com.entity.CartItem;
import java.util.ArrayList;
import java.util.List;

public class CartImple implements Cart {
	private List<CartItem> items = new ArrayList<>();

	@Override
	public void addItem(CartItem item) {
		// If item exists, update qty
		for (CartItem ci : items) {
			if (ci.getBill_item_id() == item.getBill_item_id()) {
				ci.setQuantity(ci.getQuantity() + item.getQuantity());
				ci.setSubtotal(ci.getPrice().multiply(new java.math.BigDecimal(ci.getQuantity())));
				return;
			}
		}
		items.add(item);
	}

	@Override
	public void removeItem(int itemId) {
		items.removeIf(ci -> ci.getBill_item_id() == itemId);
	}

	@Override
	public List<CartItem> getItems() {
		return items;
	}

	@Override
	public void updateQuantity(int itemId, int quantity) {
		for (CartItem ci : items) {
			if (ci.getBill_item_id() == itemId) {
				ci.setQuantity(quantity);
				ci.setSubtotal(ci.getPrice().multiply(new java.math.BigDecimal(quantity)));
				break;
			}
		}
	}

	@Override
	public void clearCart() {
		items.clear();
	}
}
