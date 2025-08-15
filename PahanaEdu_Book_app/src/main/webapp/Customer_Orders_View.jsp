<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%@ page import="com.DB.DBConnecter"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Customer-Oders View Page</title>


<%@include file="all_component/all_css.jsp"%>

<style>
    /* Styling for message when no orders are found */
    .no-orders {
        color: red;
        text-align: center;
        font-weight: bold;
        padding: 10px;
    }
</style>
</head>
<body>

<!-- Include navigation bar -->
<%@include file="all_component/navbar.jsp"%>

<div class="card-shadow">
	<div class="card-body">

		<%
		// Database connection and statement/result objects
		Connection con = null;
		PreparedStatement psBill = null, psItems = null;
		ResultSet rsBill = null, rsItems = null;

		// Retrieve logged-in customer's ID from session
		Integer customerId = (Integer) session.getAttribute("customerId");

		// If user is not logged in, show message and stop execution
		if (customerId == null) {
			out.println("<p style='color:red;'>You must be logged in to view your orders.</p>");
			return;
		}

		// Define order statuses to display
		String[] statuses = { "Orders Confirm", "processing" };

		try {
			// Get DB connection
			con = DBConnecter.getConnection();

			// Loop through each status and display orders for that status
			for (String status : statuses) {
		%>
		<div class="orders-section">
			<!-- Display status heading -->
			<h2 class="order-h2"><%=status%></h2>

			<%
			// Query to retrieve bills/orders for the logged-in customer with the current status
			psBill = con.prepareStatement(
				"SELECT * FROM processing_bills pb " +
				"JOIN customers c ON pb.customer_id = c.customer_id " +
				"WHERE pb.status = ? AND pb.customer_id = ? " +
				"ORDER BY pb.order_date DESC"
			);
			psBill.setString(1, status);
			psBill.setInt(2, customerId);
			rsBill = psBill.executeQuery();

			boolean hasOrders = false; // Track if there are any orders for this status

			// Loop through each bill/order
			while (rsBill.next()) {
				hasOrders = true;
				int billId = rsBill.getInt("bill_id");
				Timestamp orderDate = rsBill.getTimestamp("order_date");
			%>
			<!-- Single Order Card -->
			<div class="order-card">
				<div class="order-header">
					<!-- Order number and status -->
					<span>Order #<%=billId%> / <%=status%></span>
					<!-- Order date -->
					<span>Date: <%=orderDate.toString().substring(0, 10)%></span>
				</div>

				<!-- Items table for this order -->
				<table class="items-table-order">
					<thead>
						<tr>
							<th>Item Name</th>
							<th>Category</th>
							<th>Price</th>
							<th>Quantity</th>
							<th>Subtotal</th>
						</tr>
					</thead>
					<tbody>
						<%
						// Retrieve all items for this bill
						psItems = con.prepareStatement(
							"SELECT * FROM processing_bill_items WHERE bill_id = ?"
						);
						psItems.setInt(1, billId);
						rsItems = psItems.executeQuery();

						double total = 0; // Track total amount for this order

						// Loop through each item in the order
						while (rsItems.next()) {
							String itemName = rsItems.getString("item_name");
							String category = rsItems.getString("category");
							double price = rsItems.getDouble("item_price");
							int qty = rsItems.getInt("quantity");
							double subtotal = rsItems.getDouble("subtotal");
							total += subtotal; // Add to total
						%>
						<tr>
							<td><%=itemName%></td>
							<td><%=category%></td>
							<td>Rs:<%=String.format("%.2f", price)%></td>
							<td><%=qty%></td>
							<td>Rs:<%=String.format("%.2f", subtotal)%></td>
						</tr>
						<%
						} // End items loop
						%>
					</tbody>
				</table>

				<!-- Display total amount for this order -->
				<div class="total">
					Total: Rs:<%=String.format("%.2f", total)%>
				</div>
			</div>
			<%
			} // End bills loop

			// If no orders found for this status, show message
			if (!hasOrders) {
				out.println("<p class='no-orders'>Not found</p>");
			}
			%>
		</div>
		<%
		} // End statuses loop
		} catch (Exception e) {
			// Handle errors
			out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
			e.printStackTrace();
		} finally {
			// Close all resources
			try { if (rsItems != null) rsItems.close(); } catch (Exception e) {}
			try { if (psItems != null) psItems.close(); } catch (Exception e) {}
			try { if (rsBill != null) rsBill.close(); } catch (Exception e) {}
			try { if (psBill != null) psBill.close(); } catch (Exception e) {}
			try { if (con != null) con.close(); } catch (Exception e) {}
		}
		%>

	</div>
</div>

<!-- Include footer -->
<%@include file="all_component/footer.jsp"%>
</body>
</html>
