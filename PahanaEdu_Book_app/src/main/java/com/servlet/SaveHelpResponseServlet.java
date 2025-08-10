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

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String helpIdStr = request.getParameter("helpId");
        String customerIdStr = request.getParameter("customerId");
        String message = request.getParameter("message");

        if (helpIdStr == null || customerIdStr == null || message == null || message.trim().isEmpty()) {
            response.getWriter().write("Invalid data.");
            return;
        }

        try (Connection conn = DBConnecter.getConnection()) {
            String sql = "INSERT INTO help_response (customer_id, help_id, response_ms) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(customerIdStr));
            ps.setInt(2, Integer.parseInt(helpIdStr));
            ps.setString(3, message);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                response.getWriter().write("Reply saved successfully.");
            } else {
                response.getWriter().write("Failed to save reply.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}
