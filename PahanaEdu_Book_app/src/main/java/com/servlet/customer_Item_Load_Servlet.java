package com.servlet;

import com.DAO.ItemDAO;
import com.DAO.ItemDAOImple;
import com.DB.DBConnecter;
import com.entity.Item;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/customer_Item_Load_Servlet")
public class customer_Item_Load_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			ItemDAO dao = new ItemDAOImple(DBConnecter.getConnection());
			List<Item> itemList = dao.getAllItems();

			request.setAttribute("items", itemList);
			request.getRequestDispatcher("Customer_Home.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
