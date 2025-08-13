<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,java.time.*,java.time.format.DateTimeFormatter"%>
<%@ page import="com.DB.DBConnecter"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<%@include file="all_component/all_css.jsp"%>

<c:if test="${sessionScope.role != 'admin'}">
    <c:redirect url="Login.jsp" />
</c:if>

<head>
<meta charset="UTF-8">
<title>Admin - Home</title>
<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f4f6f8;
    color: #111827;
    margin: 0;
    padding: 0;
}

.container {
    padding: 40px 20px;
    max-width: 1200px;
    margin: auto;
}

/* Dashboard Cards */
.dashboard-cards {
    display: flex;
    flex-wrap: wrap;
    gap: 25px;
    justify-content: center;
}

.card {
    background: linear-gradient(145deg, #ffffff, #f9fafb);
    border-radius: 15px;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.06);
    padding: 25px;
    width: 300px;
    text-align: center;
    transition: all 0.3s ease-in-out;
}

.card:hover {
    transform: translateY(-6px) scale(1.02);
    box-shadow: 0 12px 24px rgba(0, 0, 0, 0.12);
}

.card-icon {
    font-size: 40px;
    color: #2563eb;
    margin-bottom: 15px;
}

.card h3 {
    font-size: 18px;
    font-weight: 600;
    color: #6b7280;
    margin-bottom: 8px;
}

.card p {
    font-size: 30px;
    font-weight: bold;
    color: #111827;
}

/* Summary Table */
.summary-table {
    margin-top: 50px;
    width: 100%;
    border-collapse: collapse;
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
}

.summary-table th, 
.summary-table td {
    padding: 14px 18px;
    text-align: left;
    font-size: 15px;
}

.summary-table th {
    background-color: #f3f4f6;
    font-weight: 600;
    color: #374151;
}

.summary-table tr {
    border-bottom: 1px solid #e5e7eb;
}

.summary-table tr:last-child {
    border-bottom: none;
}

.summary-table tr:hover {
    background-color: #f9fafb;
    transition: background-color 0.2s ease-in-out;
}

</style>
</head>
<body data-topbar="colored" data-layout="horizontal">

<%@include file="all_component/navbar.jsp"%>

<div class="container">
    <div class="dashboard-cards">

        <!-- Total Orders -->
        <div class="card">
            <div class="card-icon"><i class="ri-shopping-basket-2-line"></i></div>
            <h3>Total Orders</h3>
            <p>
            <%
                int totalOrders = 0;
                try (Connection con = DBConnecter.getConnection()) {
                    String sql = "SELECT COUNT(*) AS cnt FROM processing_bills WHERE status='Orders Confirm'";
                    try (PreparedStatement ps = con.prepareStatement(sql)) {
                        try (ResultSet rs = ps.executeQuery()) {
                            if (rs.next()) totalOrders = rs.getInt("cnt");
                        }
                    }
                }
                out.print(totalOrders);
            %>
            </p>
        </div>

        <!-- Month Earned -->
        <div class="card">
            <div class="card-icon"><i class="ri-money-dollar-circle-line"></i></div>
            <h3>Month Earned</h3>
            <p>
            <%
                double monthEarnings = 0.0;
                try (Connection con = DBConnecter.getConnection()) {
                    LocalDate now = LocalDate.now();
                    String firstDay = now.withDayOfMonth(1).toString();
                    String lastDay = now.withDayOfMonth(now.lengthOfMonth()).toString();
                    String sql = "SELECT SUM(total_amount) AS total FROM processing_bills " +
                                 "WHERE status='Orders Confirm' AND DATE(order_date) BETWEEN ? AND ?";
                    try (PreparedStatement ps = con.prepareStatement(sql)) {
                        ps.setString(1, firstDay);
                        ps.setString(2, lastDay);
                        try (ResultSet rs = ps.executeQuery()) {
                            if (rs.next()) monthEarnings = rs.getDouble("total");
                        }
                    }
                }
                out.print("Rs:" + String.format("%.2f", monthEarnings));
            %>
            </p>
        </div>

        <!-- Processing Orders -->
        <div class="card">
            <div class="card-icon"><i class="ri-time-line"></i></div>
            <h3>Processing Orders</h3>
            <p>
            <%
                int processingOrders = 0;
                try (Connection con = DBConnecter.getConnection()) {
                    String sql = "SELECT COUNT(*) AS cnt FROM processing_bills WHERE status='processing'";
                    try (PreparedStatement ps = con.prepareStatement(sql)) {
                        try (ResultSet rs = ps.executeQuery()) {
                            if (rs.next()) processingOrders = rs.getInt("cnt");
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
            <tr><td>Total Orders</td><td><%= totalOrders %></td></tr>
            <tr><td>Processing Orders</td><td><%= processingOrders %></td></tr>
            <tr>
                <td>Completed Orders</td>
                <td>
                <%
                    int completedOrders = 0;
                    try (Connection con = DBConnecter.getConnection()) {
                        String sql = "SELECT COUNT(*) AS cnt FROM processing_bills WHERE status='Orders Confirm'";
                        try (PreparedStatement ps = con.prepareStatement(sql)) {
                            try (ResultSet rs = ps.executeQuery()) {
                                if (rs.next()) completedOrders = rs.getInt("cnt");
                            }
                        }
                    }
                    out.print(completedOrders);
                %>
                </td>
            </tr>
            <tr><td>Monthly Earnings</td><td>Rs:<%= String.format("%.2f", monthEarnings) %></td></tr>
            <tr>
                <td>Total Earnings</td>
                <td>
                <%
                    double totalEarnings = 0.0;
                    try (Connection con = DBConnecter.getConnection()) {
                        String sql = "SELECT SUM(total_amount) AS total FROM processing_bills WHERE status='Orders Confirm'";
                        try (PreparedStatement ps = con.prepareStatement(sql)) {
                            try (ResultSet rs = ps.executeQuery()) {
                                if (rs.next()) totalEarnings = rs.getDouble("total");
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

<%@include file="all_component/footer.jsp"%>
</body>
</html>
