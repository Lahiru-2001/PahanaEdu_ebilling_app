package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.entity.Customer;

public class CustomerDAOImple implements CustomerDAO {

    private final Connection con;

    public CustomerDAOImple(Connection con) {
        this.con = con;
    }

    @Override
    public boolean accountNumberExists(String accountNumber) throws Exception {
        String sql = "SELECT customer_id FROM customers WHERE account_number = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, accountNumber);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    @Override
    public boolean createCustomer(Customer customer) throws Exception {
        String sql = "INSERT INTO customers(user_id, account_number, first_name, last_name, address, phone_number, status) VALUES (?,?,?,?,?,?,?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, customer.getUser_Id());
            ps.setString(2, customer.getAccount_Number());
            ps.setString(3, customer.getFirst_Name());
            ps.setString(4, customer.getLast_Name());
            ps.setString(5, customer.getAddress());
            ps.setString(6, customer.getPhone_Number());
            ps.setString(7, customer.getStatus());
            int i = ps.executeUpdate();
            return i == 1;
        }
    }
}
