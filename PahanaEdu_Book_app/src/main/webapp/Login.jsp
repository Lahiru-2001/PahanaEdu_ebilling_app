<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- JSP page directive: Java language, UTF-8 encoding -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PahanaEdu User Login Page</title>

<%@include file="all_component/all_css.jsp"%>
<!-- Include shared CSS styles -->
</head>

<!-- Inline CSS for form validation styling -->
<style>
.was-validated .form-control:invalid {
	border-color: #dc3545;
} /* Red border if invalid */
.was-validated .form-control:valid {
	border-color: #198754;
} /* Green border if valid */
</style>

<body>

	<%@include file="all_component/navbar.jsp"%>
	<!-- Include navigation bar -->

	<div class="container mt-5">
		<div class="row justify-content-center">
			<div class="col-md-5">

				<!-- Login card -->
				<div class="card shadow">
					<div class="card-body">
						<h4 class="text-center mb-4">Login</h4>

						<!-- Display login error if exists -->
						<%
						String error = (String) request.getAttribute("loginError");
						if (error != null) {
						%>
						<div class="alert alert-danger">
							<%=error%>
						</div>
						<%
						}
						%>

						<!-- Login form -->
						<form id="loginForm" action="usrs_login" method="post" novalidate>

							<!-- Username input -->
							<div class="mb-3">
								<label for="username" class="form-label">User Name</label> <input
									class="form-control" type="text" id="username" name="username"
									required>
								<div class="invalid-feedback">User name is required.</div>
							</div>

							<!-- Password input -->
							<div class="mb-3">
								<label for="password" class="form-label">Password</label> <input
									class="form-control" type="password" id="password"
									name="password" minlength="4" required>
								<div class="invalid-feedback">Password must be at least 4
									characters.</div>
							</div>

							<!-- Hidden action field -->
							<input type="hidden" name="action" value="login">

							<!-- Submit button -->
							<button type="submit" class="btn btn-info w-100">Login</button>
							<br>
							<br>

							<!-- Link to registration page -->
							<div class="text">
								<a href="register.jsp">Create New Account</a>
							</div>
						</form>

					</div>
				</div>
			</div>
		</div>
	</div>


	<br>
	<br>
	<br>

	<%@include file="all_component/footer.jsp"%>
	<!-- Include footer -->

	<!-- Client-side form validation script -->
	<script>
		document.getElementById('loginForm').addEventListener('submit',
				function(event) {
					const form = this;
					if (!form.checkValidity()) { // Prevent submit if form is invalid
						event.preventDefault();
						event.stopPropagation();
					}
					form.classList.add('was-validated'); // Apply validation styling
				});
	</script>

</body>
</html>
