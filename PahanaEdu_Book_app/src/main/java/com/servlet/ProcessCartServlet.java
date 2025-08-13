package com.servlet;

import com.DAO.CartImple;
import com.DB.DBConnecter;
import com.entity.CartItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.*;
import java.util.List;

@WebServlet("/ProcessCartServlet")
public class ProcessCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        CartImple cart = (CartImple) session.getAttribute("cart");

        if (cart == null || cart.getItems().isEmpty()) {
            session.setAttribute("errorMessage", "Your cart is empty.");
            resp.sendRedirect("cart.jsp");
            return;
        }

        int userId = (session.getAttribute("user_id") != null) ? (Integer) session.getAttribute("user_id") : 0;
        if (userId == 0) {
            session.setAttribute("errorMessage", "You must be logged in to process your order.");
            resp.sendRedirect("cart.jsp");
            return;
        }

        try (Connection conn = DBConnecter.getConnection()) {
            conn.setAutoCommit(false); // start transaction

            // 1. Get customer_id from user_id
            int customerId = 0;
            try (PreparedStatement ps = conn.prepareStatement("SELECT customer_id FROM customers WHERE user_id = ?")) {
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    customerId = rs.getInt("customer_id");
                }
            }

            if (customerId == 0) {
                session.setAttribute("errorMessage", "Customer details not found.");
                resp.sendRedirect("cart.jsp");
                return;
            }

            // 2. Insert into processing_bills
            BigDecimal totalAmount = BigDecimal.ZERO;
            for (CartItem ci : cart.getItems()) {
                totalAmount = totalAmount.add(ci.getSubtotal());
            }

            int billId = 0;
            try (PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO processing_bills (customer_id, total_amount) VALUES (?, ?)",
                    Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, customerId);
                ps.setBigDecimal(2, totalAmount);
                ps.executeUpdate();

                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    billId = rs.getInt(1);
                }
            }

            // 3. Insert into processing_bill_items
            String sql = "INSERT INTO processing_bill_items (bill_id, item_id, item_name, category, item_price, quantity, subtotal) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                for (CartItem ci : cart.getItems()) {
                    ps.setInt(1, billId);
                    ps.setInt(2, ci.getBill_item_id());
                    ps.setString(3, ci.getName());
                    ps.setString(4, ci.getCategory());
                    ps.setBigDecimal(5, ci.getPrice());
                    ps.setInt(6, ci.getQuantity());
                    ps.setBigDecimal(7, ci.getSubtotal());
                    ps.addBatch();
                }
                ps.executeBatch();
            }

            // 4. Commit transaction
            conn.commit();

            // 5. Clear cart and set success message
            cart.clearCart();
            session.setAttribute("cart", cart);
            session.setAttribute("successMessage", "Your order has been processed successfully!");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "An error occurred while processing your order.");
        }

        resp.sendRedirect("cart.jsp");
    }
}
