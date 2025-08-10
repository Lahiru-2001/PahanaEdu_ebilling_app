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

@WebServlet("/UpdateCustomerProfileServlet")
public class UpdateCustomerProfileServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int userId = (int) request.getSession().getAttribute("user_id");
		String username = request.getParameter("username");
		String password = request.getParameter("password"); // plain password
		String account = request.getParameter("account_number"); // Not updated here
		String fname = request.getParameter("first_name");
		String lname = request.getParameter("last_name");
		String phone = request.getParameter("phone_number");
		String address = request.getParameter("address");

		try (Connection conn = DBConnecter.getConnection()) {

			// Hash the new password
			String hashedPassword = PasswordUtil.hashPassword(password);

			// Update user table
			PreparedStatement psUser = conn
					.prepareStatement("UPDATE users SET username=?, password_hash=? WHERE user_id=?");
			psUser.setString(1, username);
			psUser.setString(2, hashedPassword);
			psUser.setInt(3, userId);
			psUser.executeUpdate();

			// Update customer table
			PreparedStatement psCustomer = conn.prepareStatement(
					"UPDATE customers SET first_name=?, last_name=?, address=?, phone_number=? WHERE user_id=?");
			psCustomer.setString(1, fname);
			psCustomer.setString(2, lname);
			psCustomer.setString(3, address);
			psCustomer.setString(4, phone);
			psCustomer.setInt(5, userId);
			psCustomer.executeUpdate();

			response.sendRedirect("Customer_Profile.jsp?success=true");

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("Customer_Profile.jsp?error=true");
		}
	}
}
