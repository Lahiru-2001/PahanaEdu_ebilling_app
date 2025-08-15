package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.entity.Customer;

/**
 * Implementation of the CustomerDAO interface.
 * Provides database interaction logic for managing customer records.
 */
public class CustomerDAOImple implements CustomerDAO {

    // Database connection reference
    private final Connection con;

    /**
     * Constructor to initialize DAO with an active database connection.
     */
    public CustomerDAOImple(Connection con) {
        this.con = con;
    }

    /**
     * Checks if an account number already exists in the customers table.
     */
    @Override
    public boolean accountNumberExists(String accountNumber) throws Exception {
        String sql = "SELECT customer_id FROM customers WHERE account_number = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, accountNumber);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // Returns true if a matching record is found
            }
        }
    }

    /**
     * Inserts a new customer record into the database.
     */
    @Override
    public boolean createCustomer(Customer customer) throws Exception {
        String sql = "INSERT INTO customers(user_id, account_number, first_name, last_name, address, phone_number, status) VALUES (?,?,?,?,?,?,?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            // Set parameter values from the Customer object
            ps.setInt(1, customer.getUser_Id());
            ps.setString(2, customer.getAccount_Number());
            ps.setString(3, customer.getFirst_Name());
            ps.setString(4, customer.getLast_Name());
            ps.setString(5, customer.getAddress());
            ps.setString(6, customer.getPhone_Number());
            ps.setString(7, customer.getStatus());

            int i = ps.executeUpdate(); // Execute insert query
            return i == 1; // Return true if one record was inserted
        }
    }

    /**
     * Retrieves a Customer record from the database using the user ID.
     */
    @Override
    public Customer getCustomerByUserId(int userId) throws Exception {
        String sql = "SELECT customer_id, user_id, account_number, first_name, last_name, address, phone_number, status FROM customers WHERE user_id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Map result set data to Customer object
                    Customer cust = new Customer();
                    cust.setCustomer_Id(rs.getInt("customer_id"));
                    cust.setUser_Id(rs.getInt("user_id"));
                    cust.setAccount_Number(rs.getString("account_number"));
                    cust.setFirst_Name(rs.getString("first_name"));
                    cust.setLast_Name(rs.getString("last_name"));
                    cust.setAddress(rs.getString("address"));
                    cust.setPhone_Number(rs.getString("phone_number"));
                    cust.setStatus(rs.getString("status"));
                    return cust;
                }
            }
        }
        return null; // Return null if no matching record found
    }
}
