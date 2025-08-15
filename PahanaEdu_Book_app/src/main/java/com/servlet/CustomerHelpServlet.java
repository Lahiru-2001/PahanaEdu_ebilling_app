package com.servlet;

import com.DAO.HelpDAOImpl;
import com.DB.DBConnecter;
import com.entity.Help;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

/**
 * Servlet to handle customer help requests.
 */
@WebServlet("/customer_help") // URL mapping to access this servlet
public class CustomerHelpServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// Retrieve the current session without creating a new one
		HttpSession session = req.getSession(false);

		// If the user is not logged in, redirect to the login page
		if (session == null || session.getAttribute("customerId") == null) {
			resp.sendRedirect("index.jsp");
			return;
		}

		// Retrieve logged-in customer's ID from the session
		int customerId = (int) session.getAttribute("customerId");

		// Get help request data from the submitted form
		String title = req.getParameter("title");
		String message = req.getParameter("message");

		// Create a Help object and set its properties
		Help help = new Help();
		help.setCustomer_id(customerId);
		help.setTitle(title);
		help.setContent(message);

		// Try-with-resources to automatically close the database connection
		try (Connection conn = DBConnecter.getConnection()) {
			// Create DAO instance for Help table operations
			HelpDAOImpl dao = new HelpDAOImpl(conn);

			// Attempt to save the help request into the database
			boolean saved = dao.addHelp(help);

			// Store success or failure message in the session for display in JSP
			if (saved) {
				session.setAttribute("succMsg", "Your help request has been submitted successfully.");
			} else {
				session.setAttribute("failedMsg", "Something went wrong, please try again.");
			}

		} catch (Exception e) {
			// Log the error for debugging
			e.printStackTrace();
			// Store error message for display
			session.setAttribute("failedMsg", "Server error occurred.");
		}

		// Redirect the customer back to the Help page
		resp.sendRedirect("Customer_Help.jsp");
	}
}
