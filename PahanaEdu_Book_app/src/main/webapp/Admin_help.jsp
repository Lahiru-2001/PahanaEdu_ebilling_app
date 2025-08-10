<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.DB.DBConnecter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - View Help Messages</title>
<%@ include file="all_component/all_css.jsp"%>
<style>
/* Container styling */
.container {
    max-width: 1200px;
    margin: 30px auto;
    padding: 20px;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}
table {
    width: 100%;
    border-collapse: collapse;
}
table th, table td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}
table th {
    background-color: #f4f4f4;
}
.btn {
    padding: 6px 12px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}
.btn-view {
    background-color: #3498db;
    color: white;
}
.btn-delete {
    background-color: #e74c3c;
    color: white;
}
.filter-bar {
    display: flex;
    justify-content: space-between;
    margin-bottom: 15px;
}
.filter-bar input[type="date"] {
    padding: 6px;
    border: 1px solid #ccc;
    border-radius: 4px;
}
.modal {
    display: none;
    position: fixed;
    z-index: 999;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
}
.modal-content {
    background: white;
    margin: 10% auto;
    padding: 20px;
    border-radius: 8px;
    width: 400px;
    position: relative;
}
.close {
    position: absolute;
    top: 10px;
    right: 15px;
    font-size: 18px;
    cursor: pointer;
}
textarea {
    width: 100%;
    height: 100px;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
    margin-bottom: 10px;
}
.btn-send {
    background-color: #27ae60;
    color: white;
    padding: 8px 16px;
    border: none;
    border-radius: 4px;
}
</style>
</head>
<body>
    <%@ include file="all_component/navbar.jsp"%>

    <div class="container">
        <h2>Help Messages</h2>

        <%
            String msg = request.getParameter("msg");
            if (msg != null && !msg.trim().isEmpty()) {
        %>
            <div style="color: green; font-weight: bold; margin-bottom: 10px;"><%= msg %></div>
        <%
            }
        %>

        <!-- Date Filter Form -->
        <form method="get" class="filter-bar">
            <label> Filter by Date: <input type="date" name="date"
                value="<%=request.getParameter("date") != null ? request.getParameter("date") : ""%>">
            </label>
            <button type="submit" class="btn btn-view">Filter</button>
        </form>

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

        String filterDate = request.getParameter("date");
        String sql = "SELECT c.customer_id, c.first_name, c.last_name, c.account_number, c.address, c.phone_number, "
                + "h.title, h.content, h.created_at, h.help_id "
                + "FROM help h "
                + "INNER JOIN customers c ON h.customer_id = c.customer_id ";

        if (filterDate != null && !filterDate.trim().isEmpty()) {
            sql += "WHERE DATE(h.created_at) = ? ";
        }

        sql += "ORDER BY h.created_at DESC";

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
            int helpId = rs.getInt("help_id");
            int customerId = rs.getInt("customer_id");
    %>
        <tr>
            <td><%= fullName %></td>
            <td><%= accountNo %></td>
            <td><%= address %></td>
            <td><%= phone %></td>
            <td><%= title %></td>
            <td><%= message %></td>
            <td><%= date %></td>
            <td>
                <button class="btn btn-view" onclick="openModal(<%= helpId %>, <%= customerId %>)">Reply</button>
                <button class="btn btn-delete" onclick="deleteMessage('<%= helpId %>')">Delete</button>
            </td>
        </tr>
    <%
        }
        if (!hasRows) {
    %>
        <tr>
            <td colspan="8" class="text-center text-muted">No items found.</td>
        </tr>
    <%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (ps != null) try { ps.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
    %>
</tbody>
        </table>
    </div>

    <!-- Modal -->
    <div id="replyModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h3>Reply to Customer</h3>
            <textarea id="replyMessage" placeholder="Type your reply..."></textarea>
            <button class="btn-send" onclick="sendReply()">Send</button>
        </div>
    </div>

    <%@ include file="all_component/footer.jsp"%>

    <script>
        let currentHelpId = null;
        let currentCustomerId = null;

        function openModal(helpId, customerId) {
            currentHelpId = helpId;
            currentCustomerId = customerId;
            document.getElementById('replyModal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('replyModal').style.display = 'none';
            document.getElementById('replyMessage').value = '';
            currentHelpId = null;
            currentCustomerId = null;
        }

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
                closeModal();
            })
            .catch(err => {
                console.error(err);
                alert("Error sending reply");
            });
        }

        function deleteMessage(helpId) {
            if (confirm(`Are you sure you want to delete this message?`)) {
                window.location.href = "DeleteHelpServlet?helpId=" + helpId;
            }
        }
    </script>
</body>
</html>
