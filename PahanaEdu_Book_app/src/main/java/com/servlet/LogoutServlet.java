package com.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Destroy the session
        HttpSession session = request.getSession(false); // false = don't create if not exists
        if (session != null) {
            session.invalidate();
        }

        // Redirect to index.jsp
        response.sendRedirect("index.jsp");
    }
}
