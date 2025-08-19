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

@WebServlet("/UpdateCustomerProfileServlet")
public class UpdateCustomerProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = (int) request.getSession().getAttribute("user_id");

        // Collect updated profile data
        String fname = request.getParameter("first_name");
        String lname = request.getParameter("last_name");
        String phone = request.getParameter("phone_number");
        String address = request.getParameter("address");

        try (Connection conn = DBConnecter.getConnection()) {

            PreparedStatement psCustomer = conn.prepareStatement(
                "UPDATE customers SET first_name=?, last_name=?, address=?, phone_number=? WHERE user_id=?");

            psCustomer.setString(1, fname);
            psCustomer.setString(2, lname);
            psCustomer.setString(3, address);
            psCustomer.setString(4, phone);
            psCustomer.setInt(5, userId);

            int rows = psCustomer.executeUpdate();

            if (rows > 0) {
                request.setAttribute("successMsg", "Profile data updated successfully!");
            } else {
                request.setAttribute("errorMsg", "Failed to update profile. Try again.");
            }

            // Forward back to JSP (do not use sendRedirect here)
            request.getRequestDispatcher("Customer_Profile.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Something went wrong. Please try again.");
            request.getRequestDispatcher("Customer_Profile.jsp").forward(request, response);
        }
    }
}
