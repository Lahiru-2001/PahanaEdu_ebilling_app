package com.servlet;

import com.DAO.HelpDAOImpl;
import com.DB.DBConnecter;
import com.entity.Help;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/customer_help")
public class CustomerHelpServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("customerId") == null) {
			resp.sendRedirect("index.jsp"); // Redirect to login if not logged in
			return;
		}

		int customerId = (int) session.getAttribute("customerId");
		String title = req.getParameter("title");
		String message = req.getParameter("message");

		Help help = new Help();
		help.setCustomer_id(customerId);
		help.setTitle(title);
		help.setContent(message);

		try (Connection conn = DBConnecter.getConnection()) {
			HelpDAOImpl dao = new HelpDAOImpl(conn);

			boolean saved = dao.addHelp(help);

			if (saved) {
				session.setAttribute("succMsg", "Your help request has been submitted successfully.");
			} else {
				session.setAttribute("failedMsg", "Something went wrong, please try again.");
			}

		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("failedMsg", "Server error occurred.");
		}

		resp.sendRedirect("Customer_Help.jsp");
	}
}
