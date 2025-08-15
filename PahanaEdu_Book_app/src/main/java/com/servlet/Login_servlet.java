package com.servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.DAO.UserDAO;
import com.DAO.UserDAOImple;
import com.DB.DBConnecter;
import com.DAO.CustomerDAO;
import com.DAO.CustomerDAOImple;
import com.entity.User;
import com.entity.Customer;

/**
 * Handles user login requests for both customers and admins.
 * 
 */
@WebServlet("/usrs_login") // Servlet mapping for login requests (Login.jsp)
public class Login_servlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// Retrieve login form parameters
		String username = req.getParameter("username");
		String password = req.getParameter("password"); // Currently stored as plain text

		// Basic input validation before querying the database
		if (username == null || username.isBlank() || password == null || password.length() < 4) {
			req.setAttribute("loginError",
					"Username and password are required. Password must be at least 4 characters.");
			req.getRequestDispatcher("Login.jsp").forward(req, resp);
			return; // Stop execution if validation fails
		}

		// Use try-with-resources to ensure database connection is closed automatically
		try (Connection con = DBConnecter.getConnection()) {

			// Authenticate the user using the UserDAO
			UserDAO userDao = new UserDAOImple(con);
			User user = userDao.login(username, password);

			// If no matching user found, return to login page with an error
			if (user == null) {
				req.setAttribute("loginError", "Invalid username or password.");
				req.getRequestDispatcher("Login.jsp").forward(req, resp);
				return;
			}

			// Retrieve user role and start a new session
			String role = user.getRole();
			HttpSession session = req.getSession(true); // Create new session if not exists
			session.setAttribute("loggedUser", user);
			session.setAttribute("role", role != null ? role.toLowerCase() : "");

			// If the logged-in user is a customer
			if ("customer".equalsIgnoreCase(role)) {
				CustomerDAO custDao = new CustomerDAOImple(con);
				Customer customer = custDao.getCustomerByUserId(user.getUser_id());

				// If customer details exist, store them in session for later use
				if (customer != null) {
					session.setAttribute("customer", customer);
					session.setAttribute("firstName", customer.getFirst_Name());
					session.setAttribute("lastName", customer.getLast_Name());
					session.setAttribute("accountNumber", customer.getAccount_Number());
					session.setAttribute("customerId", customer.getCustomer_Id());
					session.setAttribute("user_id", user.getUser_id());
				}

				// Redirect customer to their home page
				resp.sendRedirect("Customer_Home.jsp");

				// If the logged-in user is an admin
			} else if ("admin".equalsIgnoreCase(role)) {
				resp.sendRedirect("Admin_Home.jsp");

				// If role is unknown or unsupported
			} else {
				req.setAttribute("loginError", "User role is unrecognized.");
				req.getRequestDispatcher("Login.jsp").forward(req, resp);
			}

		} catch (Exception e) {
			// Log the exception and show a generic error message to the user
			e.printStackTrace();
			req.setAttribute("loginError", "An internal error occurred. Please try again later.");
			req.getRequestDispatcher("Login.jsp").forward(req, resp);
		}
	}
}
