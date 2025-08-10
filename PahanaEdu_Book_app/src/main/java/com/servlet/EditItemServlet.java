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

@WebServlet("/edit_item")
@MultipartConfig
public class EditItemServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			int itemId = Integer.parseInt(request.getParameter("item_id"));
			String name = request.getParameter("name");
			String description = request.getParameter("description");
			String category = request.getParameter("category");
			BigDecimal price = new BigDecimal(request.getParameter("price"));
			int stock = Integer.parseInt(request.getParameter("stock_quantity"));

			Part filePart = request.getPart("image");
			String imagePath;
			String existingImage = request.getParameter("existing_image");

			if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null) {
				String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
				String uploadPath = getServletContext().getRealPath("/") + "item_images";
				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists())
					uploadDir.mkdir();

				filePart.write(uploadPath + File.separator + fileName);
				imagePath = "item_images/" + fileName;
			} else {
				imagePath = existingImage;
			}

			Item item = new Item();
			item.setItem_id(itemId);
			item.setName(name);
			item.setDescription(description);
			item.setCategory(category);
			item.setPrice(price);
			item.setStock_quantity(stock);
			item.setImage(imagePath);
			item.setStatus("active");

			ItemDAO dao = new ItemDAOImple(DBConnecter.getConnection());
			boolean result = dao.updateItem(item);

			if (result) {
				request.setAttribute("success", "Item updated successfully.");
			} else {
				request.setAttribute("error", "Failed to update item.");
			}

			request.setAttribute("item", item);
			request.getRequestDispatcher("Admin_Edit_Items.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Error: " + e.getMessage());
			request.getRequestDispatcher("Admin_Edit_Items.jsp").forward(request, response);
		}
	}
}
