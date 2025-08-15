package com.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Servlet to handle user logout.
 */
@WebServlet("/LogoutServlet") // URL mapping to trigger logout
public class LogoutServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * Handles GET requests to log out a user.
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Retrieve the current session; don't create a new one if it doesn't exist
		HttpSession session = request.getSession(false);

		// If a session exists, invalidate it to log out the user
		if (session != null) {
			session.invalidate();
		}

		// Redirect the user to the index (home) page after logout
		response.sendRedirect("index.jsp");
	}
}
