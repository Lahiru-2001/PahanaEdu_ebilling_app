package com.DAO;

import java.util.List;
import com.entity.Customer;

/**
 * Data Access Object (DAO) interface for Customer operations. Defines the
 * methods for interacting with the Customer data in the database.
 */
public interface CustomerDAO {

	/**
	 * Checks if a given account number already exists in the database.
	 * 
	 */
	boolean accountNumberExists(String accountNumber) throws Exception;

	/**
	 * Creates a new customer record in the database.
	 * 
	 */
	boolean createCustomer(Customer customer) throws Exception;

	/**
	 * Retrieves a customer record based on the associated user ID.
	 * 
	 */
	Customer getCustomerByUserId(int userId) throws Exception;
}
