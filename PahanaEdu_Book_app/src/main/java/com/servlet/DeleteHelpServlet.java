package com.servlet;

import com.DB.DBConnecter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteHelpServlet")
public class DeleteHelpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DeleteHelpServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String helpIdStr = request.getParameter("helpId");
        if (helpIdStr == null || helpIdStr.trim().isEmpty()) {
            response.sendRedirect("Admin_help.jsp?msg=Invalid Help ID");
            return;
        }

        int helpId = 0;
        try {
            helpId = Integer.parseInt(helpIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("Admin_help.jsp?msg=Invalid Help ID format");
            return;
        }

        try (Connection conn = DBConnecter.getConnection()) {
            String sql = "DELETE FROM help WHERE help_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, helpId);
                int deleted = ps.executeUpdate();
                if (deleted > 0) {
                    response.sendRedirect("Admin_help.jsp?msg=Help message deleted successfully");
                } else {
                    response.sendRedirect("Admin_help.jsp?msg=Help message not found");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Admin_help.jsp?msg=Error deleting help message");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
