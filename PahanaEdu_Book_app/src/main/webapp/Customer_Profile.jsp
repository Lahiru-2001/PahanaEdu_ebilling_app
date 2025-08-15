<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.DB.DBConnecter"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page session="true"%>
<!-- Enable HTTP session for storing/retrieving user data -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer-Profile Page</title>


<%@ include file="all_component/all_css.jsp"%>
</head>

<style>
/* ====== Page Styling ====== */
body {
	background-color: #f8f9fa;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

/* Card styling for profile container */
.card {
	border-radius: 15px;
	border: none;
	background: #ffffff;
}

.card-body {
	padding: 40px;
}

/* Heading styling */
h4 {
	font-weight: 600;
	color: #333;
	border-bottom: 2px solid #28a745;
	padding-bottom: 10px;
	margin-bottom: 30px;
}

/* Label styling */
.profile-label {
	font-weight: 600;
	color: #555;
	margin-top: 10px;
}

/* Form field styling */
.form-control {
	border-radius: 10px;
	padding: 10px 15px;
	font-size: 15px;
	border: 1px solid #ccc;
	transition: border-color 0.3s;
}

.form-control:focus {
	border-color: #28a745;
	box-shadow: 0 0 0 2px rgba(40, 167, 69, 0.2);
}

/* Read-only input styling */
.form-control[readonly] {
	background-color: #f0f0f0;
	border: 1px solid #ddd;
	cursor: not-allowed;
}

/* Textarea should not be resizable */
textarea.form-control {
	resize: none;
}

/* Buttons styling */
.btn-success {
	padding: 10px 25px;
	font-size: 16px;
	border-radius: 8px;
	border: none;
	transition: background-color 0.3s, transform 0.2s;
}

.btn-success:hover {
	background-color: #218838 !important;
	transform: scale(1.03);
}

.btn-outline-secondary {
	border-radius: 10px;
	margin-left: 10px;
	background: #e9ecef;
	border: none;
	transition: background 0.3s;
}

.btn-outline-secondary:hover {
	background: #ced4da;
}

/* Hide elements when needed */
.d-none {
	display: none !important;
}

/* Mobile responsive adjustments */
@media screen and (max-width: 768px) {
	.card-body {
		padding: 20px;
	}
	.btn {
		width: 100%;
		margin-bottom: 10px;
	}
}
</style>

<body>

	<!-- Include navigation bar -->
	<%@ include file="all_component/navbar.jsp"%>

	<%
	// Database connection setup
	Connection conn = DBConnecter.getConnection();
	PreparedStatement ps = null;
	ResultSet rs = null;

	// Retrieve user_id from session (if logged in)
	int userId = (session.getAttribute("user_id") != null) ? (Integer) session.getAttribute("user_id") : 0;

	// SQL query to get customer and user data
	String query = "SELECT u.username, u.password_hash, c.account_number, c.first_name, c.last_name, c.address, c.phone_number "
			+ "FROM users u JOIN customers c ON u.user_id = c.user_id WHERE u.user_id = ?";

	// Variables to store retrieved profile details
	String username = "", password = "", account = "", fname = "", lname = "", address = "", phone = "";

	// If user is logged in, fetch their profile details
	if (userId != 0) {
		ps = conn.prepareStatement(query);
		ps.setInt(1, userId);
		rs = ps.executeQuery();

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

	<!-- Profile Section -->
	<section class="my-5">
		<div class="container">
			<div class="card shadow">
				<div class="card-body">
					<h4 class="profile-h4">Your Profile</h4>

					<!-- Profile Form -->
					<form id="profileForm" action="UpdateCustomerProfileServlet"
						method="post">
						<div class="row">
							<!-- Left column with username & account -->
							<div class="col-md-6">
								<label class="profile-label">Username</label> <input type="text"
									name="username" class="form-control" value="<%=username%>"
									readonly>

								<!-- Password field (commented out for now) -->
								<%-- 
							<div class="input-group">
								<input type="password" name="password" class="form-control"
									id="password" value="<%=password%>" readonly>
								<button class="btn btn-outline-secondary" type="button" onclick="togglePassword()">
									<i class="fas fa-eye" id="eyeIcon"></i>
								</button>
							</div>
							--%>

								<label class="profile-label">Account Number</label> <input
									type="text" name="account_number" class="form-control"
									value="<%=account%>" readonly>
							</div>

							<!-- Right column with personal info -->
							<div class="col-md-6">
								<label class="profile-label">First Name</label> <input
									type="text" name="first_name" class="form-control"
									value="<%=fname%>" readonly> <label
									class="profile-label">Last Name</label> <input type="text"
									name="last_name" class="form-control" value="<%=lname%>"
									readonly> <label class="profile-label">Phone
									Number</label> <input type="text" name="phone_number"
									class="form-control" value="<%=phone%>" readonly> <label
									class="profile-label">Address</label>
								<textarea name="address" class="form-control" rows="2" readonly><%=address%></textarea>
							</div>
						</div>

						<!-- Action buttons -->
						<div class="mt-4 text-center">
							<!-- Edit button -->
							<button type="button" class="btn btn-success text-white"
								style="background-color: #28a745" id="editBtn"
								onclick="enableEditing()">Edit</button>

							<!-- Update button (hidden by default) -->
							<button type="submit" class="btn btn-success text-white"
								style="background-color: #28a745" id="updateBtn">Update</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>

	<!-- Include footer -->
	<%@ include file="all_component/footer.jsp"%>

	<script>
    // On page load, hide the Update button
    document.addEventListener("DOMContentLoaded", () => {
        document.getElementById("updateBtn").classList.add("d-none");
    });

    /* Password visibility toggle function (currently unused)
    function togglePassword() {
        const pwd = document.getElementById("password");
        const icon = document.getElementById("eyeIcon");

        if (pwd.type === "password") {
            pwd.type = "text";
            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");
        } else {
            pwd.type = "password";
            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");
        }
    } */

    // Enable form fields for editing when "Edit" button is clicked
    function enableEditing() {
        const form = document.getElementById("profileForm");
        const inputs = form.querySelectorAll("input, textarea");

        inputs.forEach(input => {
            input.removeAttribute("readonly"); // Allow editing
            input.style.backgroundColor = "#ffffff"; // Set editable background
        });

        // Hide Edit button, show Update button
        document.getElementById("editBtn").classList.add("d-none");
        document.getElementById("updateBtn").classList.remove("d-none");
    }
</script>

</body>
</html>
