<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.DB.DBConnecter"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page session="true"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Customer-Cart Page</title>


<%@include file="all_component/all_css.jsp"%>
</head>
<body>

	<!-- Include navigation bar -->
	<%@include file="all_component/navbar.jsp"%>

	<%
	// Establish database connection
	Connection conn = DBConnecter.getConnection();
	PreparedStatement ps = null;
	ResultSet rs = null;

	// Get logged-in user ID from session
	int userId = (session.getAttribute("user_id") != null) ? (Integer) session.getAttribute("user_id") : 0;

	// Query to fetch customer details
	String query = "SELECT u.username, u.password_hash, c.account_number, c.first_name, c.last_name, c.address, c.phone_number "
			+ "FROM users u JOIN customers c ON u.user_id = c.user_id WHERE u.user_id = ?";
	String username = "", password = "", account = "", fname = "", lname = "", address = "", phone = "";

	if (userId != 0) {
		ps = conn.prepareStatement(query);
		ps.setInt(1, userId);
		rs = ps.executeQuery();

		// Store customer info
		if (rs.next()) {
			username = rs.getString("username");
			password = rs.getString("password_hash");
			account = rs.getString("account_number");
			fname = rs.getString("first_name");
			lname = rs.getString("last_name");
			address = rs.getString("address");
			phone = rs.getString("phone_number");
		}
	}
	%>

	<section id="cart">
		<div class="container-Cat">
			<div class="card shadow">
				<div class="card-body">
					<div class="row">

						<!-- Left Column - Customer Details -->
						<div class="col-lg-4">
							<div class="card h-100">
								<div class="card-body">
									<h2>Customer Details</h2>
									<form id="customer-details">
										<label class="profile-label">Full Name:</label> <input
											type="text" name="username" class="form-control"
											value="<%=fname%> <%=lname%>" readonly> <label
											class="profile-label">Account Number</label> <input
											type="text" name="account_number" class="form-control"
											value="<%=account%>" readonly> <label
											class="profile-label">Phone Number</label> <input type="text"
											name="phone_number" class="form-control" value="<%=phone%>"
											readonly> <label class="profile-label">Address</label>
										<textarea name="address" class="form-control" rows="2"
											readonly><%=address%></textarea>
									</form>
								</div>
							</div>
						</div>

						<!-- Right Column - Cart Table -->
						<div class="col-lg-8">
							<div class="cart-section">
								<%
								// Display session messages for success/error
								String successMessage = (String) session.getAttribute("successMessage");
								String errorMessage = (String) session.getAttribute("errorMessage");
								if (successMessage != null) {
								%>
								<div class="alert alert-success"><%=successMessage%></div>
								<%
								session.removeAttribute("successMessage");
								}
								if (errorMessage != null) {
								%>
								<div class="alert alert-danger"><%=errorMessage%></div>
								<%
								session.removeAttribute("errorMessage");
								}
								%>

								<h2>Products Cart</h2>
								<table id="cartTable">
									<thead>
										<tr>
											<th>Item Name</th>
											<th>Category</th>
											<th>Qty</th>
											<th>Price (Rs.)</th>
											<th>Subtotal (Rs.)</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody id="cartBody">
										<%
										// Get cart from session
										com.DAO.CartImple cart = (com.DAO.CartImple) session.getAttribute("cart");
										java.math.BigDecimal totalPrice = java.math.BigDecimal.ZERO;

										if (cart != null && !cart.getItems().isEmpty()) {
											for (com.entity.CartItem ci : cart.getItems()) {
												totalPrice = totalPrice.add(ci.getSubtotal());
										%>
										<tr>
											<td><%=ci.getName()%></td>
											<td><%=ci.getCategory()%></td>
											<td><%=ci.getQuantity()%></td>
											<td class="price"><%=ci.getPrice()%></td>
											<td class="subtotal"><%=ci.getSubtotal()%></td>
											<td>
												<button type="button" class="btn-drop"
													onclick="dropItem(this, '<%=ci.getBill_item_id()%>')">Drop</button>
											</td>
										</tr>
										<%
										}
										} else {
										%>
										<tr>
											<td colspan="6">No items in cart.</td>
										</tr>
										<%
										}
										%>
									</tbody>
									<tfoot>
										<tr class="total-row">
											<td colspan="4" style="text-align: right">Total Price
												(Rs.)</td>
											<td id="totalPrice"><%=totalPrice%></td>
											<td></td>
										</tr>
									</tfoot>
								</table>

								<!-- Cart Action Buttons -->
								<div class="buttons-container">
									<button type="button" class="btn-add" onclick="addItems()">Add
										Items</button>
									<form action="ProcessCartServlet" method="post"
										style="display: inline;">
										<button type="submit" class="btn-process">Process</button>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Include footer -->
	<%@include file="all_component/footer.jsp"%>

	<!-- JavaScript for cart functionality -->
	<script>
    // Update subtotal when quantity changes
    function updateQuantity(input) {
        const tr = input.closest('tr');
        let qty = parseInt(input.value);
        if (qty < 1 || isNaN(qty)) {
            qty = 1;
            input.value = 1;
        }
        const price = parseFloat(tr.querySelector('.price').textContent);
        tr.querySelector('.subtotal').textContent = (price * qty).toFixed(2);
        updateTotal();
    }

    // Remove item from cart
    function dropItem(button) {
        if (confirm('Remove this item from the cart?')) {
            button.closest('tr').remove();
            updateTotal();
        }
    }

    // Update total price of cart
    function updateTotal() {
        let total = 0;
        document.querySelectorAll('.subtotal').forEach(td => {
            total += parseFloat(td.textContent);
        });
        document.getElementById('totalPrice').textContent = total.toFixed(2);
    }

    // Redirect to all items page
    function addItems() {
        window.location.href = "Customer_All_items.jsp";
    }

    // Confirm before processing order
    function confirmProcess() {
        if (confirm("Do you want to process this order?")) {
            document.getElementById('processForm').submit();
        }
    }

    window.onload = updateTotal; // Ensure total is calculated on page load
</script>

</body>
</html>
