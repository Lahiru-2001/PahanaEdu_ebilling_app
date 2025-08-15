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

/**
 * Servlet to retrieve and display all items from the database.
 */
@WebServlet("/view_items") // URL mapping to trigger this servlet(Admin_View_Item.jsp)
public class ViewItemsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Create DAO instance for interacting with the items table
            ItemDAO dao = new ItemDAOImple(DBConnecter.getConnection());

            // Retrieve all items from the database
            List<Item> itemList = dao.getAllItems();

            // Store the list of items in the request scope for use in the JSP
            request.setAttribute("items", itemList);

        } catch (Exception e) {
            // If there's any error, set an error message to be displayed in JSP
            request.setAttribute("error", "Failed to load items.");
        }

        // Forward the request to the admin view page (JSP) for rendering
        request.getRequestDispatcher("Admin_View_Item.jsp").forward(request, response);
    }
}
