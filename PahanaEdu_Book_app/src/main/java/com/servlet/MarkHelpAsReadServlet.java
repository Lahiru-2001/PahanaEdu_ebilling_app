package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.DB.DBConnecter;

@WebServlet("/MarkHelpAsReadServlet")
public class MarkHelpAsReadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int helpId = Integer.parseInt(req.getParameter("help_id"));
        String helpResIdStr = req.getParameter("help_res_id");

        try (Connection conn = DBConnecter.getConnection()) {
            // Update help table status
            PreparedStatement ps1 = conn.prepareStatement("UPDATE help SET status='read' WHERE help_id=?");
            ps1.setInt(1, helpId);
            ps1.executeUpdate();

            // Update help_response status if exists
            if (helpResIdStr != null && !helpResIdStr.equals("0")) {
                PreparedStatement ps2 = conn.prepareStatement("UPDATE help_response SET status='read' WHERE help_res_id=?");
                ps2.setInt(1, Integer.parseInt(helpResIdStr));
                ps2.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        resp.sendRedirect("Customer_Help.jsp?help_id=" + helpId);
    }
}
