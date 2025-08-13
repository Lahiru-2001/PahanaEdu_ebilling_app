<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,java.util.*"%>
<%@ page import="com.DB.DBConnecter"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin - Customer Orders</title>
<%@include file="all_component/all_css.jsp"%>
<style>
body {
    background-color: #f9fafb;
    font-family: 'Segoe UI', Arial, sans-serif;
    margin: 0;
    color: #333;
}

/* Unified filter bar */
.filter-bar {
    background: #fff;
    padding: 15px 20px;
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    justify-content: center;
    align-items: center;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    position: sticky;
    top: 0;
    z-index: 5;
    border-bottom: 1px solid #e5e7eb;
}

.filter-bar input, .filter-bar button {
    padding: 8px 12px;
    border-radius: 6px;
    font-size: 14px;
    transition: 0.2s ease-in-out;
}

.filter-bar input {
    border: 1px solid #d1d5db;
    background: #f9fafb;
}

.filter-bar input:focus {
    outline: none;
    border-color: #3b82f6;
    background: #fff;
    box-shadow: 0 0 0 2px rgba(59,130,246,0.15);
}

.filter-bar button {
    border: none;
    cursor: pointer;
    font-weight: 500;
    color: #fff;
}

.filter-bar button:hover {
    transform: translateY(-1px);
    opacity: 0.95;
}

/* Specific button colors */
#filterBtn { background: #3b82f6; }
#filterBtn:hover { background: #2563eb; }

#resetBtn { background: #6b7280; }
#resetBtn:hover { background: #4b5563; }

#showProcessingBtn { background: #3b82f6; }
#showProcessingBtn:hover { background: #2563eb; }

#showConfirmedBtn { background: #10b981; }
#showConfirmedBtn:hover { background: #059669; }

/* Section title */
.section-title {
    text-align: center;
    margin: 25px auto 15px;
    font-size: 22px;
    font-weight: 600;
    color: #111827;
}

/* Order card */
.order-card {
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 3px 10px rgba(0,0,0,0.05);
    margin: 20px auto;
    padding: 20px;
    max-width: 1000px;
    border-left: 6px solid transparent;
    transition: transform 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}

.order-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 14px rgba(0,0,0,0.07);
}

/* Status color indicators */
.order-card[data-status="processing"] { border-left-color: #3b82f6; }
.order-card[data-status="confirmed"] { border-left-color: #10b981; }

.order-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
.order-header h3 { margin: 0; font-size: 18px; font-weight: 600; color: #111827; }

/* Customer info */
.customer-info {
    font-size: 14px;
    color: #4b5563;
    line-height: 1.6;
    background: #f9fafb;
    padding: 12px;
    border-radius: 6px;
}

/* Table styling */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 15px;
}
th, td { padding: 10px; text-align: left; font-size: 14px; }
th { background-color: #f3f4f6; font-weight: 600; color: #374151; }
td { border-bottom: 1px solid #e5e7eb; }
tbody tr:nth-child(even) { background-color: #f9fafb; }

/* Footer */
.order-footer {
    text-align: right;
    margin-top: 12px;
    font-weight: 600;
    font-size: 15px;
}

/* Confirm button */
.confirm-btn {
    background-color: #10b981;
    border: none;
    padding: 8px 15px;
    color: #fff;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
    margin-top: 6px;
    transition: 0.2s ease-in-out;
}
.confirm-btn:hover { background-color: #059669; transform: translateY(-1px); }
</style>
</head>
<body>

<%@include file="all_component/navbar.jsp"%>

<!-- Unified Filter Bar -->
<div class="filter-bar">
    <input type="date" id="startDate">
    <input type="date" id="endDate">
    <button id="filterBtn">Filter Orders</button>
    <button id="resetBtn">Reset</button>
    <button id="showProcessingBtn">Still Processing Orders</button>
    <button id="showConfirmedBtn">Confirmed Orders</button>
</div>

<!-- Processing Orders -->
<div id="processingOrders">
<%
Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;
try {
    conn = DBConnecter.getConnection();
    String sql = "SELECT pb.bill_id, pb.total_amount, pb.status, pb.order_date, "
        + "c.first_name, c.last_name, c.account_number, c.phone_number, c.address "
        + "FROM processing_bills pb "
        + "JOIN customers c ON pb.customer_id = c.customer_id "
        + "ORDER BY pb.order_date DESC";
    ps = conn.prepareStatement(sql);
    rs = ps.executeQuery();

    List<String> confirmedOrdersHTML = new ArrayList<>();

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

        // Fetch items
        StringBuilder itemsHTML = new StringBuilder();
        PreparedStatement psItems = conn.prepareStatement(
            "SELECT item_name, category, item_price, quantity, subtotal FROM processing_bill_items WHERE bill_id = ?"
        );
        psItems.setInt(1, billId);
        ResultSet rsItems = psItems.executeQuery();
        while (rsItems.next()) {
            itemsHTML.append("<tr>")
                .append("<td>").append(rsItems.getString("item_name")).append("</td>")
                .append("<td>").append(rsItems.getString("category")).append("</td>")
                .append("<td>Rs:").append(rsItems.getBigDecimal("item_price")).append("</td>")
                .append("<td>").append(rsItems.getInt("quantity")).append("</td>")
                .append("<td>Rs:").append(rsItems.getBigDecimal("subtotal")).append("</td>")
                .append("</tr>");
        }
        rsItems.close();
        psItems.close();

        String cardHTML = "<div class='order-card' data-status='" + status.toLowerCase() 
            + "' data-bill-id='" + billId + "' data-order-date='" + dateAttr + "'>"
            + "<div class='order-header'><h3>Order #" + billId + " - " + status + "</h3></div>"
            + "<div class='customer-info'><strong>Customer:</strong> " + customerName + "<br>"
            + "<strong>Account:</strong> " + account + "<br>"
            + "<strong>Phone:</strong> " + phone + "<br>"
            + "<strong>Address:</strong> " + address + "<br>"
            + "<strong>Order Date:</strong> " + orderDateStr + "</div>"
            + "<table><thead><tr><th>Item Name</th><th>Category</th><th>Price</th><th>Qty</th><th>Subtotal</th></tr></thead>"
            + "<tbody>" + itemsHTML + "</tbody></table>"
            + "<div class='order-footer'><strong>Total: Rs:" + String.format("%.2f", totalAmount) + "</strong><br>";

        if ("processing".equalsIgnoreCase(status)) {
            cardHTML += "<button class='confirm-btn'>Confirm Order</button>";
        }
        cardHTML += "</div></div>";

        if ("processing".equalsIgnoreCase(status)) {
            out.print(cardHTML);
        } else {
            confirmedOrdersHTML.add(cardHTML);
        }
    }

    request.setAttribute("confirmedOrdersHTML", confirmedOrdersHTML);

} catch (Exception e) {
    e.printStackTrace();
} finally {
    if (rs != null) rs.close();
    if (ps != null) ps.close();
    if (conn != null) conn.close();
}
%>
</div>

<!-- Confirmed Orders -->
<div id="confirmedOrders">
<%
List<String> confirmedOrdersHTML = (List<String>) request.getAttribute("confirmedOrdersHTML");
if (confirmedOrdersHTML != null) {
    for (String html : confirmedOrdersHTML) {
        out.print(html);
    }
}
%>
</div>

<%@include file="all_component/footer.jsp"%>

<script>
document.addEventListener("DOMContentLoaded", function() {
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
                        document.getElementById("confirmedOrders").prepend(orderCard);
                    } else { alert("Failed to confirm the order."); }
                });
            }
        });
    });

    // Date filter
    document.getElementById("filterBtn").addEventListener("click", function() {
        let start = document.getElementById("startDate").value;
        let end = document.getElementById("endDate").value;
        document.querySelectorAll(".order-card").forEach(card => {
            let orderDate = card.getAttribute("data-order-date");
            card.style.display = (start && orderDate < start) || (end && orderDate > end) ? "none" : "";
        });
    });

    // Toggle views
    document.getElementById("showProcessingBtn").addEventListener("click", function() {
        document.getElementById("processingOrders").style.display = "block";
        document.getElementById("confirmedOrders").style.display = "none";
    });
    document.getElementById("showConfirmedBtn").addEventListener("click", function() {
        document.getElementById("processingOrders").style.display = "none";
        document.getElementById("confirmedOrders").style.display = "block";
    });

    document.getElementById("confirmedOrders").style.display = "none";

    // Reset filter
    document.getElementById("resetBtn").addEventListener("click", function() {
        document.getElementById("startDate").value = "";
        document.getElementById("endDate").value = "";
        document.querySelectorAll(".order-card").forEach(card => card.style.display = "");
    });
});
</script>
</body>
</html>
