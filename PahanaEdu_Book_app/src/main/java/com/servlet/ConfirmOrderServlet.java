package com.servlet;

import com.DB.DBConnecter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ConfirmOrderServlet")
public class ConfirmOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String billIdStr = request.getParameter("bill_id");
        if (billIdStr == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try (Connection conn = DBConnecter.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 "UPDATE processing_bills SET status = 'Orders Confirm' WHERE bill_id = ?")) {
            ps.setInt(1, Integer.parseInt(billIdStr));
            int updated = ps.executeUpdate();
            if (updated > 0) {
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
