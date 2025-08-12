package com.DAO;

import com.entity.Item;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAOImple implements ItemDAO {

	private final Connection conn;

	public ItemDAOImple(Connection conn) {
		this.conn = conn;
	}

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
			return ps.executeUpdate() == 1;
		}
	}
	


	@Override
	public boolean isItemNameExists(String name) throws Exception {
		String sql = "SELECT name FROM items WHERE name = ?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, name);
			ResultSet rs = ps.executeQuery();
			return rs.next();
		}
	}

	@Override
	public List<Item> getAllItems() throws Exception {
		List<Item> itemList = new ArrayList<>();
		String sql = "SELECT * FROM items";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
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

	@Override
	public Item getItemById(int item_id) throws Exception {
		String sql = "SELECT * FROM items WHERE item_id=?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, item_id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
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
		return null;
	}

	@Override
	public boolean deleteItemById(int item_id) throws Exception {
		String sql = "DELETE FROM items WHERE item_id = ?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, item_id);
			return ps.executeUpdate() == 1;
		}
	}

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
			return ps.executeUpdate() == 1;
		}
	}

}
