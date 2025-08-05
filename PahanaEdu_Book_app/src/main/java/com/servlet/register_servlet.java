// Define the servlet package
package com.servlet;

// Import required Java and servlet classes
import java.io.IOException;
import java.sql.Connection;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.DB.DBConnecter;
import com.DAO.UserDAO;
import com.DAO.UserDAOImple;
import com.DAO.CustomerDAO;
import com.DAO.CustomerDAOImple;
import com.entity.Customer;
import com.entity.User;
import com.util.PasswordUtil;

// Define the servlet mapping to handle requests sent to "/Customer_register"
@WebServlet("/Customer_register")
public class register_servlet extends HttpServlet {

	// Patterns for validating account number and phone number
	private static final Pattern ACCOUNT_PATTERN = Pattern.compile("\\d{6,}");
	private static final Pattern PHONE_PATTERN = Pattern.compile("\\d{10}");

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Collect form parameters from the request
		String first_name = req.getParameter("first_name");
		String last_name = req.getParameter("last_name");
		String address = req.getParameter("address");
		String acc_number = req.getParameter("account_Number");
		String phone_Number = req.getParameter("phone_Number");
		String user_name = req.getParameter("user_name");
		String password = req.getParameter("password");

		// Set values back to request in case form needs to be re-displayed
		req.setAttribute("first_name", first_name);
		req.setAttribute("last_name", last_name);
		req.setAttribute("address", address);
		req.setAttribute("account_Number", acc_number);
		req.setAttribute("phone_Number", phone_Number);
		req.setAttribute("user_name", user_name);

		boolean hasError = false;

		// Server-side form validation
		if (first_name == null || first_name.trim().isEmpty()) {
			req.setAttribute("err_first_name", "First name is required.");
			hasError = true;
		}
		if (last_name == null || last_name.trim().isEmpty()) {
			req.setAttribute("err_last_name", "Last name is required.");
			hasError = true;
		}
		if (address == null || address.trim().isEmpty()) {
			req.setAttribute("err_address", "Address is required.");
			hasError = true;
		}
		if (acc_number == null || !ACCOUNT_PATTERN.matcher(acc_number).matches()) {
			req.setAttribute("err_account_Number", "Account number must be at least 6 digits.");
			hasError = true;
		}
		if (phone_Number == null || !PHONE_PATTERN.matcher(phone_Number).matches()) {
			req.setAttribute("err_phone_Number", "Phone number must be exactly 10 digits.");
			hasError = true;
		}
		if (user_name == null || user_name.trim().isEmpty()) {
			req.setAttribute("err_user_name", "User name is required.");
			hasError = true;
		}
		if (password == null || password.length() < 4) {
			req.setAttribute("err_password", "Password must be at least 4 characters.");
			hasError = true;
		}

		// If any validation error, return to registration page
		if (hasError) {
			req.setAttribute("general_error", "Please fix the highlighted errors.");
			req.getRequestDispatcher("register.jsp").forward(req, resp);
			return;
		}

		Connection con = null;
		try {
			// Get database connection
			con = DBConnecter.getConnection();
			con.setAutoCommit(false); // Start transaction

			// Initialize DAO classes
			UserDAO userDao = new UserDAOImple(con);
			CustomerDAO customerDao = new CustomerDAOImple(con);

			// Check for existing username
			if (userDao.usernameExists(user_name)) {
				req.setAttribute("err_user_name", "Username already exists.");
				hasError = true;
			}

			// Check for existing account number
			if (customerDao.accountNumberExists(acc_number)) {
				req.setAttribute("err_account_Number", "Account number already exists.");
				hasError = true;
			}

			// If any duplicates found, rollback and return
			if (hasError) {
				con.rollback();
				req.setAttribute("general_error", "Please fix the highlighted errors.");
				req.getRequestDispatcher("register.jsp").forward(req, resp);
				return;
			}

			// Create new User entity
			User user = new User();
			user.setUsername(user_name);
			String hashed = PasswordUtil.hashPassword(password); // Hash the password
			user.setPasswordHash(hashed);
			user.setRole("customer"); // Default role
			user.setStatus("Active"); // Default status

			// Save user and retrieve generated user ID
			int newUserId = userDao.createUser(user);

			// Create new Customer entity with linked user ID
			Customer customer = new Customer();
			customer.setUser_Id(newUserId);
			customer.setAccount_Number(acc_number);
			customer.setFirst_Name(first_name);
			customer.setLast_Name(last_name);
			customer.setAddress(address);
			customer.setPhone_Number(phone_Number);
			customer.setStatus("Active"); // Default status

			// Save customer in database
			boolean customerCreated = customerDao.createCustomer(customer);
			if (!customerCreated) {
				con.rollback(); // Rollback if customer creation fails
				req.setAttribute("general_error", "Failed to create customer. Please try again.");
				req.getRequestDispatcher("register.jsp").forward(req, resp);
				return;
			}

			// Commit transaction
			con.commit();

			// Forward success message to login page
			req.setAttribute("success_message", "Registration success. Redirecting to login...");
			req.getRequestDispatcher("Login.jsp").forward(req, resp);

		} catch (Exception e) {
			try {
				if (con != null)
					con.rollback();
			} catch (Exception ignored) {
			}
			e.printStackTrace(); // Log error for debugging
			req.setAttribute("general_error", "An unexpected error occurred. Please try again later.");
			req.getRequestDispatcher("register.jsp").forward(req, resp);
		} finally {
			try {
				if (con != null)
					con.setAutoCommit(true);
			} catch (Exception ignored) {
			}
		}
	}
}
