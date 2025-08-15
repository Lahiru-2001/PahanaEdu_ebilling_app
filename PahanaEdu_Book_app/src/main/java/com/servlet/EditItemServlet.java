package com.servlet;

import java.io.*;
import java.math.BigDecimal;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import com.DAO.ItemDAO;
import com.DAO.ItemDAOImple;
import com.DB.DBConnecter;
import com.entity.Item;

/**
 * Servlet for handling the update (edit) of an existing item in the inventory.
 */
@WebServlet("/edit_item") // URL mapping for editing items (Admin_View_Item.jsp)
@MultipartConfig // Enables multipart/form-data for file uploads
public class EditItemServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			// Retrieve item details from the request form
			int itemId = Integer.parseInt(request.getParameter("item_id"));
			String name = request.getParameter("name");
			String description = request.getParameter("description");
			String category = request.getParameter("category");
			BigDecimal price = new BigDecimal(request.getParameter("price"));
			int stock = Integer.parseInt(request.getParameter("stock_quantity"));

			// Retrieve uploaded file part for the image
			Part filePart = request.getPart("image");
			String imagePath;
			String existingImage = request.getParameter("existing_image"); // Path of existing image

			// If a new image file is uploaded, save it to server
			if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null) {
				// Create a unique filename using timestamp
				String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

				// Define upload directory inside the server context
				String uploadPath = getServletContext().getRealPath("/") + "item_images";
				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists()) // Create folder if it doesn't exist
					uploadDir.mkdir();

				// Save the uploaded file
				filePart.write(uploadPath + File.separator + fileName);

				// Set relative path for database storage
				imagePath = "item_images/" + fileName;
			} else {
				// If no new image uploaded, keep the existing image
				imagePath = existingImage;
			}

			// Create Item object and set updated details
			Item item = new Item();
			item.setItem_id(itemId);
			item.setName(name);
			item.setDescription(description);
			item.setCategory(category);
			item.setPrice(price);
			item.setStock_quantity(stock);
			item.setImage(imagePath);
			item.setStatus("active"); // Status remains active after edit

			// Perform the update operation using DAO
			ItemDAO dao = new ItemDAOImple(DBConnecter.getConnection());
			boolean result = dao.updateItem(item);

			// Set success or error message based on update result
			if (result) {
				request.setAttribute("success", "Item updated successfully.");
			} else {
				request.setAttribute("error", "Failed to update item.");
			}

			// Forward updated item data back to edit page for confirmation
			request.setAttribute("item", item);
			request.getRequestDispatcher("Admin_Edit_Items.jsp").forward(request, response);

		} catch (Exception e) {
			// Log error and forward error message back to JSP
			e.printStackTrace();
			request.setAttribute("error", "Error: " + e.getMessage());
			request.getRequestDispatcher("Admin_Edit_Items.jsp").forward(request, response);
		}
	}
}
