package com.servlet;

import com.DAO.ItemDAO;
import com.DAO.ItemDAOImple;
import com.DB.DBConnecter;
import com.entity.Item;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/add_new_item")
@MultipartConfig
public class Item_servlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String IMAGE_UPLOAD_DIR = "uploaded_images";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get form fields
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock_quantity");
        Part imagePart = request.getPart("image");

        // 2. Basic field validation
        if (name == null || name.isEmpty() || category == null || category.isEmpty()
                || priceStr == null || priceStr.isEmpty() || stockStr == null || stockStr.isEmpty()
                || imagePart == null || imagePart.getSize() == 0) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("Admin_Add_Item.jsp").forward(request, response);
            return;
        }

        try {
            BigDecimal price = new BigDecimal(priceStr);
            int stockQuantity = Integer.parseInt(stockStr);

            // 3. DAO check for duplicates
            ItemDAO dao = new ItemDAOImple(DBConnecter.getConnection());

            if (dao.isItemNameExists(name)) {
                request.setAttribute("error", "This item is already in the system!..");
                request.getRequestDispatcher("Admin_Add_Item.jsp").forward(request, response);
                return;
            }

            // 4. Save image to server
            String appPath = request.getServletContext().getRealPath("");
            String uploadPath = appPath + File.separator + IMAGE_UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            String imageFileName = System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();
            String imageFullPath = uploadPath + File.separator + imageFileName;
            imagePart.write(imageFullPath);

            // 5. Create item object
            Item item = new Item();
            item.setName(name);
            item.setDescription(description);
            item.setCategory(category);
            item.setImage(IMAGE_UPLOAD_DIR + "/" + imageFileName);
            item.setPrice(price);
            item.setStock_quantity(stockQuantity);
            item.setStatus("active");

            // 6. Save to DB
            boolean saved = dao.addItem(item);
            if (saved) {
                request.setAttribute("success", "New Item Add Successful!..");
            } else {
                request.setAttribute("error", "New Item Add Failed!..");
            }
            request.getRequestDispatcher("Admin_Add_Item.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error occurred: " + e.getMessage());
            request.getRequestDispatcher("Admin_Add_Item.jsp").forward(request, response);
        }
    }
}
