<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%@ page import="com.DB.DBConnecter"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>My Orders</title>
<%@include file="all_component/all_css.jsp"%>
<style>
body {
	font-family: "Segoe UI", Tahoma, sans-serif;
	background: #f2f4f7;
	margin: 0;
	padding: 0;
	color: #333;
}

h2 {
	margin-bottom: 20px;
	color: #2563eb;
	font-size: 24px;
	border-bottom: 2px solid #cbd5e1;
	padding-top: 20px;
	margin-left: 90px;
}

.order-card {
	background: #ffffff;
	border-radius: 12px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.06);
	margin-bottom: 100px;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	padding: 40px 20px;
	max-width: 1200px;
	margin: 30px;
margin-left: 90px;
	
	
}

.order-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	border-bottom: 1px solid #e5e7eb;
	padding-bottom: 10px;
	margin-bottom: 18px;
	font-size: 16px;
	font-weight: 600;
	color: #1e293b;
}

.items-table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 12px;
}

.items-table th, .items-table td {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid #e2e8f0;
	font-size: 15px;
}

.items-table th {
	background-color: #f1f5f9;
	color: #1e293b;
	font-weight: 600;
}

.total {
	text-align: right;
	font-weight: 600;
	margin-top: 15px;
	font-size: 16px;
	color: #111827;
	border-top: 1px solid #e5e7eb;
	padding-top: 10px;
}

@media ( max-width :768px) {
	.order-header {
		flex-direction: column;
		align-items: flex-start;
		gap: 5px;
	}
	.items-table th, .items-table td {
		font-size: 14px;
		padding: 8px;
	}
	.total {
		font-size: 15px;
	}
}
</style>
</head>
<body>
	<%@include file="all_component/navbar.jsp"%>

	<div class="card-shadow">
		<div class="card-body">

			<%
			Connection con = null;
			PreparedStatement psBill = null, psItems = null;
			ResultSet rsBill = null, rsItems = null;

			// Map to store statuses we want to show
			String[] statuses = { "Orders Confirm", "processing" };

			try {
				con = DBConnecter.getConnection();

				for (String status : statuses) {
			%>
			<div class="orders-section">
				<h2><%=status%></h2>

				<%
				// Fetch all bills with the current status
				psBill = con.prepareStatement(
						"SELECT * FROM processing_bills pb JOIN customers c ON pb.customer_id=c.customer_id WHERE pb.status=? ORDER BY pb.order_date DESC");
				psBill.setString(1, status.equals("Orders Confirm") ? "Orders Confirm" : "processing");
				rsBill = psBill.executeQuery();

				while (rsBill.next()) {
					int billId = rsBill.getInt("bill_id");
					Timestamp orderDate = rsBill.getTimestamp("order_date");
				%>
				<div class="order-card">
					<div class="order-header">
						<span>Order #<%=billId%></span> <span>Date: <%=orderDate.toString().substring(0, 10)%></span>
					</div>
					<table class="items-table">
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
							// Fetch items for this bill
							psItems = con.prepareStatement("SELECT * FROM processing_bill_items WHERE bill_id=?");
							psItems.setInt(1, billId);
							rsItems = psItems.executeQuery();

							double total = 0;

							while (rsItems.next()) {
								String itemName = rsItems.getString("item_name");
								String category = rsItems.getString("category");
								double price = rsItems.getDouble("item_price");
								int qty = rsItems.getInt("quantity");
								double subtotal = rsItems.getDouble("subtotal");
								total += subtotal;
							%>
							<tr>
								<td><%=itemName%></td>
								<td><%=category%></td>
								<td>Rs:<%=String.format("%.2f", price)%></td>
								<td><%=qty%></td>
								<td>Rs:<%=String.format("%.2f", subtotal)%></td>
							</tr>
							<%
							} // items loop
							%>
						</tbody>
					</table>
					<div class="total">
						Total: Rs:<%=String.format("%.2f", total)%></div>
				</div>
				<%
				} // bills loop
				%>
			</div>
			<%
			} // statuses loop
			} catch (Exception e) {
			out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
			e.printStackTrace();
			} finally {
			try {
			if (rsItems != null)
				rsItems.close();
			} catch (Exception e) {
			}
			try {
			if (psItems != null)
				psItems.close();
			} catch (Exception e) {
			}
			try {
			if (rsBill != null)
				rsBill.close();
			} catch (Exception e) {
			}
			try {
			if (psBill != null)
				psBill.close();
			} catch (Exception e) {
			}
			try {
			if (con != null)
				con.close();
			} catch (Exception e) {
			}
			}
			%>

		</div>
	</div>

	<%@include file="all_component/footer.jsp"%>
</body>
</html>
