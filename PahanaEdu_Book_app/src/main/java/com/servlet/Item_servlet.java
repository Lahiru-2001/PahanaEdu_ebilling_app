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

/**
 * Servlet for adding a new item into the inventory (Admin functionality).
 */
@WebServlet("/add_new_item") // URL mapping to trigger this servlet(Admin_Add_Item.jsp)
@MultipartConfig // Enables handling of file uploads in the request
public class Item_servlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Directory name where uploaded images will be stored inside the application
    private static final String IMAGE_UPLOAD_DIR = "uploaded_images";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Retrieve form input fields from the request
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock_quantity");
        Part imagePart = request.getPart("image"); // Uploaded file part for the item image

        // 2. Basic validation: ensure all required fields are provided
        if (name == null || name.isEmpty() ||
            category == null || category.isEmpty() ||
            priceStr == null || priceStr.isEmpty() ||
            stockStr == null || stockStr.isEmpty() ||
            imagePart == null || imagePart.getSize() == 0) {

            // If validation fails, set error message and return to form
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("Admin_Add_Item.jsp").forward(request, response);
            return;
        }

        try {
            // Convert price and stock quantity from String to correct data types
            BigDecimal price = new BigDecimal(priceStr);
            int stockQuantity = Integer.parseInt(stockStr);

            // 3. Check for duplicate item names using DAO
            ItemDAO dao = new ItemDAOImple(DBConnecter.getConnection());
            if (dao.isItemNameExists(name)) {
                request.setAttribute("error", "This item is already in the system!..");
                request.getRequestDispatcher("Admin_Add_Item.jsp").forward(request, response);
                return;
            }

            // 4. Save uploaded image to server storage
            String appPath = request.getServletContext().getRealPath(""); // Root path of application
            String uploadPath = appPath + File.separator + IMAGE_UPLOAD_DIR; // Full upload directory path
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir(); // Create directory if it does not exist
            }

            // Create a unique file name to avoid overwriting existing files
            String imageFileName = System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();
            String imageFullPath = uploadPath + File.separator + imageFileName;

            // Write the uploaded file to the target location
            imagePart.write(imageFullPath);

            // 5. Create Item object and populate it with form data
            Item item = new Item();
            item.setName(name);
            item.setDescription(description);
            item.setCategory(category);
            item.setImage(IMAGE_UPLOAD_DIR + "/" + imageFileName); // Relative path for DB
            item.setPrice(price);
            item.setStock_quantity(stockQuantity);
            item.setStatus("active"); // Default status when adding a new item

            // 6. Save the new item into the database
            boolean saved = dao.addItem(item);

            // 7. Set success or error message for the JSP page
            if (saved) {
                request.setAttribute("success", "New Item Add Successful!..");
            } else {
                request.setAttribute("error", "New Item Add Failed!..");
            }

            // Forward request and response back to the admin add item page
            request.getRequestDispatcher("Admin_Add_Item.jsp").forward(request, response);

        } catch (Exception e) {
            // Handle any errors that occur during processing
            e.printStackTrace();
            request.setAttribute("error", "Error occurred: " + e.getMessage());
            request.getRequestDispatcher("Admin_Add_Item.jsp").forward(request, response);
        }
    }
}
