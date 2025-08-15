package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.DB.DBConnecter;

/**
 * Servlet to mark a help request and its response (if any) as "read".
 * 
 */
@WebServlet("/MarkHelpAsReadServlet") // URL mapping to trigger this servlet(Customer_Help_Respones.jsp)
public class MarkHelpAsReadServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// Retrieve help_id parameter from the request
		int helpId = Integer.parseInt(req.getParameter("help_id"));

		// Retrieve help response ID (if any); may be null or "0" if no response
		String helpResIdStr = req.getParameter("help_res_id");

		try (Connection conn = DBConnecter.getConnection()) {

			// 1. Update the 'help' table to set status as "read" for this help request
			PreparedStatement ps1 = conn.prepareStatement("UPDATE help SET status='read' WHERE help_id=?");
			ps1.setInt(1, helpId);
			ps1.executeUpdate();

			// 2. If a help response exists, update its status as "read"
			if (helpResIdStr != null && !helpResIdStr.equals("0")) {
				PreparedStatement ps2 = conn
						.prepareStatement("UPDATE help_response SET status='read' WHERE help_res_id=?");
				ps2.setInt(1, Integer.parseInt(helpResIdStr));
				ps2.executeUpdate();
			}

		} catch (Exception e) {
			// Log any exceptions that occur during database operations
			e.printStackTrace();
		}

		// Redirect back to the customer help page, highlighting the current help
		// request
		resp.sendRedirect("Customer_Help.jsp?help_id=" + helpId);
	}
}
