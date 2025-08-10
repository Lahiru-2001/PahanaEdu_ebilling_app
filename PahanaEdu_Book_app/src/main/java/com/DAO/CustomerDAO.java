package com.DAO;

import java.util.List;

import com.entity.Customer;

public interface CustomerDAO {
	boolean accountNumberExists(String accountNumber) throws Exception;

	boolean createCustomer(Customer customer) throws Exception;

	Customer getCustomerByUserId(int userId) throws Exception;

}
