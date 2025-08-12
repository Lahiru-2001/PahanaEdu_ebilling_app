package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.DB.DBConnecter;

@WebServlet("/DeleteHelpResponseServlet")
public class DeleteHelpResponseServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int helpId = Integer.parseInt(req.getParameter("help_id"));

        try (Connection conn = DBConnecter.getConnection()) {
            // Delete from help_response first
            PreparedStatement ps1 = conn.prepareStatement("DELETE FROM help_response WHERE help_id=?");
            ps1.setInt(1, helpId);
            ps1.executeUpdate();

            // Delete from help
            PreparedStatement ps2 = conn.prepareStatement("DELETE FROM help WHERE help_id=?");
            ps2.setInt(1, helpId);
            ps2.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        resp.sendRedirect("Customer_Help_Respones.jsp");
    }
}
