package com.servlet;

import com.DB.DBConnecter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

// Map this servlet to the URL pattern /ConfirmOrderServlet(Admin_C_Orders.jsp)
@WebServlet("/ConfirmOrderServlet")
public class ConfirmOrderServlet extends HttpServlet {

	// Handle POST requests
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Get the bill ID parameter from the request
		String billIdStr = request.getParameter("bill_id");

		// If bill_id is missing, return HTTP 400 Bad Request
		if (billIdStr == null) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}

		// Use try-with-resources to automatically close DB connection and
		// PreparedStatement
		try (Connection conn = DBConnecter.getConnection();
				PreparedStatement ps = conn
						.prepareStatement("UPDATE processing_bills SET status = 'Orders Confirm' WHERE bill_id = ?")) {

			// Set the bill_id parameter in the SQL statement
			ps.setInt(1, Integer.parseInt(billIdStr));

			// Execute the update statement
			int updated = ps.executeUpdate();

			// If at least one row was updated, return HTTP 200 OK
			if (updated > 0) {
				response.setStatus(HttpServletResponse.SC_OK);
			}
			// If no rows were updated, the bill_id was not found, return HTTP 404 Not Found
			else {
				response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			}

		} catch (Exception e) {
			// Print stack trace for debugging in case of exceptions
			e.printStackTrace();
			// Return HTTP 500 Internal Server Error on exception
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}
}
