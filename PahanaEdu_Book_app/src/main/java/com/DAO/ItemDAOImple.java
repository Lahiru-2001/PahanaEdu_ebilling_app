package com.DAO;

import com.entity.Item;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Implementation of the ItemDAO interface.
 * Provides database CRUD operations for items.
 */
public class ItemDAOImple implements ItemDAO {

    // Database connection object
    private final Connection conn;

    /**
     * Constructor to initialize the DAO with an active database connection.
     */
    public ItemDAOImple(Connection conn) {
        this.conn = conn;
    }

    /**
     * Adds a new item to the database.
     */
    @Override
    public boolean addItem(Item item) throws Exception {
        String sql = "INSERT INTO items (name, description, category, image, price, stock_quantity, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, item.getName());
            ps.setString(2, item.getDescription());
            ps.setString(3, item.getCategory());
            ps.setString(4, item.getImage());
            ps.setBigDecimal(5, item.getPrice());
            ps.setInt(6, item.getStock_quantity());
            ps.setString(7, item.getStatus());
            return ps.executeUpdate() == 1; // true if one row inserted
        }
    }

    /**
     * Checks whether an item with the given name exists.
     */
    @Override
    public boolean isItemNameExists(String name) throws Exception {
        String sql = "SELECT name FROM items WHERE name = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // true if record found
        }
    }

    /**
     * Retrieves all items from the database.
     */
    @Override
    public List<Item> getAllItems() throws Exception {
        List<Item> itemList = new ArrayList<>();
        String sql = "SELECT * FROM items";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // Map each row to an Item object
                Item item = new Item();
                item.setItem_id(rs.getInt("item_id"));
                item.setName(rs.getString("name"));
                item.setDescription(rs.getString("description"));
                item.setCategory(rs.getString("category"));
                item.setImage(rs.getString("image"));
                item.setPrice(rs.getBigDecimal("price"));
                item.setStock_quantity(rs.getInt("stock_quantity"));
                item.setStatus(rs.getString("status"));
                itemList.add(item);
            }
        }
        return itemList;
    }

    /**
     * Retrieves an item by its ID.
     */
    @Override
    public Item getItemById(int item_id) throws Exception {
        String sql = "SELECT * FROM items WHERE item_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, item_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Map result set to Item object
                Item item = new Item();
                item.setItem_id(rs.getInt("item_id"));
                item.setName(rs.getString("name"));
                item.setDescription(rs.getString("description"));
                item.setCategory(rs.getString("category"));
                item.setImage(rs.getString("image"));
                item.setPrice(rs.getBigDecimal("price"));
                item.setStock_quantity(rs.getInt("stock_quantity"));
                item.setStatus(rs.getString("status"));
                return item;
            }
        }
        return null; // No record found
    }

    /**
     * Deletes an item from the database by ID.
     */
    @Override
    public boolean deleteItemById(int item_id) throws Exception {
        String sql = "DELETE FROM items WHERE item_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, item_id);
            return ps.executeUpdate() == 1; // true if one row deleted
        }
    }

    /**
     * Updates an existing item's details.
     */
    @Override
    public boolean updateItem(Item item) throws Exception {
        String sql = "UPDATE items SET name=?, description=?, category=?, image=?, price=?, stock_quantity=?, status=? WHERE item_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, item.getName());
            ps.setString(2, item.getDescription());
            ps.setString(3, item.getCategory());
            ps.setString(4, item.getImage());
            ps.setBigDecimal(5, item.getPrice());
            ps.setInt(6, item.getStock_quantity());
            ps.setString(7, item.getStatus());
            ps.setInt(8, item.getItem_id());
            return ps.executeUpdate() == 1; // true if one row updated
        }
    }
}
