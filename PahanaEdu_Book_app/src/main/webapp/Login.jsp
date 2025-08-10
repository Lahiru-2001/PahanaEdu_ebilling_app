<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PahanaEdu User Login Page</title>
<%@include file="all_component/all_css.jsp"%>
</head>

<style>
.was-validated .form-control:invalid {
	border-color: #dc3545;
}

.was-validated .form-control:valid {
	border-color: #198754;
}
</style>

<body>
	<%@include file="all_component/navbar.jsp"%>

	<div class="container mt-5">
		<div class="row justify-content-center">
			<div class="col-md-5">
				<div class="card shadow">
					<div class="card-body">
						<h4 class="text-center mb-4">Login</h4>

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

						<form id="loginForm" action="usrs_login" method="post" novalidate>

							<div class="mb-3">
								<label for="username" class="form-label">User Name</label> <input
									class="form-control" type="text" id="username" name="username"
									required>
								<div class="invalid-feedback">User name is required.</div>
							</div>

							<div class="mb-3">
								<label for="password" class="form-label">Password</label> <input
									class="form-control" type="password" id="password"
									name="password" minlength="4" required>
								<div class="invalid-feedback">Password must be at least 4
									characters.</div>
							</div>

							<input type="hidden" name="action" value="login">
							<button type="submit" class="btn btn-info w-100">Login</button>
							<br>
							<br>

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

	<script>
		document.getElementById('loginForm').addEventListener('submit',
				function(event) {
					const form = this;
					if (!form.checkValidity()) {
						event.preventDefault();
						event.stopPropagation();
					}
					form.classList.add('was-validated');
				});
	</script>

</body>
</html>
