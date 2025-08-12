package com.servlet;

import com.entity.CartItem;
import com.DAO.CartImple;
import com.DAO.ItemDAO;
import com.DAO.ItemDAOImple;
import com.DB.DBConnecter;
import com.entity.Item;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int itemId = Integer.parseInt(req.getParameter("item_id"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        try (Connection conn = DBConnecter.getConnection()) {
            ItemDAO itemDAO = new ItemDAOImple(conn);
            Item item = itemDAO.getItemById(itemId); // You need to implement getItemById() in ItemDAOImple

            if (item != null) {
                CartItem cartItem = new CartItem();
                cartItem.setBill_item_id(item.getItem_id());
                cartItem.setName(item.getName());
                cartItem.setCategory(item.getCategory());
                cartItem.setPrice(item.getPrice());
                cartItem.setQuantity(quantity);
                cartItem.setSubtotal(item.getPrice().multiply(BigDecimal.valueOf(quantity)));

                HttpSession session = req.getSession();
                CartImple cart = (CartImple) session.getAttribute("cart");
                if (cart == null) {
                    cart = new CartImple();
                }
                cart.addItem(cartItem);
                session.setAttribute("cart", cart);
                session.setAttribute("message", "Item Add into the Cart Success");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        resp.sendRedirect("Customer_All_items.jsp");
    }
}
