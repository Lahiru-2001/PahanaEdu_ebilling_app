package com.servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.DAO.UserDAO;
import com.DAO.UserDAOImple;
import com.DB.DBConnecter;
import com.DAO.CustomerDAO;
import com.DAO.CustomerDAOImple;
import com.entity.User;
import com.entity.Customer;

@WebServlet("/usrs_login")
public class Login_servlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password"); // plain

        if (username == null || username.isBlank() || password == null || password.length() < 4) {
            req.setAttribute("loginError",
                    "Username and password are required. Password must be at least 4 characters.");
            req.getRequestDispatcher("Login.jsp").forward(req, resp);
            return;
        }

        try (Connection con = DBConnecter.getConnection()) {
            UserDAO userDao = new UserDAOImple(con);
            User user = userDao.login(username, password);
            if (user == null) {
                req.setAttribute("loginError", "Invalid username or password.");
                req.getRequestDispatcher("Login.jsp").forward(req, resp);
                return;
            }

            String role = user.getRole();
            HttpSession session = req.getSession(true);
            session.setAttribute("loggedUser", user);
            session.setAttribute("role", role != null ? role.toLowerCase() : "");

            if ("customer".equalsIgnoreCase(role)) {
                CustomerDAO custDao = new CustomerDAOImple(con);
                Customer customer = custDao.getCustomerByUserId(user.getUser_id());
                if (customer != null) {
                    session.setAttribute("customer", customer);
                    session.setAttribute("firstName", customer.getFirst_Name());
                    session.setAttribute("lastName", customer.getLast_Name());
                    session.setAttribute("accountNumber", customer.getAccount_Number());
                    session.setAttribute("customerId", customer.getCustomer_Id());
                }
                resp.sendRedirect("Customer_Home.jsp");
            } else if ("admin".equalsIgnoreCase(role)) {
                resp.sendRedirect("Admin_Home.jsp");
            } else {
                req.setAttribute("loginError", "User role is unrecognized.");
                req.getRequestDispatcher("Login.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("loginError", "An internal error occurred. Please try again later.");
            req.getRequestDispatcher("Login.jsp").forward(req, resp);
        }
    }
}
