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
import com.util.PasswordUtil;

// Servlet to handle updating a customer's profile information
@WebServlet("/UpdateCustomerProfileServlet")
public class UpdateCustomerProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve the logged-in user's ID from the session
        int userId = (int) request.getSession().getAttribute("user_id");

        // Collect updated profile data from form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password"); // Plain password from form
        String account = request.getParameter("account_number"); // Account number is not updated here
        String fname = request.getParameter("first_name");
        String lname = request.getParameter("last_name");
        String phone = request.getParameter("phone_number");
        String address = request.getParameter("address");

        try (Connection conn = DBConnecter.getConnection()) {

            // ===========================
            // Hash the new password before storing
            // ===========================
            String hashedPassword = PasswordUtil.hashPassword(password);

            // ===========================
            // Update 'users' table with new username and hashed password
            // ===========================
            PreparedStatement psUser = conn
                    .prepareStatement("UPDATE users SET username=?, password_hash=? WHERE user_id=?");
            psUser.setString(1, username);
            psUser.setString(2, hashedPassword);
            psUser.setInt(3, userId);
            psUser.executeUpdate(); // Execute update

            // ===========================
            // Update 'customers' table with personal details
            // ===========================
            PreparedStatement psCustomer = conn.prepareStatement(
                    "UPDATE customers SET first_name=?, last_name=?, address=?, phone_number=? WHERE user_id=?");
            psCustomer.setString(1, fname);
            psCustomer.setString(2, lname);
            psCustomer.setString(3, address);
            psCustomer.setString(4, phone);
            psCustomer.setInt(5, userId);
            psCustomer.executeUpdate(); // Execute update

            // Redirect to profile page with success flag
            response.sendRedirect("Customer_Profile.jsp?success=true");

        } catch (Exception e) {
            e.printStackTrace();
            // Redirect to profile page with error flag in case of exception
            response.sendRedirect("Customer_Profile.jsp?error=true");
        }
    }
}
