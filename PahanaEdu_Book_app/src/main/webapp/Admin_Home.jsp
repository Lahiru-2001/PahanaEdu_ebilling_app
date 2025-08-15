<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*,java.time.*,java.time.format.DateTimeFormatter"%>
<%@ page import="com.DB.DBConnecter"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>

<!DOCTYPE html>
<html>
<%@include file="all_component/all_css.jsp"%>

<!-- Check if user is not admin and redirect to login page -->
<c:if test="${sessionScope.role != 'admin'}">
	<c:redirect url="Login.jsp" />
</c:if>

<head>
<meta charset="UTF-8">
<title>Admin - Home Page</title>
</head>

<body data-topbar="colored" data-layout="horizontal">

	<!-- Include navigation bar -->
	<%@include file="all_component/navbar.jsp"%>

	<div class="container-home">
		<div class="dashboard-cards">

			<!-- Total Orders Card -->
			<div class="card-dashboard">
				<div class="card-icon">
					<i class="ri-shopping-basket-2-line"></i>
				</div>
				<h3>Total Orders</h3>
				<p>
					<%
					int totalOrders = 0;
					try (Connection con = DBConnecter.getConnection()) {
						// Count total orders with status "Orders Confirm"
						String sql = "SELECT COUNT(*) AS cnt FROM processing_bills WHERE status='Orders Confirm'";
						try (PreparedStatement ps = con.prepareStatement(sql)) {
							try (ResultSet rs = ps.executeQuery()) {
						if (rs.next())
							totalOrders = rs.getInt("cnt");
							}
						}
					}
					// Display total orders on dashboard
					out.print(totalOrders);
					%>
				</p>
			</div>

			<!-- Month Earned Card -->
			<div class="card-dashboard">
				<div class="card-icon">
					<i class="ri-money-dollar-circle-line"></i>
				</div>
				<h3>Month Earned</h3>
				<p>
					<%
					double monthEarnings = 0.0;
					try (Connection con = DBConnecter.getConnection()) {
						// Get current month start and end dates
						LocalDate now = LocalDate.now();
						String firstDay = now.withDayOfMonth(1).toString();
						String lastDay = now.withDayOfMonth(now.lengthOfMonth()).toString();

						// Sum total earnings for orders confirmed in current month
						String sql = "SELECT SUM(total_amount) AS total FROM processing_bills "
						+ "WHERE status='Orders Confirm' AND DATE(order_date) BETWEEN ? AND ?";
						try (PreparedStatement ps = con.prepareStatement(sql)) {
							ps.setString(1, firstDay);
							ps.setString(2, lastDay);
							try (ResultSet rs = ps.executeQuery()) {
						if (rs.next())
							monthEarnings = rs.getDouble("total");
							}
						}
					}
					out.print("Rs:" + String.format("%.2f", monthEarnings));
					%>
				</p>
			</div>

			<!-- Processing Orders Card -->
			<div class="card-dashboard">
				<div class="card-icon">
					<i class="ri-time-line"></i>
				</div>
				<h3>Processing Orders</h3>
				<p>
					<%
					int processingOrders = 0;
					try (Connection con = DBConnecter.getConnection()) {
						// Count orders with status "processing"
						String sql = "SELECT COUNT(*) AS cnt FROM processing_bills WHERE status='processing'";
						try (PreparedStatement ps = con.prepareStatement(sql)) {
							try (ResultSet rs = ps.executeQuery()) {
						if (rs.next())
							processingOrders = rs.getInt("cnt");
							}
						}
					}
					out.print(processingOrders);
					%>
				</p>
			</div>

		</div>

		<!-- Summary Table -->
		<table class="summary-table">
			<thead>
				<tr>
					<th>Metric</th>
					<th>Value</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>Total Orders</td>
					<td><%=totalOrders%></td>
				</tr>
				<tr>
					<td>Processing Orders</td>
					<td><%=processingOrders%></td>
				</tr>
				<tr>
					<td>Completed Orders</td>
					<td>
						<%
						int completedOrders = 0;
						try (Connection con = DBConnecter.getConnection()) {
							// Count orders that are completed ("Orders Confirm")
							String sql = "SELECT COUNT(*) AS cnt FROM processing_bills WHERE status='Orders Confirm'";
							try (PreparedStatement ps = con.prepareStatement(sql)) {
								try (ResultSet rs = ps.executeQuery()) {
							if (rs.next())
								completedOrders = rs.getInt("cnt");
								}
							}
						}
						out.print(completedOrders);
						%>
					</td>
				</tr>
				<tr>
					<td>Monthly Earnings</td>
					<td>Rs:<%=String.format("%.2f", monthEarnings)%></td>
				</tr>
				<tr>
					<td>Total Earnings</td>
					<td>
						<%
						double totalEarnings = 0.0;
						try (Connection con = DBConnecter.getConnection()) {
							// Sum total earnings for all completed orders
							String sql = "SELECT SUM(total_amount) AS total FROM processing_bills WHERE status='Orders Confirm'";
							try (PreparedStatement ps = con.prepareStatement(sql)) {
								try (ResultSet rs = ps.executeQuery()) {
							if (rs.next())
								totalEarnings = rs.getDouble("total");
								}
							}
						}
						out.print("Rs:" + String.format("%.2f", totalEarnings));
						%>
					</td>
				</tr>
			</tbody>
		</table>

	</div>

	<!-- Include footer -->
	<%@include file="all_component/footer.jsp"%>
</body>
</html>
