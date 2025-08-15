package com.DAO;

import com.entity.CartItem;
import java.util.ArrayList;
import java.util.List;

/**
 * Implementation of the Cart interface using an in-memory ArrayList.
 */
public class CartImple implements Cart {
    
    // Internal list to store cart items
    private List<CartItem> items = new ArrayList<>();

    /**
     * Adds an item to the cart.
     * If the item already exists, increase its quantity and recalculate subtotal.
     */
    @Override
    public void addItem(CartItem item) {
        for (CartItem ci : items) {
            // If item with the same ID exists, update quantity and subtotal
            if (ci.getBill_item_id() == item.getBill_item_id()) {
                ci.setQuantity(ci.getQuantity() + item.getQuantity());
                ci.setSubtotal(ci.getPrice().multiply(new java.math.BigDecimal(ci.getQuantity())));
                return; // Exit after updating
            }
        }
        // If item doesn't exist, add it as new
        items.add(item);
    }

    /**
     * Removes an item from the cart by its ID.
     */
    @Override
    public void removeItem(int itemId) {
        items.removeIf(ci -> ci.getBill_item_id() == itemId);
    }

    /**
     * Returns a list of all items in the cart.
     */
    @Override
    public List<CartItem> getItems() {
        return items;
    }

    /**
     * Updates the quantity of a specific item in the cart
     * and recalculates its subtotal.
     */
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

    /**
     * Clears all items from the cart.
     */
    @Override
    public void clearCart() {
        items.clear();
    }
}
