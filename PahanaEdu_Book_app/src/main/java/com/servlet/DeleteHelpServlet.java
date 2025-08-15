package com.servlet;

import com.DB.DBConnecter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet for deleting a help request from the database (admin side).
 * 
 */
@WebServlet("/DeleteHelpServlet") // URL mapping for this servlet(Admin_help.jsp)
public class DeleteHelpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DeleteHelpServlet() {
		super();
	}

	/**
	 * Handles GET requests for deleting a help message.
	 * 
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Retrieve the helpId parameter from the request
		String helpIdStr = request.getParameter("helpId");

		// Validate that helpId is provided
		if (helpIdStr == null || helpIdStr.trim().isEmpty()) {
			response.sendRedirect("Admin_help.jsp?msg=Invalid Help ID");
			return;
		}

		int helpId = 0;
		try {
			// Attempt to parse helpId into an integer
			helpId = Integer.parseInt(helpIdStr);
		} catch (NumberFormatException e) {
			// If parsing fails, redirect with an error message
			response.sendRedirect("Admin_help.jsp?msg=Invalid Help ID format");
			return;
		}

		// Try-with-resources ensures DB connection is closed automatically
		try (Connection conn = DBConnecter.getConnection()) {
			// Prepare SQL statement to delete the help record
			String sql = "DELETE FROM help WHERE help_id = ?";
			try (PreparedStatement ps = conn.prepareStatement(sql)) {
				ps.setInt(1, helpId);

				// Execute the deletion and get the number of affected rows
				int deleted = ps.executeUpdate();

				// Redirect with a message based on whether the record was deleted
				if (deleted > 0) {
					response.sendRedirect("Admin_help.jsp?msg=Help message deleted successfully");
				} else {
					response.sendRedirect("Admin_help.jsp?msg=Help message not found");
				}
			}
		} catch (Exception e) {
			// Log the exception and redirect with an error message
			e.printStackTrace();
			response.sendRedirect("Admin_help.jsp?msg=Error deleting help message");
		}
	}

	/**
	 * Handles POST requests by delegating to doGet()
	 * 
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
