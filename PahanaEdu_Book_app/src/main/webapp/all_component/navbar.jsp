<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.entity.User, com.entity.Customer"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.DB.DBConnecter"%>

<%
User loggedUser = (User) session.getAttribute("loggedUser");
// Avoid redeclaring 'customer' if already declared somewhere else, rename here if needed
Customer loggedCustomer = (Customer) session.getAttribute("customer");
String role = null;
if (loggedUser != null) {
	role = loggedUser.getRole();
}
%>

<%
if (loggedUser == null) {
%>

<!-- Guest Navbar -->
<a class="visually-hidden-focusable sr-only" href="#main-content"
	style="position: absolute; top: 0; left: 0; background: #fff; padding: 8px; z-index: 1000;">
	Skip to content </a>

<nav class="navbar navbar-expand-lg bg-body-tertiary shadow-sm"
	aria-label="Primary navigation">
	<div class="container-fluid">
		<a class="navbar-brand d-flex align-items-center gap-2"
			href="index.jsp"> <span class="h5 mb-0">PahanaEdu</span> <i
			class="fa-solid fa-book-open" aria-hidden="true"
			style="color: #8293FF; font-size: 1.5rem;"></i> <span
			class="visually-hidden">Home</span>
		</a>

		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarMain" aria-controls="navbarMain"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse justify-content-end"
			id="navbarMain">
			<ul class="navbar-nav me-3 mb-2 mb-lg-0">
				<li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
				<li class="nav-item"><a class="nav-link" href="About_Us.jsp">About</a></li>
				<li class="nav-item"><a class="nav-link" href="Index_Items.jsp">Items</a></li>
			</ul>

			<div class="dropdown">
				<button class="btn btn-light d-flex align-items-center"
					type="button" id="userDropdown" data-bs-toggle="dropdown"
					aria-expanded="false" aria-label="User menu">
					<i class="fa-solid fa-user" aria-hidden="true"
						style="font-size: 1.25rem; color: #1b1c1d;"></i> <span
						class="ms-2 d-none d-lg-inline">Account</span>
				</button>
				<ul class="dropdown-menu dropdown-menu-end"
					aria-labelledby="userDropdown">
					<li><a class="dropdown-item d-flex align-items-center"
						href="Login.jsp"> <i class="fa-solid fa-right-to-bracket me-2"
							aria-hidden="true"></i>Login
					</a></li>
					<li><hr class="dropdown-divider"></li>
					<li><a
						class="dropdown-item text-danger d-flex align-items-center"
						href="register.jsp"> <i
							class="fa-solid fa-user-plus me-2 text-danger" aria-hidden="true"></i>Register
					</a></li>
				</ul>
			</div>
		</div>
	</div>
</nav>

<style>
/* Guest navbar styles here as before */
</style>

<%
} else if ("admin".equalsIgnoreCase(role)) {
%>

<style>
:root {
	--navbar-bg: #1f3b70;
	--navbar-text: #ffffff;
	--brand-accent: #8293FF;
}

.navbar-admin {
	background-color: #6f737a;
	z-index: 1000;
}

.navbar-admin .nav-link {
	color: var(--navbar-text);
}

.navbar-admin .nav-link.active, .navbar-admin .nav-link:hover {
	color: #f0f8ff;
	font-weight: 600;
}

.badge-notification {
	position: absolute;
	top: 6px;
	right: 6px;
	font-size: 0.55rem;
	transform: translate(50%, -50%);
}

.avatar-circle {
	width: 32px;
	height: 32px;
	border-radius: 50%;
	background-color: #ccc;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	font-size: 0.85rem;
	color: #333;
}
</style>

<nav class="navbar navbar-expand-lg navbar-admin navbar-dark">
	<div class="container-fluid">
		<a class="navbar-brand d-flex align-items-center gap-2" href="#">
			<span class="fs-5 fw-bold">PahanaEdu</span> <i
			class="fa-solid fa-book-open" style="color: var(--brand-accent);"></i>
		</a>

		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#adminNavbar" aria-controls="adminNavbar"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="adminNavbar">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item"><a class="nav-link" href="Admin_Home.jsp"><i
						class="fa-solid fa-layer-group"></i> Dashboard</a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="itemsDropdown"
					data-bs-toggle="dropdown">Items</a>
					<ul class="dropdown-menu" aria-labelledby="itemsDropdown">
						<li><a class="dropdown-item" href="Admin_Add_Item.jsp">Add
								Items</a></li>
						<li><a class="dropdown-item" href="Admin_View_Item.jsp">View
								Items</a></li>
					</ul></li>
				<li class="nav-item"><a class="nav-link"
					href="Admin_C_Orders.jsp">Orders</a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="moreDropdown"
					data-bs-toggle="dropdown">Payments</a>
					<ul class="dropdown-menu" aria-labelledby="moreDropdown">
						<li><a class="dropdown-item" href="Admin_Bill_details.jsp">Bill
								Details</a></li>

					</ul></li>
			</ul>

			<div class="d-flex align-items-center gap-3">
				<%
				int unreadHelpCount = 0;
				try (Connection adminConn = DBConnecter.getConnection()) {
					String sqlHelp = "SELECT COUNT(*) FROM help WHERE status = 'unread'";
					try (PreparedStatement psHelp = adminConn.prepareStatement(sqlHelp); ResultSet rsHelp = psHelp.executeQuery()) {
						if (rsHelp.next()) {
					unreadHelpCount = rsHelp.getInt(1);
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				%>
				<div class="dropdown">
					<a class="btn position-relative text-white" href="Admin_help.jsp"
						aria-label="Notifications"> <i
						class="fa-regular fa-bell fa-lg"></i> <%
 if (unreadHelpCount > 0) {
 %> <span class="badge bg-danger rounded-pill badge-notification"><%=unreadHelpCount%></span>
						<%
						}
						%> <span class="visually-hidden"><%=unreadHelpCount%> new
							notifications</span>
					</a>
				</div>
			</div>

			<div class="dropdown">
				<button class="btn d-flex align-items-center text-white"
					type="button" id="userMenu" data-bs-toggle="dropdown">
					<div class="avatar-circle me-2">
						<%=(loggedUser != null && loggedUser.getUsername() != null)
		? loggedUser.getUsername().substring(0, 1).toUpperCase()
		: "?"%>
					</div>
					<span class="me-1"><%=(loggedUser != null) ? loggedUser.getUsername() : "Guest"%></span>
					<i class="fa-solid fa-chevron-down small"></i>
				</button>
				<ul class="dropdown-menu dropdown-menu-end"
					aria-labelledby="userMenu">
					<li><a class="dropdown-item text-danger" href="LogoutServlet"
						onclick="return confirm('Are you sure you want to log out?');">
							<i class="fa-solid fa-right-from-bracket" style="color: #ff0000;"></i>
							Logout
					</a></li>


				</ul>
			</div>
		</div>
	</div>
</nav>

<%
} else if ("customer".equalsIgnoreCase(role)) {
%>

<style>
.badge-notification {
	position: absolute;
	top: 6px;
	right: 6px;
	font-size: 0.55rem;
	transform: translate(50%, -50%);
}
</style>

<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
	<div class="container-fluid">
		<a class="navbar-brand d-flex align-items-center" href="#"> <i
			class="fa-solid fa-book-open fa-lg me-2" style="color: #8293FF;"></i>
			<span class="fw-bold text-primary">PahanaEdu</span>
		</a>

		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#customerNavbar">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="customerNavbar">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item"><a class="nav-link active"
					href="Customer_Home.jsp">Home</a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="shopDropdown"
					data-bs-toggle="dropdown">Shop</a>
					<ul class="dropdown-menu" aria-labelledby="shopDropdown">
						<li><a class="dropdown-item" href="Customer_All_items.jsp">All
								Products</a></li>
					</ul></li>
				<li class="nav-item"><a class="nav-link" href="Customer_Orders_View.jsp">My
						Orders</a></li>
				<li class="nav-item"><a class="nav-link"
					href="Customer_Help.jsp">Support</a></li>
				<li class="nav-item"><a class="nav-link" href="About_Us.jsp">About
						Us</a></li>
			</ul>

			<ul class="navbar-nav align-items-center mb-2 mb-lg-0">
				<li class="nav-item me-2"><a class="btn position-relative"
					href="cart.jsp" aria-label="View cart"> <i
						class="fa-solid fa-cart-shopping fa-lg"></i>

				</a></li>

				<%
				int unreadHelpResponseCount = 0;
				try (Connection custConn = DBConnecter.getConnection()) {
					String sqlHelpResp = "SELECT COUNT(*) FROM help_response WHERE status = 'unread'";
					try (PreparedStatement psHelpResp = custConn.prepareStatement(sqlHelpResp);
					ResultSet rsHelpResp = psHelpResp.executeQuery()) {
						if (rsHelpResp.next()) {
					unreadHelpResponseCount = rsHelpResp.getInt(1);
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				%>
				<li class="nav-item"><a
					class="btn position-relative text-white"
					href="Customer_Help_Respones.jsp" aria-label="Notifications"> <i
						class="fa-regular fa-bell fa-lg" style="color: black;"></i> <%
 if (unreadHelpResponseCount > 0) {
 %> <span class="badge bg-danger rounded-pill badge-notification"><%=unreadHelpResponseCount%></span>
						<%
						}
						%> <span class="visually-hidden"><%=unreadHelpResponseCount%>
							new notifications</span>
				</a></li>

				<li class="nav-item dropdown">
					<button class="btn d-flex align-items-center" id="userDropdown"
						data-bs-toggle="dropdown">
						<i class="fa-solid fa-user-circle fa-2x me-1"></i> <span
							class="d-none d-md-inline"><%=(loggedUser != null) ? loggedUser.getUsername() : "Guest"%></span>
						<i class="fa-solid fa-caret-down ms-1"></i>
					</button>
					<ul class="dropdown-menu dropdown-menu-end">
						<li><a class="dropdown-item" href="Customer_Profile.jsp">Profile</a></li>
						<li><hr class="dropdown-divider"></li>
						<li><a class="dropdown-item text-danger" href="LogoutServlet"
							onclick="return confirm('Are you sure you want to log out?');">
								<i class="fa-solid fa-right-from-bracket"
								style="color: #ff0000;"></i> Logout
						</a></li>


					</ul>
				</li>
			</ul>
		</div>
	</div>
</nav>

<%
}
%>
