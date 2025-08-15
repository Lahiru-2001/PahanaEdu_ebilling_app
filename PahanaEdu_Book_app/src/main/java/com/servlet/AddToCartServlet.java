package com.servlet;

import com.entity.CartItem;
import com.DAO.CartImple;
import com.DAO.ItemDAO;
import com.DAO.ItemDAOImple;
import com.DB.DBConnecter;
import com.entity.Item;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;

// Map this servlet to the URL pattern /AddToCartServlet(Customer_All_items.jsp)
@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

	// Handle POST requests (usually from form submissions)
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// Get the item ID and quantity from the request parameters
		int itemId = Integer.parseInt(req.getParameter("item_id"));
		int quantity = Integer.parseInt(req.getParameter("quantity"));

		// Use try-with-resources to automatically close the database connection
		try (Connection conn = DBConnecter.getConnection()) {

			// Create an ItemDAO instance to interact with the Item table
			ItemDAO itemDAO = new ItemDAOImple(conn);

			// Retrieve the item details from the database by ID
			Item item = itemDAO.getItemById(itemId);

			if (item != null) {
				// Create a new CartItem object to store item details for the cart
				CartItem cartItem = new CartItem();
				cartItem.setBill_item_id(item.getItem_id());
				cartItem.setName(item.getName());
				cartItem.setCategory(item.getCategory());
				cartItem.setPrice(item.getPrice());
				cartItem.setQuantity(quantity);

				// Calculate subtotal (price * quantity)
				cartItem.setSubtotal(item.getPrice().multiply(BigDecimal.valueOf(quantity)));

				// Get the current HTTP session or create one if it does not exist
				HttpSession session = req.getSession();

				// Retrieve the existing cart from the session
				CartImple cart = (CartImple) session.getAttribute("cart");

				// If the cart does not exist in the session, create a new one
				if (cart == null) {
					cart = new CartImple();
				}

				// Add the item to the cart
				cart.addItem(cartItem);

				// Update the session with the updated cart
				session.setAttribute("cart", cart);

				// Set a success message to be displayed to the user
				session.setAttribute("message", "Item Add into the Cart Success");
			}
		} catch (Exception e) {
			// Print stack trace in case of exceptions (like database errors)
			e.printStackTrace();
		}

		// Redirect the user back to the page showing all items
		resp.sendRedirect("Customer_All_items.jsp");
	}
}
