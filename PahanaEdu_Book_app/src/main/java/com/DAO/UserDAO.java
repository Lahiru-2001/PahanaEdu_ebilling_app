package com.DAO;

import com.entity.User;

public interface UserDAO {

	boolean usernameExists(String username) throws Exception;
    int createUser(User user) throws Exception; // returns generated user_id
}
