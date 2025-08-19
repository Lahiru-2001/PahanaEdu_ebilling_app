<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.DB.DBConnecter"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page session="true"%>
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

.card {
	border-radius: 15px;
	border: none;
	background: #ffffff;
}

.card-body {
	padding: 40px;
}

h4 {
	font-weight: 600;
	color: #333;
	border-bottom: 2px solid #28a745;
	padding-bottom: 10px;
	margin-bottom: 30px;
}

.profile-label {
	font-weight: 600;
	color: #555;
	margin-top: 10px;
}

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

.form-control[readonly] {
	background-color: #f0f0f0;
	border: 1px solid #ddd;
	cursor: not-allowed;
}

textarea.form-control {
	resize: none;
}

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

.d-none {
	display: none !important;
}

.error {
	color: red;
	font-size: 14px;
}

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

	<%@ include file="all_component/navbar.jsp"%>

	<%
	Connection conn = DBConnecter.getConnection();
	PreparedStatement ps = null;
	ResultSet rs = null;

	int userId = (session.getAttribute("user_id") != null) ? (Integer) session.getAttribute("user_id") : 0;

	String query = "SELECT u.username, u.password_hash, c.account_number, c.first_name, c.last_name, c.address, c.phone_number "
			+ "FROM users u JOIN customers c ON u.user_id = c.user_id WHERE u.user_id = ?";

	String username = "", password = "", account = "", fname = "", lname = "", address = "", phone = "";

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

	<section class="my-5">
		<div class="container">
			<div class="card shadow">
				<div class="card-body">
					<h4 class="profile-h4">Your Profile</h4>
					<%
					String successMsg = (String) request.getAttribute("successMsg");
					String errorMsg = (String) request.getAttribute("errorMsg");
					if (successMsg != null) {
					%>
					<div class="alert alert-success alert-dismissible fade show"
						role="alert">
						<%=successMsg%>
						<button type="button" class="btn-close" data-bs-dismiss="alert"
							aria-label="Close"></button>
					</div>
					<%
					} else if (errorMsg != null) {
					%>
					<div class="alert alert-danger alert-dismissible fade show"
						role="alert">
						<%=errorMsg%>
						<button type="button" class="btn-close" data-bs-dismiss="alert"
							aria-label="Close"></button>
					</div>
					<%
					}
					%>
					<form id="profileForm" action="UpdateCustomerProfileServlet"
						method="post" onsubmit="return validateForm()">
						<div class="row">
							<div class="col-md-6">
								<label class="profile-label">Username</label> <input type="text"
									name="username" class="form-control" value="<%=username%>"
									readonly> <label class="profile-label">Account
									Number</label> <input type="text" name="account_number"
									class="form-control" value="<%=account%>" readonly>
							</div>

							<div class="col-md-6">
								<label class="profile-label">First Name</label> <input
									type="text" name="first_name" id="first_name"
									class="form-control" value="<%=fname%>" readonly> <span
									class="error" id="fnameError"></span> <label
									class="profile-label">Last Name</label> <input type="text"
									name="last_name" id="last_name" class="form-control"
									value="<%=lname%>" readonly> <span class="error"
									id="lnameError"></span> <label class="profile-label">Phone
									Number</label> <input type="number" name="phone_number"
									id="phone_number" class="form-control" value="<%=phone%>"
									readonly> <span class="error" id="phoneError"></span> <label
									class="profile-label">Address</label>
								<textarea name="address" id="address" class="form-control"
									rows="2" readonly><%=address%></textarea>
								<span class="error" id="addressError"></span>
							</div>
						</div>

						<div class="mt-4 text-center">
							<button type="button" class="btn btn-success text-white"
								id="editBtn" onclick="enableEditing()">Edit</button>
							<button type="submit" class="btn btn-success text-white"
								id="updateBtn">Update</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="all_component/footer.jsp"%>

	<script>
document.addEventListener("DOMContentLoaded", () => {
    document.getElementById("updateBtn").classList.add("d-none");
});

function enableEditing() {
    const form = document.getElementById("profileForm");
    const inputs = form.querySelectorAll("input, textarea");

    inputs.forEach(input => {
        if (input.name !== "username" && input.name !== "account_number") {
            input.removeAttribute("readonly");
            input.style.backgroundColor = "#ffffff";
        }
    });

    document.getElementById("editBtn").classList.add("d-none");
    document.getElementById("updateBtn").classList.remove("d-none");
}

function validateForm() {
    let isValid = true;

    document.getElementById("fnameError").innerText = "";
    document.getElementById("lnameError").innerText = "";
    document.getElementById("phoneError").innerText = "";
    document.getElementById("addressError").innerText = "";

    const fname = document.getElementById("first_name").value.trim();
    const lname = document.getElementById("last_name").value.trim();
    const phone = document.getElementById("phone_number").value.trim();
    const address = document.getElementById("address").value.trim();

    const nameRegex = /^[A-Za-z\s]{2,30}$/;
    const phoneRegex = /^[0-9]{10}$/;

    if (!nameRegex.test(fname)) {
        document.getElementById("fnameError").innerText = "Enter a valid first name (2–30 letters).";
        isValid = false;
    }
    if (!nameRegex.test(lname)) {
        document.getElementById("lnameError").innerText = "Enter a valid last name (2–30 letters).";
        isValid = false;
    }
    if (!phoneRegex.test(phone)) {
        document.getElementById("phoneError").innerText = "Enter a valid 10-digit phone number.";
        isValid = false;
    }
    if (address.length < 5) {
        document.getElementById("addressError").innerText = "Address must be at least 5 characters.";
        isValid = false;
    }

    return isValid;
}
</script>

</body>
</html>
