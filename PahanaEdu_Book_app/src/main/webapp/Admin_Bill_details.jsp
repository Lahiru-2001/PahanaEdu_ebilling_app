<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,java.util.*"%>
<%@ page import="com.DB.DBConnecter"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin - Payment Reports</title>
<%@include file="all_component/all_css.jsp"%>
<style>
/* Same CSS as before */
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f4f6f8;
    color: #333;
}
.report-container {
    background: #ffffff;
    max-width: 1200px;
    margin: 0 auto;
    padding: 30px 25px;
    border-radius: 12px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.08);
}
h2 {
    text-align: center;
    margin-bottom: 25px;
    font-size: 28px;
    color: #007bff;
}
.filter-form {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    gap: 15px;
    margin-bottom: 30px;
}
.filter-form label {
    font-weight: 500;
    margin-right: 5px;
}
.filter-form input[type="date"] {
    padding: 8px 12px;
    border-radius: 6px;
    border: 1px solid #ccc;
    font-size: 14px;
    transition: border-color 0.3s;
}
.filter-form input[type="date"]:focus {
    border-color: #007bff;
    outline: none;
}
.filter-form button {
    padding: 8px 20px;
    border: none;
    background-color: #007bff;
    color: #fff;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 500;
    transition: background 0.3s, transform 0.2s;
}
.filter-form button:hover {
    background-color: #0056b3;
    transform: scale(1.05);
}
.summary {
    display: flex;
    justify-content: space-around;
    flex-wrap: wrap;
    gap: 20px;
    margin-bottom: 30px;
}
.summary div {
    background: linear-gradient(135deg, #007bff, #0056b3);
    color: #fff;
    padding: 15px 25px;
    border-radius: 12px;
    text-align: center;
    min-width: 180px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    transition: transform 0.3s;
}
.summary div:hover {
    transform: translateY(-5px);
}
.summary h3 {
    margin: 0 0 8px 0;
    font-size: 18px;
}
.summary p {
    margin: 0;
    font-size: 20px;
    font-weight: bold;
}
table {
    width: 100%;
    border-collapse: collapse;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 4px 12px rgba(0,0,0,0.05);
}
th, td {
    padding: 14px 10px;
    text-align: center;
}
th {
    background-color: #007bff;
    color: white;
    font-weight: 600;
    font-size: 15px;
}
td {
    background-color: #ffffff;
    font-size: 14px;
}
tr:nth-child(even) td {
    background-color: #f9f9f9;
}
tr:hover td {
    background-color: #e8f0fe;
    transition: background-color 0.3s;
}
@media screen and (max-width: 768px) {
    .filter-form {
        flex-direction: column;
        align-items: center;
    }
    .summary {
        flex-direction: column;
        align-items: center;
    }
    .summary div {
        min-width: 250px;
    }
}
</style>
</head>
<body>
<%@include file="all_component/navbar.jsp"%>
<br>
<div class="report-container">
    <h2>Payment Reports</h2>

    <!-- Filter Form -->
    <form class="filter-form" method="get" action="">
        <label for="startDate">From:</label>
        <input type="date" id="startDate" name="startDate" value="<%= request.getParameter("startDate") != null ? request.getParameter("startDate") : "" %>">
        <label for="endDate">To:</label>
        <input type="date" id="endDate" name="endDate" value="<%= request.getParameter("endDate") != null ? request.getParameter("endDate") : "" %>">
        <button type="submit">Filter</button>
        <button type="button" id="resetBtn">Reset</button>
    </form>

    <%
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        boolean filterApplied = (startDate != null && endDate != null && !startDate.isEmpty() && !endDate.isEmpty());
    %>

    <!-- Summary Section -->
    <div class="summary">
        <div>
            <h3>Total Orders</h3>
            <p>
                <%
                    int totalOrders = 0;
                    try (Connection con = DBConnecter.getConnection()) {
                        String countSQL = "SELECT COUNT(*) AS total_orders FROM processing_bills WHERE status = 'Orders Confirm'";
                        if (filterApplied) {
                            countSQL += " AND DATE(order_date) BETWEEN ? AND ?";
                        }
                        try (PreparedStatement ps = con.prepareStatement(countSQL)) {
                            if (filterApplied) {
                                ps.setString(1, startDate);
                                ps.setString(2, endDate);
                            }
                            try (ResultSet rs = ps.executeQuery()) {
                                if (rs.next()) totalOrders = rs.getInt("total_orders");
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
                        if (filterApplied) {
                            sumSQL += " AND DATE(order_date) BETWEEN ? AND ?";
                        }
                        try (PreparedStatement ps = con.prepareStatement(sumSQL)) {
                            if (filterApplied) {
                                ps.setString(1, startDate);
                                ps.setString(2, endDate);
                            }
                            try (ResultSet rs = ps.executeQuery()) {
                                if (rs.next()) totalAmount = rs.getDouble("total_amount");
                            }
                        }
                    }
                    out.print("Rs:" + String.format("%.2f", totalAmount));
                %>
            </p>
        </div>
    </div>

    <!-- Report Table -->
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
                               + "FROM processing_bills b "
                               + "JOIN customers c ON b.customer_id = c.customer_id "
                               + "WHERE b.status = 'Orders Confirm'";
                    if (filterApplied) {
                        sql += " AND DATE(b.order_date) BETWEEN ? AND ?";
                    }
                    sql += " ORDER BY b.order_date DESC";
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

<script>
document.getElementById("resetBtn").addEventListener("click", function() {
    window.location.href = window.location.pathname; // reload without query params
});
</script>
</body>
</html>
