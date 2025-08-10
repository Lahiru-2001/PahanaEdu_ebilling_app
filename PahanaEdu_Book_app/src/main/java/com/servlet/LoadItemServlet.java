package com.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.DAO.ItemDAO;
import com.DAO.ItemDAOImple;
import com.DB.DBConnecter;
import com.entity.Item;

@WebServlet("/load_item")
public class LoadItemServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			int itemId = Integer.parseInt(request.getParameter("item_id"));

			ItemDAO dao = new ItemDAOImple(DBConnecter.getConnection());
			Item item = dao.getItemById(itemId);

			if (item != null) {
				request.setAttribute("item", item);
				request.getRequestDispatcher("Admin_Edit_Items.jsp").forward(request, response);
			} else {
				request.setAttribute("error", "Item not found.");
				request.getRequestDispatcher("Admin_View_Item.jsp").forward(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Error: " + e.getMessage());
			request.getRequestDispatcher("Admin_View_Item.jsp").forward(request, response);
		}
	}
}
