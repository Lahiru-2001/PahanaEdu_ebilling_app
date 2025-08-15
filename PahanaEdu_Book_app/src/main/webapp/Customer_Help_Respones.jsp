<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.DB.DBConnecter"%>
<%@ page import="com.entity.Customer"%>

<%
// Get the logged-in customer from session
Customer customer = (Customer) session.getAttribute("customer");
if (customer == null) {
	// Redirect to login page if no customer is logged in
	response.sendRedirect("login.jsp");
	return;
}
int customerId = customer.getCustomer_Id();

Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
	conn = DBConnecter.getConnection();

	// Fetch all help messages from the customer along with any admin replies
	String sql = "SELECT h.help_id, h.title, h.content, h.status AS help_status, "
	+ "hr.help_res_id, hr.response_ms, hr.status AS resp_status "
	+ "FROM help h LEFT JOIN help_response hr ON h.help_id = hr.help_id "
	+ "WHERE h.customer_id = ? ORDER BY h.created_at DESC";
	ps = conn.prepareStatement(sql);
	ps.setInt(1, customerId);
	rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer - Help Responses Page</title>

<%@ include file="all_component/all_css.jsp"%>

<style>
/* Page styling */
body {
	background-color: #f9f9f9;
	font-family: Arial, sans-serif;
}

.container {
	margin: 30px auto;
	padding: 20px;
}

/* Individual help message card */
.help-card {
	background: #fff;
	border-radius: 10px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	padding: 20px;
	margin-bottom: 20px;
}

.help-title {
	font-size: 20px;
	font-weight: bold;
	color: #333;
	margin-bottom: 10px;
}

.help-content {
	font-size: 15px;
	color: #555;
	margin-bottom: 15px;
}

/* Admin response styling */
.response {
	background: #f1f1f1;
	padding: 15px;
	border-radius: 8px;
	margin-bottom: 15px;
	font-size: 14px;
	color: #444;
}

/* Buttons */
.btn {
	padding: 5px 12px;
	border-radius: 5px;
	border: none;
	cursor: pointer;
}

.btn-reply {
	background-color: #007bff;
	color: white;
}

.btn-delete {
	background-color: #dc3545;
	color: white;
}
</style>
</head>

<body>
	<!-- Navbar inclusion -->
	<%@ include file="all_component/navbar.jsp"%>

	<div class="container">
		<h2>Messages Responses</h2>
		<%
		boolean hasMessages = false;

		// Loop through all help messages
		while (rs.next()) {
			hasMessages = true;
		%>
		<div class="help-card">
			<!-- Help message title -->
			<div class="help-title"><%=rs.getString("title")%></div>
			<!-- Help message content -->
			<div class="help-content"><%=rs.getString("content")%></div>

			<%
			if (rs.getString("response_ms") != null) {
			%>
			<!-- Display admin reply if exists -->
			<div class="response">
				<strong>Admin Reply:</strong><br>
				<%=rs.getString("response_ms")%>
			</div>
			<%
			} else {
			%>
			<!-- If no admin reply yet -->
			<div class="response" style="background: #fff3cd; color: #856404;">
				No reply from admin yet.</div>
			<%
			}
			%>

			<!-- Reply Button (mark as read or follow up) -->
			<form action="MarkHelpAsReadServlet" method="post"
				style="display: inline;">
				<input type="hidden" name="help_id"
					value="<%=rs.getInt("help_id")%>"> <input type="hidden"
					name="help_res_id" value="<%=rs.getInt("help_res_id")%>">
				<button type="submit" class="btn btn-reply">Reply</button>
			</form>

			<!-- Delete Button to remove help message -->
			<form action="DeleteHelpResponseServlet" method="post"
				style="display: inline;"
				onsubmit="return confirm('Are you sure you want to delete this help message?');">
				<input type="hidden" name="help_id"
					value="<%=rs.getInt("help_id")%>">
				<button type="submit" class="btn btn-delete">Delete</button>
			</form>
		</div>
		<%
		}
		%>

		<%
		if (!hasMessages) {
		%>
		<!-- Message when no help messages are found -->
		<p>No help messages found.</p>
		<%
		}
		%>
	</div>

	<br>
	<br>
	<br>
	<!-- Footer inclusion -->
	<%@ include file="all_component/footer.jsp"%>
</body>
</html>

<%
} catch (Exception e) {
e.printStackTrace();
} finally {
// Close resources to avoid memory leaks
if (rs != null)
	try {
		rs.close();
	} catch (SQLException ignore) {
	}
if (ps != null)
	try {
		ps.close();
	} catch (SQLException ignore) {
	}
if (conn != null)
	try {
		conn.close();
	} catch (SQLException ignore) {
	}
}
%>
