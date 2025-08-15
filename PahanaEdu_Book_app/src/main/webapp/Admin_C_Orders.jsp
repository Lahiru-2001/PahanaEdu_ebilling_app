<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*,java.util.*"%>
<%@ page import="com.DB.DBConnecter"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin - Customer Orders Page</title>
<%@include file="all_component/all_css.jsp"%>

</head>

<body>
	<%@include file="all_component/navbar.jsp"%>
	<!-- Include navbar -->

	<!-- Filter Bar: Allows admin to filter orders by date or status -->
	<div class="filter-Orders">
		<input type="date" id="startDate"> <input type="date"
			id="endDate">
		<button class="filter-Btn" id="filterBtn">Filter Orders</button>
		<button class="reset-Btn" id="resetBtn">Reset</button>
		<button class="Processing-Btn" id="showProcessingBtn">Still
			Processing Orders</button>
		<button class="Confirmed-Btn" id="showConfirmedBtn">Confirmed
			Orders</button>
	</div>

	<!-- Processing Orders Section -->
	<div id="processingOrders">
		<%
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = DBConnecter.getConnection();

			// Query to fetch all orders with customer details
			String sql = "SELECT pb.bill_id, pb.total_amount, pb.status, pb.order_date, "
			+ "c.first_name, c.last_name, c.account_number, c.phone_number, c.address " + "FROM processing_bills pb "
			+ "JOIN customers c ON pb.customer_id = c.customer_id " + "ORDER BY pb.order_date DESC";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			List<String> confirmedOrdersHTML = new ArrayList<>(); // Store confirmed orders to display separately

			while (rs.next()) {
				int billId = rs.getInt("bill_id");
				String status = rs.getString("status");
				String customerName = rs.getString("first_name") + " " + rs.getString("last_name");
				String account = rs.getString("account_number");
				String phone = rs.getString("phone_number");
				String address = rs.getString("address");
				java.sql.Timestamp orderDate = rs.getTimestamp("order_date");
				String orderDateStr = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(orderDate);
				String dateAttr = new SimpleDateFormat("yyyy-MM-dd").format(orderDate);
				double totalAmount = rs.getDouble("total_amount");

				// Fetch items for each order
				StringBuilder itemsHTML = new StringBuilder();
				PreparedStatement psItems = conn.prepareStatement(
				"SELECT item_name, category, item_price, quantity, subtotal FROM processing_bill_items WHERE bill_id = ?");
				psItems.setInt(1, billId);
				ResultSet rsItems = psItems.executeQuery();
				while (rsItems.next()) {
			itemsHTML.append("<tr>").append("<td>").append(rsItems.getString("item_name")).append("</td>")
					.append("<td>").append(rsItems.getString("category")).append("</td>").append("<td>Rs:")
					.append(rsItems.getBigDecimal("item_price")).append("</td>").append("<td>")
					.append(rsItems.getInt("quantity")).append("</td>").append("<td>Rs:")
					.append(rsItems.getBigDecimal("subtotal")).append("</td>").append("</tr>");
				}
				rsItems.close();
				psItems.close();

				// Build HTML card for each order
				String cardHTML = "<div class='order-card' data-status='" + status.toLowerCase() + "' data-bill-id='" + billId
				+ "' data-order-date='" + dateAttr + "'>" + "<div class='order-header'><h3>Order #" + billId + " - "
				+ status + "</h3></div>" + "<div class='customer-info'><strong>Customer:</strong> " + customerName
				+ "<br>" + "<strong>Account:</strong> " + account + "<br>" + "<strong>Phone:</strong> " + phone + "<br>"
				+ "<strong>Address:</strong> " + address + "<br>" + "<strong>Order Date:</strong> " + orderDateStr
				+ "</div>"
				+ "<table><thead><tr><th>Item Name</th><th>Category</th><th>Price</th><th>Qty</th><th>Subtotal</th></tr></thead>"
				+ "<tbody>" + itemsHTML + "</tbody></table>" + "<div class='order-footer'><strong>Total: Rs:"
				+ String.format("%.2f", totalAmount) + "</strong><br>";

				if ("processing".equalsIgnoreCase(status)) {
			cardHTML += "<button class='confirm-btn'>Confirm Order</button>"; // Button to confirm order
				}
				cardHTML += "</div></div>";

				// Display processing orders immediately, confirmed orders stored separately
				if ("processing".equalsIgnoreCase(status)) {
			out.print(cardHTML);
				} else {
			confirmedOrdersHTML.add(cardHTML);
				}
			}

			request.setAttribute("confirmedOrdersHTML", confirmedOrdersHTML); // Pass confirmed orders to separate section

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
		%>
	</div>

	<!-- Confirmed Orders Section -->
	<div id="confirmedOrders">
		<%
		List<String> confirmedOrdersHTML = (List<String>) request.getAttribute("confirmedOrdersHTML");
		if (confirmedOrdersHTML != null) {
			for (String html : confirmedOrdersHTML) {
				out.print(html); // Print confirmed order cards
			}
		}
		%>
	</div>

	<%@include file="all_component/footer.jsp"%>
	<!-- Include footer -->

	<script>
// JavaScript to handle order confirmation, filtering, and toggling views
document.addEventListener("DOMContentLoaded", function() {

    // Confirm order button click
    document.querySelectorAll(".confirm-btn").forEach(function(button) {
        button.addEventListener("click", function() {
            let orderCard = this.closest(".order-card");
            let billId = orderCard.getAttribute("data-bill-id");
            if (confirm("Are you sure you want to confirm this order?")) {
                fetch("ConfirmOrderServlet", {
                    method: "POST",
                    headers: { "Content-Type": "application/x-www-form-urlencoded" },
                    body: "bill_id=" + encodeURIComponent(billId)
                }).then(response => {
                    if (response.ok) {
                        alert("Order #" + billId + " confirmed successfully!");
                        this.remove();
                        orderCard.setAttribute("data-status", "confirmed");
                        orderCard.querySelector("h3").textContent = "Order #" + billId + " - Confirmed";
                        document.getElementById("confirmedOrders").prepend(orderCard); // Move card to confirmed section
                    } else { alert("Failed to confirm the order."); }
                });
            }
        });
    });

    // Date filter for orders
    document.getElementById("filterBtn").addEventListener("click", function() {
        let start = document.getElementById("startDate").value;
        let end = document.getElementById("endDate").value;
        document.querySelectorAll(".order-card").forEach(card => {
            let orderDate = card.getAttribute("data-order-date");
            card.style.display = (start && orderDate < start) || (end && orderDate > end) ? "none" : "";
        });
    });

    // Toggle processing orders view
    document.getElementById("showProcessingBtn").addEventListener("click", function() {
        document.getElementById("processingOrders").style.display = "block";
        document.getElementById("confirmedOrders").style.display = "none";
    });

    // Toggle confirmed orders view
    document.getElementById("showConfirmedBtn").addEventListener("click", function() {
        document.getElementById("processingOrders").style.display = "none";
        document.getElementById("confirmedOrders").style.display = "block";
    });

    // Hide confirmed orders by default
    document.getElementById("confirmedOrders").style.display = "none";

    // Reset filters
    document.getElementById("resetBtn").addEventListener("click", function() {
        document.getElementById("startDate").value = "";
        document.getElementById("endDate").value = "";
        document.querySelectorAll(".order-card").forEach(card => card.style.display = "");
    });
});
</script>
</body>
</html>
