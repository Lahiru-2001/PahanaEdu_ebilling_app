/*
 * package com.servlet;
 * 
 * // Importing necessary DAO (Data Access Object) classes for Item entity
 * operations import com.DAO.ItemDAO; import com.DAO.ItemDAOImple; import
 * com.DB.DBConnecter; import com.entity.Item;
 * 
 * import javax.servlet.ServletException; import
 * javax.servlet.annotation.WebServlet; import javax.servlet.http.*; import
 * java.io.IOException; import java.util.List;
 * 
 *//**
	 * Servlet to load all available items from the database and display them on the
	 * customer home page.
	 */
/*
 * @WebServlet("/customer_Item_Load_Servlet") // URL pattern to trigger this
 * servlet public class customer_Item_Load_Servlet extends HttpServlet { private
 * static final long serialVersionUID = 1L; // Serialization ID for the servlet
 * class
 * 
 *//**
	 * Handles GET requests from the client. Retrieves all items from the database
	 * and forwards them to the JSP page for display.
	 *//*
		 * protected void doGet(HttpServletRequest request, HttpServletResponse
		 * response) throws ServletException, IOException {
		 * 
		 * try { // Create DAO instance with a database connection ItemDAO dao = new
		 * ItemDAOImple(DBConnecter.getConnection());
		 * 
		 * // Fetch the list of all items from the database List<Item> itemList =
		 * dao.getAllItems();
		 * 
		 * // Store the list of items in the request scope so it can be accessed in the
		 * JSP request.setAttribute("items", itemList);
		 * 
		 * // Forward the request to "Customer_Home.jsp" for rendering
		 * request.getRequestDispatcher("Customer_Home.jsp").forward(request, response);
		 * 
		 * } catch (Exception e) { // Print error stack trace for debugging purposes
		 * e.printStackTrace(); } } }
		 */