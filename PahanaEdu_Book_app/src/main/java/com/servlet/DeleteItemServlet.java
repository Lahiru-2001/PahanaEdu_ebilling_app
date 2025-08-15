package com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DAO.ItemDAO;
import com.DAO.ItemDAOImple;
import com.DB.DBConnecter;

/**
 * Servlet to handle deletion of an item from the inventory.
 */
@WebServlet("/delete_item") // URL mapping for deleting an item (Admin_View_Item.jsp)
public class DeleteItemServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			// Retrieve the item ID from the request and parse it to an integer
			int itemId = Integer.parseInt(request.getParameter("item_id"));

			// Create DAO instance for item operations
			ItemDAO dao = new ItemDAOImple(DBConnecter.getConnection());

			// Attempt to delete the item by its ID
			boolean deleted = dao.deleteItemById(itemId);

			// Set a success or failure message as a request attribute
			if (deleted) {
				request.setAttribute("success", "Item deleted successfully.");
			} else {
				request.setAttribute("error", "Failed to delete item.");
			}

		} catch (Exception e) {
			// If an error occurs, store the error message in request attributes
			request.setAttribute("error", "Error: " + e.getMessage());
		}

		// Forward the request to the "view_items" servlet or page to refresh the item
		// list
		request.getRequestDispatcher("view_items").forward(request, response);
		// Alternatively, use response.sendRedirect("view_items") if you prefer a
		// redirect
	}
}
