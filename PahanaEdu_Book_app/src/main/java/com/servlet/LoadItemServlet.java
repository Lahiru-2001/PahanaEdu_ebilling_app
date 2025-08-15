package com.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.DAO.ItemDAO;
import com.DAO.ItemDAOImple;
import com.DB.DBConnecter;
import com.entity.Item;

/**
 * Servlet to load a specific item's details from the database.
 * 
 */
@WebServlet("/load_item") // URL mapping to trigger this servlet(Admin_View_Item.jsp)
public class LoadItemServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			// Retrieve the item_id parameter from the request and parse it to an integer
			int itemId = Integer.parseInt(request.getParameter("item_id"));

			// Create DAO instance to fetch item details
			ItemDAO dao = new ItemDAOImple(DBConnecter.getConnection());
			Item item = dao.getItemById(itemId);

			// If the item exists, forward to the edit page with its details
			if (item != null) {
				request.setAttribute("item", item);
				request.getRequestDispatcher("Admin_Edit_Items.jsp").forward(request, response);
			} else {
				// If no matching item is found, forward back to the item view page with an
				// error message
				request.setAttribute("error", "Item not found.");
				request.getRequestDispatcher("Admin_View_Item.jsp").forward(request, response);
			}

		} catch (Exception e) {
			// Handle and log any errors that occur while processing
			e.printStackTrace();
			request.setAttribute("error", "Error: " + e.getMessage());
			request.getRequestDispatcher("Admin_View_Item.jsp").forward(request, response);
		}
	}
}
