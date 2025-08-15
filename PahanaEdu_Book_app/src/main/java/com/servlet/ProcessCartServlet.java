package com.servlet;

import com.DAO.CartImple;
import com.DB.DBConnecter;
import com.entity.CartItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.*;
import java.util.List;

// Servlet to handle processing of the shopping cart and creating orders(cart.jsp)
@WebServlet("/ProcessCartServlet")
public class ProcessCartServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Get the current HTTP session
		HttpSession session = req.getSession();

		// Retrieve the cart object from session
		CartImple cart = (CartImple) session.getAttribute("cart");

		// Check if the cart is empty
		if (cart == null || cart.getItems().isEmpty()) {
			session.setAttribute("errorMessage", "Your cart is empty.");
			resp.sendRedirect("cart.jsp"); // Redirect to cart page
			return;
		}

		// Retrieve user ID from session to identify the logged-in user
		int userId = (session.getAttribute("user_id") != null) ? (Integer) session.getAttribute("user_id") : 0;
		if (userId == 0) {
			session.setAttribute("errorMessage", "You must be logged in to process your order.");
			resp.sendRedirect("cart.jsp"); // Redirect if user is not logged in
			return;
		}

		try (Connection conn = DBConnecter.getConnection()) {
			conn.setAutoCommit(false); // Start a database transaction

			// 1. Get the customer_id corresponding to the logged-in user
			int customerId = 0;
			try (PreparedStatement ps = conn.prepareStatement("SELECT customer_id FROM customers WHERE user_id = ?")) {
				ps.setInt(1, userId);
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
					customerId = rs.getInt("customer_id");
				}
			}

			// If customer details not found, show error
			if (customerId == 0) {
				session.setAttribute("errorMessage", "Customer details not found.");
				resp.sendRedirect("cart.jsp");
				return;
			}

			// 2. Calculate total amount of the cart
			BigDecimal totalAmount = BigDecimal.ZERO;
			for (CartItem ci : cart.getItems()) {
				totalAmount = totalAmount.add(ci.getSubtotal());
			}

			// 3. Insert a new record into processing_bills table
			int billId = 0;
			try (PreparedStatement ps = conn.prepareStatement(
					"INSERT INTO processing_bills (customer_id, total_amount) VALUES (?, ?)",
					Statement.RETURN_GENERATED_KEYS)) {
				ps.setInt(1, customerId);
				ps.setBigDecimal(2, totalAmount);
				ps.executeUpdate();

				// Retrieve the generated bill ID for the new order
				ResultSet rs = ps.getGeneratedKeys();
				if (rs.next()) {
					billId = rs.getInt(1);
				}
			}

			// 4. Insert each cart item into processing_bill_items table
			String sql = "INSERT INTO processing_bill_items (bill_id, item_id, item_name, category, item_price, quantity, subtotal) VALUES (?, ?, ?, ?, ?, ?, ?)";
			try (PreparedStatement ps = conn.prepareStatement(sql)) {
				for (CartItem ci : cart.getItems()) {
					ps.setInt(1, billId); // Link item to the bill
					ps.setInt(2, ci.getBill_item_id()); // Item ID
					ps.setString(3, ci.getName()); // Item name
					ps.setString(4, ci.getCategory()); // Item category
					ps.setBigDecimal(5, ci.getPrice()); // Item price
					ps.setInt(6, ci.getQuantity()); // Quantity
					ps.setBigDecimal(7, ci.getSubtotal()); // Subtotal
					ps.addBatch(); // Add to batch for efficient insert
				}
				ps.executeBatch(); // Execute batch insert
			}

			// 5. Commit the transaction after successful inserts
			conn.commit();

			// 6. Clear the cart and update session with success message
			cart.clearCart();
			session.setAttribute("cart", cart);
			session.setAttribute("successMessage", "Your order has been processed successfully!");

		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("errorMessage", "An error occurred while processing your order.");
			// Optionally, you could rollback transaction here if needed
		}

		// Redirect back to cart page (showing success or error messages)
		resp.sendRedirect("cart.jsp");
	}
}
