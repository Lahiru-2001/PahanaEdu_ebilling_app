package com.servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DAO.ItemDAO;
import com.DAO.ItemDAOImple;
import com.DB.DBConnecter;
import com.entity.Item;

@WebServlet("/view_items")
public class ViewItemsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ItemDAO dao = new ItemDAOImple(DBConnecter.getConnection());
            List<Item> itemList = dao.getAllItems();
            request.setAttribute("items", itemList);
        } catch (Exception e) {
            request.setAttribute("error", "Failed to load items.");
        }
        request.getRequestDispatcher("Admin_View_Item.jsp").forward(request, response);
    }
}
