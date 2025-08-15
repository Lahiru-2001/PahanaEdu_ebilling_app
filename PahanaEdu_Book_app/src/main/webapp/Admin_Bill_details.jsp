<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*,java.util.*"%>
<%@ page import="com.DB.DBConnecter"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin - Payment Reports Page</title>
<%@include file="all_component/all_css.jsp"%>

</head>
<body>
	<%@include file="all_component/navbar.jsp"%>
	<!-- Include navbar -->

	<br>
	<div class="report-container">
		<h2>Payment Reports</h2>

		<!-- Filter Form: Admin can filter payments by start and end date -->
		<form class="filter-form" method="get" action="">
			<label for="startDate">From:</label> <input type="date"
				id="startDate" name="startDate"
				value="<%=request.getParameter("startDate") != null ? request.getParameter("startDate") : ""%>">
			<label for="endDate">To:</label> <input type="date" id="endDate"
				name="endDate"
				value="<%=request.getParameter("endDate") != null ? request.getParameter("endDate") : ""%>">
			<button type="submit">Filter</button>
			<button type="button" id="resetBtn">Reset</button>
			<!-- Reset button to reload page without filters -->
		</form>

		<%
		// Retrieve filter values from request parameters
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		boolean filterApplied = (startDate != null && endDate != null && !startDate.isEmpty() && !endDate.isEmpty());
		%>

		<!-- Summary Section: Display total orders and total amount -->
		<div class="summary">
			<div>
				<h3>Total Orders</h3>
				<p>
					<%
					int totalOrders = 0;
					try (Connection con = DBConnecter.getConnection()) {
						String countSQL = "SELECT COUNT(*) AS total_orders FROM processing_bills WHERE status = 'Orders Confirm'";
						if (filterApplied) { // Apply date filter if provided
							countSQL += " AND DATE(order_date) BETWEEN ? AND ?";
						}
						try (PreparedStatement ps = con.prepareStatement(countSQL)) {
							if (filterApplied) {
						ps.setString(1, startDate);
						ps.setString(2, endDate);
							}
							try (ResultSet rs = ps.executeQuery()) {
						if (rs.next())
							totalOrders = rs.getInt("total_orders"); // Get total orders
							}
						}
					}
					out.print(totalOrders);
					%>
				</p>
			</div>
			<div>
				<h3>Total Amount</h3>
				<p>
					<%
					double totalAmount = 0;
					try (Connection con = DBConnecter.getConnection()) {
						String sumSQL = "SELECT SUM(total_amount) AS total_amount FROM processing_bills WHERE status = 'Orders Confirm'";
						if (filterApplied) { // Apply date filter if provided
							sumSQL += " AND DATE(order_date) BETWEEN ? AND ?";
						}
						try (PreparedStatement ps = con.prepareStatement(sumSQL)) {
							if (filterApplied) {
						ps.setString(1, startDate);
						ps.setString(2, endDate);
							}
							try (ResultSet rs = ps.executeQuery()) {
						if (rs.next())
							totalAmount = rs.getDouble("total_amount"); // Get total payment amount
							}
						}
					}
					out.print("Rs:" + String.format("%.2f", totalAmount));
					%>
				</p>
			</div>
		</div>

		<!-- Report Table: List all confirmed orders with details -->
		<table id="reportTable">
			<thead>
				<tr>
					<th>Bill ID</th>
					<th>Customer Name</th>
					<th>Account Number</th>
					<th>Total Amount</th>
					<th>Status</th>
					<th>Order Date</th>
				</tr>
			</thead>
			<tbody>
				<%
				try (Connection con = DBConnecter.getConnection()) {
					String sql = "SELECT b.bill_id, c.first_name, c.last_name, c.account_number, b.total_amount, b.status, b.order_date "
					+ "FROM processing_bills b " + "JOIN customers c ON b.customer_id = c.customer_id "
					+ "WHERE b.status = 'Orders Confirm'";
					if (filterApplied) {
						sql += " AND DATE(b.order_date) BETWEEN ? AND ?";
					}
					sql += " ORDER BY b.order_date DESC"; // Show latest orders first
					try (PreparedStatement ps = con.prepareStatement(sql)) {
						if (filterApplied) {
					ps.setString(1, startDate);
					ps.setString(2, endDate);
						}
						try (ResultSet rs = ps.executeQuery()) {
					while (rs.next()) {
						int billId = rs.getInt("bill_id");
						String customerName = rs.getString("first_name") + " " + rs.getString("last_name");
						String accountNumber = rs.getString("account_number");
						double amount = rs.getDouble("total_amount");
						String status = rs.getString("status");
						Timestamp orderDate = rs.getTimestamp("order_date");
				%>
				<tr>
					<td><%=billId%></td>
					<td><%=customerName%></td>
					<td><%=accountNumber%></td>
					<td>Rs:<%=String.format("%.2f", amount)%></td>
					<td><%=status%></td>
					<td><%=orderDate%></td>
				</tr>
				<%
				}
				}
				}
				}
				%>
			</tbody>
		</table>
	</div>

	<%@include file="all_component/footer.jsp"%>
	<!-- Include footer -->

	<!-- Reset filter functionality -->
	<script>
		document.getElementById("resetBtn").addEventListener("click",
				function() {
					window.location.href = window.location.pathname; // Reload page without query parameters to remove filters
				});
	</script>
</body>
</html>
