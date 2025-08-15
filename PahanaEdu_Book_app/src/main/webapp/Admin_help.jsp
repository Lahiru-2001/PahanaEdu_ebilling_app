<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.DB.DBConnecter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - View Help Messages Page</title>
<%@ include file="all_component/all_css.jsp"%>

</head>
<body>
	<%@ include file="all_component/navbar.jsp"%>

	<div class="container_help">
		<h2>Help Messages</h2>

		<!-- Display optional success message passed via URL parameter -->
		<%
		String msg = request.getParameter("msg");
		if (msg != null && !msg.trim().isEmpty()) {
		%>
		<div style="color: green; font-weight: bold; margin-bottom: 10px;"><%=msg%></div>
		<%
		}
		%>

		<!-- Filter form to select messages by date -->
		<form method="get" class="filter-bar">
			<label> Filter by Date: <input type="date" name="date"
				value="<%=request.getParameter("date") != null ? request.getParameter("date") : ""%>">
			</label>
			<button type="submit" class="btn btn-view">Filter</button>
		</form>

		<!-- Help Messages Table -->
		<table>
			<thead>
				<tr>
					<th>Customer Name</th>
					<th>Account No</th>
					<th>Address</th>
					<th>Phone</th>
					<th>Help Title</th>
					<th>Message</th>
					<th>Date</th>
					<th>Status</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody id="helpTableBody">
				<%
				Connection conn = null;
				PreparedStatement ps = null;
				ResultSet rs = null;
				try {
					conn = DBConnecter.getConnection();

					// Build SQL query to fetch help messages, optionally filtered by date
					String filterDate = request.getParameter("date");
					String sql = "SELECT c.customer_id, c.first_name, c.last_name, c.account_number, c.address, c.phone_number, "
					+ "h.title, h.content, h.created_at, h.help_id, h.status " + "FROM help h "
					+ "INNER JOIN customers c ON h.customer_id = c.customer_id ";

					if (filterDate != null && !filterDate.trim().isEmpty()) {
						sql += "WHERE DATE(h.created_at) = ? ";
					}

					// Sort: unread messages first, then by most recent date
					sql += "ORDER BY (CASE WHEN h.status = 'unread' THEN 0 ELSE 1 END), h.created_at DESC";

					ps = conn.prepareStatement(sql);

					if (filterDate != null && !filterDate.trim().isEmpty()) {
						ps.setString(1, filterDate);
					}

					rs = ps.executeQuery();

					boolean hasRows = false;
					while (rs.next()) {
						hasRows = true;
						String fullName = rs.getString("first_name") + " " + rs.getString("last_name");
						String accountNo = rs.getString("account_number");
						String address = rs.getString("address");
						String phone = rs.getString("phone_number");
						String title = rs.getString("title");
						String message = rs.getString("content");
						String date = rs.getString("created_at");
						String status = rs.getString("status");
						int helpId = rs.getInt("help_id");
						int customerId = rs.getInt("customer_id");
				%>
				<tr>
					<td><%=fullName%></td>
					<td><%=accountNo%></td>
					<td><%=address%></td>
					<td><%=phone%></td>
					<td><%=title%></td>
					<td><%=message%></td>
					<td><%=date%></td>

					<!-- Status column with different class for unread/read -->
					<td
						class="<%="unread".equalsIgnoreCase(status) ? "status-unread" : "status-read"%>">
						<%=status%>
					</td>

					<!-- Actions: Reply (only if unread) and Delete -->
					<td>
						<%
						if ("unread".equalsIgnoreCase(status)) {
						%>
						<button class="btn btn-view"
							onclick="openModal(<%=helpId%>, <%=customerId%>)">Reply</button>
						<%
						} else {
						%> <span style="color: gray;">Replied</span> <%
 }
 %>
						<button class="btn btn-delete"
							onclick="deleteMessage('<%=helpId%>')">Delete</button>
					</td>
				</tr>
				<%
				}

				// If no help messages found, show placeholder row
				if (!hasRows) {
				%>
				<tr>
					<td colspan="9" class="text-center text-muted">No items found.</td>
				</tr>
				<%
				}
				} catch (Exception e) {
				e.printStackTrace();
				} finally {
				if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
				}
				if (ps != null)
				try {
					ps.close();
				} catch (Exception e) {
				}
				if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
				}
				}
				%>
			</tbody>
		</table>
	</div>

	<!-- Reply Modal -->
	<div id="replyModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal()">&times;</span>
			<h3>Reply to Customer</h3>
			<textarea id="replyMessage" placeholder="Type your reply..."></textarea>
			<button class="btn-send" onclick="sendReply()">Send</button>
		</div>
	</div>

	<br>
	<br>
	<br>
	<br>
	<%@ include file="all_component/footer.jsp"%>

	<script>
    let currentHelpId = null;
    let currentCustomerId = null;

    // Open modal and store current help/customer IDs
    function openModal(helpId, customerId) {
        currentHelpId = helpId;
        currentCustomerId = customerId;
        document.getElementById('replyModal').style.display = 'block';
    }

    // Close modal and reset values
    function closeModal() {
        document.getElementById('replyModal').style.display = 'none';
        document.getElementById('replyMessage').value = '';
        currentHelpId = null;
        currentCustomerId = null;
    }

    // Send reply using fetch API to servlet
    function sendReply() {
        const replyText = document.getElementById('replyMessage').value.trim();
        if (!replyText) {
            alert("Please type a reply before sending.");
            return;
        }

        fetch("SaveHelpResponseServlet", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: `helpId=${currentHelpId}&customerId=${currentCustomerId}&message=${encodeURIComponent(replyText)}`
        })
        .then(response => response.text())
        .then(data => {
            alert(data);
            location.reload(); // Reload table after reply
            closeModal();
        })
        .catch(err => {
            console.error(err);
            alert("Error sending reply");
        });
    }

    // Delete a help message
    function deleteMessage(helpId) {
        if (confirm(`Are you sure you want to delete this message?`)) {
            window.location.href = "DeleteHelpServlet?helpId=" + helpId;
        }
    }
</script>
</body>
</html>
