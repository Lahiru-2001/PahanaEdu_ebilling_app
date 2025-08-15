package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.DB.DBConnecter;

/**
 * Servlet to handle deletion of a help request and its related responses.
 * 
 */
@WebServlet("/DeleteHelpResponseServlet") // URL mapping for this servlet(Customer_Help_Respones.jsp)
public class DeleteHelpResponseServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// Retrieve the help_id parameter from the request (submitted via form)
		int helpId = Integer.parseInt(req.getParameter("help_id"));

		// Try-with-resources to automatically close the database connection
		try (Connection conn = DBConnecter.getConnection()) {

			// Step 1: Delete all responses associated with the given help request
			PreparedStatement ps1 = conn.prepareStatement("DELETE FROM help_response WHERE help_id=?");
			ps1.setInt(1, helpId);
			ps1.executeUpdate();

			// Step 2: Delete the help request itself
			PreparedStatement ps2 = conn.prepareStatement("DELETE FROM help WHERE help_id=?");
			ps2.setInt(1, helpId);
			ps2.executeUpdate();

		} catch (Exception e) {
			// Log any exception for debugging purposes
			e.printStackTrace();
		}

		// Redirect the user back to the Help Responses page
		resp.sendRedirect("Customer_Help_Respones.jsp");
	}
}
