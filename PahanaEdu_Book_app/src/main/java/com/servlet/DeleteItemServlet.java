package com.servlet;

import java.io.IOException;
import java.net.http.HttpClient;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DAO.ItemDAO;
import com.DAO.ItemDAOImple;
import com.DB.DBConnecter;

@WebServlet("/delete_item")
public class DeleteItemServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int itemId = Integer.parseInt(request.getParameter("item_id"));
			ItemDAO dao = new ItemDAOImple(DBConnecter.getConnection());

			boolean deleted = dao.deleteItemById(itemId);
			if (deleted) {
				request.setAttribute("success", "Item deleted successfully.");
			} else {
				request.setAttribute("error", "Failed to delete item.");
			}
		} catch (Exception e) {
			request.setAttribute("error", "Error: " + e.getMessage());
		}
		request.getRequestDispatcher("view_items").forward(request, response); // Or redirect if needed
	}
}
