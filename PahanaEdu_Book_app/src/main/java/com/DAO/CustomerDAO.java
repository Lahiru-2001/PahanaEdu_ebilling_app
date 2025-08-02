package com.DAO;

import com.entity.Customer;

public interface CustomerDAO {
	boolean accountNumberExists(String accountNumber) throws Exception;
    boolean createCustomer(Customer customer) throws Exception;
}

