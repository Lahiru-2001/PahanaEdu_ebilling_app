package com.DAO;

import com.entity.Item;
import java.util.List;

public interface ItemDAO {
	boolean addItem(Item item) throws Exception;

	boolean isItemNameExists(String name) throws Exception;

	List<Item> getAllItems() throws Exception;

	Item getItemById(int item_id) throws Exception;

	boolean deleteItemById(int item_id) throws Exception;

	boolean updateItem(Item item) throws Exception;

}
