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

@WebServlet("/SaveHelpResponseServlet")
public class SaveHelpResponseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String helpIdStr = request.getParameter("helpId");
        String customerIdStr = request.getParameter("customerId");
        String message = request.getParameter("message");

        if (helpIdStr == null || customerIdStr == null || message == null || message.trim().isEmpty()) {
            response.getWriter().write("Invalid data.");
            return;
        }

        Connection conn = null;
        PreparedStatement psInsert = null;
        PreparedStatement psUpdate = null;

        try {
            conn = DBConnecter.getConnection();
            conn.setAutoCommit(false); // Transaction start

            // 1️⃣ Save reply to help_response table
            String insertSql = "INSERT INTO help_response (customer_id, help_id, response_ms) VALUES (?, ?, ?)";
            psInsert = conn.prepareStatement(insertSql);
            psInsert.setInt(1, Integer.parseInt(customerIdStr));
            psInsert.setInt(2, Integer.parseInt(helpIdStr));
            psInsert.setString(3, message);
            int rowsInserted = psInsert.executeUpdate();

            if (rowsInserted > 0) {
                // 2️⃣ Update help table status to "read"
                String updateSql = "UPDATE help SET status = 'read' WHERE help_id = ?";
                psUpdate = conn.prepareStatement(updateSql);
                psUpdate.setInt(1, Integer.parseInt(helpIdStr));
                int rowsUpdated = psUpdate.executeUpdate();

                if (rowsUpdated > 0) {
                    conn.commit(); // Commit both queries
                    response.getWriter().write("Reply saved successfully and status updated.");
                } else {
                    conn.rollback();
                    response.getWriter().write("Reply saved but failed to update status.");
                }
            } else {
                conn.rollback();
                response.getWriter().write("Failed to save reply.");
            }

        } catch (Exception e) {
            try {
                if (conn != null) conn.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        } finally {
            try {
                if (psInsert != null) psInsert.close();
                if (psUpdate != null) psUpdate.close();
                if (conn != null) conn.setAutoCommit(true);
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
