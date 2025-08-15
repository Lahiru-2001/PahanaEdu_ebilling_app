package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DB.DBConnecter;

// Servlet to handle saving customer responses to help requests
@WebServlet("/SaveHelpResponseServlet")
public class SaveHelpResponseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Collect parameters from request
        String helpIdStr = request.getParameter("helpId");       // Help request ID
        String customerIdStr = request.getParameter("customerId"); // Customer ID who replies
        String message = request.getParameter("message");        // Response message

        // Validate inputs
        if (helpIdStr == null || customerIdStr == null || message == null || message.trim().isEmpty()) {
            response.getWriter().write("Invalid data."); // Return error if missing
            return;
        }

        Connection conn = null;
        PreparedStatement psInsert = null;
        PreparedStatement psUpdate = null;

        try {
            // 1️⃣ Get database connection
            conn = DBConnecter.getConnection();
            conn.setAutoCommit(false); // Start transaction to ensure both insert and update succeed together

            // 2️⃣ Insert the response into help_response table
            String insertSql = "INSERT INTO help_response (customer_id, help_id, response_ms) VALUES (?, ?, ?)";
            psInsert = conn.prepareStatement(insertSql);
            psInsert.setInt(1, Integer.parseInt(customerIdStr));
            psInsert.setInt(2, Integer.parseInt(helpIdStr));
            psInsert.setString(3, message);
            int rowsInserted = psInsert.executeUpdate(); // Execute insert

            if (rowsInserted > 0) {
                // 3️⃣ If insert successful, update help table status to 'read'
                String updateSql = "UPDATE help SET status = 'read' WHERE help_id = ?";
                psUpdate = conn.prepareStatement(updateSql);
                psUpdate.setInt(1, Integer.parseInt(helpIdStr));
                int rowsUpdated = psUpdate.executeUpdate(); // Execute update

                if (rowsUpdated > 0) {
                    conn.commit(); // Commit transaction if both queries succeed
                    response.getWriter().write("Reply saved successfully and status updated.");
                } else {
                    conn.rollback(); // Rollback if status update fails
                    response.getWriter().write("Reply saved but failed to update status.");
                }
            } else {
                conn.rollback(); // Rollback if insert fails
                response.getWriter().write("Failed to save reply.");
            }

        } catch (Exception e) {
            try {
                if (conn != null) conn.rollback(); // Rollback transaction on exception
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        } finally {
            try {
                // Close resources to prevent memory leaks
                if (psInsert != null) psInsert.close();
                if (psUpdate != null) psUpdate.close();
                if (conn != null) conn.setAutoCommit(true); // Reset auto-commit
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
