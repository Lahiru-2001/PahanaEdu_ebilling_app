package com.DAO;

import com.entity.CartItem;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for the CartImple class. 
 */
class CartImpleTest {

	private CartImple cart;
	// The CartImple instance under test. Initialized before each test to ensure
	// isolation.

	@BeforeEach
	void setUp() {
		cart = new CartImple();
		// Initialize a fresh cart before each test to avoid interference between tests.
	}

	/**
	 * Helper method to quickly create CartItem objects.
	 * 
	 */
	private CartItem createCartItem(int id, int qty, String name, BigDecimal price) {
		CartItem item = new CartItem();
		item.setBill_item_id(id);
		item.setQuantity(qty);
		item.setName(name);
		item.setPrice(price);
		item.setSubtotal(price.multiply(new BigDecimal(qty)));
		return item;
	}

	@Test
	void testAddNewItem() {
		// Test adding a new item to the cart.
		CartItem item = createCartItem(1, 2, "Book A", new BigDecimal("100.00"));
		cart.addItem(item);

		List<CartItem> items = cart.getItems();
		assertEquals(1, items.size(), "Cart should contain 1 item");
		assertEquals(new BigDecimal("200.00"), items.get(0).getSubtotal(), "Subtotal should be price * quantity");
	}

	@Test
	void testAddExistingItemUpdatesQuantity() {
		// Test adding an item that already exists in the cart.
		// Quantity should be updated, not a new item added.
		CartItem item1 = createCartItem(1, 2, "Book A", new BigDecimal("100.00"));
		CartItem item2 = createCartItem(1, 3, "Book A", new BigDecimal("100.00")); // same ID

		cart.addItem(item1);
		cart.addItem(item2);

		List<CartItem> items = cart.getItems();
		assertEquals(1, items.size(), "Cart should still have only 1 item");
		assertEquals(5, items.get(0).getQuantity(), "Quantity should be updated to 5");
		assertEquals(new BigDecimal("500.00"), items.get(0).getSubtotal(), "Subtotal should update correctly");
	}

	@Test
	void testRemoveItem() {
		// Test removing an item from the cart by its ID.
		CartItem item = createCartItem(1, 2, "Book A", new BigDecimal("100.00"));
		cart.addItem(item);

		cart.removeItem(1);

		assertTrue(cart.getItems().isEmpty(), "Cart should be empty after removal");
	}

	@Test
	void testUpdateQuantity() {
		// Test updating the quantity of an existing item.
		// Subtotal should also update accordingly.
		CartItem item = createCartItem(1, 2, "Book A", new BigDecimal("100.00"));
		cart.addItem(item);

		cart.updateQuantity(1, 5);

		CartItem updated = cart.getItems().get(0);
		assertEquals(5, updated.getQuantity(), "Quantity should update to 5");
		assertEquals(new BigDecimal("500.00"), updated.getSubtotal(), "Subtotal should be updated correctly");
	}

	@Test
	void testClearCart() {
		// Test clearing all items from the cart.
		cart.addItem(createCartItem(1, 2, "Book A", new BigDecimal("100.00")));
		cart.addItem(createCartItem(2, 1, "Book B", new BigDecimal("50.00")));

		cart.clearCart();

		assertTrue(cart.getItems().isEmpty(), "Cart should be empty after clearing");
	}

	@Test
	void testRemoveNonExistentItem() {
		// Test removing an item that doesn't exist (should do nothing or handle
		// gracefully)
		cart.removeItem(999);
		assertTrue(cart.getItems().isEmpty(), "Cart should remain empty");
	}



}
