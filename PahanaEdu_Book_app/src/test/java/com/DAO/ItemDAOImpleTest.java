package com.DAO;

import com.DB.DBConnecter;
import com.entity.Item;

import org.junit.jupiter.api.*;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Test class for ItemDAOImple.
 */
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
class ItemDAOImpleTest {

    private Connection conn;
    // Shared DB connection for all tests
    private ItemDAOImple itemDAO;
    // DAO instance under test

    @BeforeAll
    void setUpConnection() throws SQLException {
        // Initialize database connection before all tests
        conn = DBConnecter.getConnection();
        conn.setAutoCommit(false); // Rollback changes after each test
        itemDAO = new ItemDAOImple(conn);
    }

    @AfterEach
    void rollback() throws SQLException {
        // Roll back any changes made during the test to maintain DB state
        conn.rollback();
    }

    @AfterAll
    void tearDown() throws SQLException {
        // Close connection after all tests
        if (conn != null && !conn.isClosed()) {
            conn.close();
        }
    }

    /**
     * Helper method to create a sample Item object.
     */
    private Item createTestItem(String name) {
        Item item = new Item();
        item.setName(name);
        item.setDescription("Test Description");
        item.setCategory("Test Category");
        item.setImage("test.png");
        item.setPrice(BigDecimal.valueOf(100.50));
        item.setStock_quantity(10);
        item.setStatus("Available");
        return item;
    }

    @Test
    void testAddItemAndGetItemById() throws Exception {
        // Test adding an item and verifying it exists in the DB
        Item item = createTestItem("TestItem1");
        assertTrue(itemDAO.addItem(item), "Item should be added successfully");

        // Fetch all items and check if the inserted item exists
        List<Item> items = itemDAO.getAllItems();
        assertTrue(items.stream().anyMatch(i -> i.getName().equals("TestItem1")),
                "Inserted item should exist in DB");
    }

    @Test
    void testIsItemNameExists() throws Exception {
        // Test checking if an item name exists
        Item item = createTestItem("UniqueItem");
        itemDAO.addItem(item);

        assertTrue(itemDAO.isItemNameExists("UniqueItem"), "Existing item should return true");
        assertFalse(itemDAO.isItemNameExists("NonExisting"), "Non-existing item should return false");
    }

    @Test
    void testGetAllItems() throws Exception {
        // Test fetching all items
        Item item1 = createTestItem("ItemA");
        Item item2 = createTestItem("ItemB");
        itemDAO.addItem(item1);
        itemDAO.addItem(item2);

        List<Item> items = itemDAO.getAllItems();
        assertTrue(items.size() >= 2, "There should be at least 2 items in DB");
    }

    @Test
    void testGetItemById() throws Exception {
        // Test fetching an item by ID
        Item item = createTestItem("FindMeItem");
        assertTrue(itemDAO.addItem(item));

        // Find the inserted item's ID
        List<Item> items = itemDAO.getAllItems();
        Item inserted = items.stream()
                .filter(i -> i.getName().equals("FindMeItem"))
                .findFirst()
                .orElse(null);

        assertNotNull(inserted, "Inserted item should not be null");
        Item found = itemDAO.getItemById(inserted.getItem_id());
        assertNotNull(found, "Fetched item should not be null");
        assertEquals("FindMeItem", found.getName(), "Fetched item name should match");
    }

    @Test
    void testUpdateItem() throws Exception {
        // Test updating an existing item
        Item item = createTestItem("OldName");
        assertTrue(itemDAO.addItem(item));

        // Get inserted item
        Item inserted = itemDAO.getAllItems().stream()
                .filter(i -> i.getName().equals("OldName"))
                .findFirst()
                .orElseThrow();

        // Update name and price
        inserted.setName("UpdatedName");
        inserted.setPrice(BigDecimal.valueOf(200.75));
        assertTrue(itemDAO.updateItem(inserted), "Update should succeed");

        Item updated = itemDAO.getItemById(inserted.getItem_id());
        assertEquals("UpdatedName", updated.getName(), "Name should be updated");
        assertEquals(BigDecimal.valueOf(200.75), updated.getPrice(), "Price should be updated");
    }

    @Test
    void testDeleteItemById() throws Exception {
        // Test deleting an item by ID
        Item item = createTestItem("DeleteMe");
        assertTrue(itemDAO.addItem(item));

        // Find inserted item
        Item inserted = itemDAO.getAllItems().stream()
                .filter(i -> i.getName().equals("DeleteMe"))
                .findFirst()
                .orElseThrow();

        assertTrue(itemDAO.deleteItemById(inserted.getItem_id()), "Item should be deleted");
        assertNull(itemDAO.getItemById(inserted.getItem_id()), "Deleted item should no longer exist");
    }
}
