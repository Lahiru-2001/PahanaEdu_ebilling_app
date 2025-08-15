<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Core JSTL tags -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- JSTL functions -->
<%@page isELIgnored="false"%>
<!-- Enable Expression Language -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PahanaEdu User Register Page</title>

<%@include file="all_component/all_css.jsp"%>
<!-- Include common CSS -->

<!-- Auto-redirect to login page after success -->
<c:if test="${not empty success_message}">
	<meta http-equiv="refresh" content="3;url=login.jsp" />
</c:if>

<!-- Styling for form validation colors -->
<style>
.was-validated .form-control:invalid {
	border-color: #dc3545;
}

.was-validated .form-control:valid {
	border-color: #198754;
}
</style>
</head>
<body>

	<%@include file="all_component/navbar.jsp"%>
	<!-- Include navigation bar -->

	<div class="container mt-4">
		<div class="row justify-content-center">
			<div class="col-md-6">

				<!-- Registration card -->
				<div class="card shadow">
					<div class="card-body">
						<h4 class="text-center mb-4">Customer Register</h4>

						<!-- Display general error message -->
						<c:if test="${not empty general_error}">
							<div class="alert alert-danger">${general_error}</div>
						</c:if>

						<!-- Display success message -->
						<c:if test="${not empty success_message}">
							<div class="alert alert-success text-center">
								${success_message} Redirecting to login...</div>
						</c:if>

						<!-- Registration form -->
						<form action="Customer_register" method="post" novalidate
							id="registrationForm">

							<!-- First & Last Name fields -->
							<div class="row mb-3">
								<div class="col-md-6">
									<label for="first_name" class="form-label">First Name</label> <input
										class="form-control ${not empty err_first_name ? 'is-invalid' : ''}"
										type="text" id="first_name" name="first_name" required
										value="${fn:escapeXml(first_name)}">
									<div class="invalid-feedback">
										<c:choose>
											<c:when test="${not empty err_first_name}">${err_first_name}</c:when>
											<c:otherwise>First name is required.</c:otherwise>
										</c:choose>
									</div>
								</div>

								<div class="col-md-6">
									<label for="last_name" class="form-label">Last Name</label> <input
										class="form-control ${not empty err_last_name ? 'is-invalid' : ''}"
										type="text" id="last_name" name="last_name" required
										value="${fn:escapeXml(last_name)}">
									<div class="invalid-feedback">
										<c:choose>
											<c:when test="${not empty err_last_name}">${err_last_name}</c:when>
											<c:otherwise>Last name is required.</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>

							<!-- Address field -->
							<div class="mb-3">
								<label for="address" class="form-label">Address</label> <input
									class="form-control ${not empty err_address ? 'is-invalid' : ''}"
									type="text" id="address" name="address" required
									value="${fn:escapeXml(address)}">
								<div class="invalid-feedback">
									<c:choose>
										<c:when test="${not empty err_address}">${err_address}</c:when>
										<c:otherwise>Address is required.</c:otherwise>
									</c:choose>
								</div>
							</div>

							<!-- Account Number & Phone Number -->
							<div class="row mb-3">
								<div class="col-md-6">
									<label for="account_Number" class="form-label">Account
										Number</label> <input
										class="form-control ${not empty err_account_Number ? 'is-invalid' : ''}"
										type="text" id="account_Number" name="account_Number"
										pattern="\d{6,}" required
										value="${fn:escapeXml(account_Number)}">
									<div class="invalid-feedback">
										<c:choose>
											<c:when test="${not empty err_account_Number}">${err_account_Number}</c:when>
											<c:otherwise>Enter a valid account number (minimum 6 digits).</c:otherwise>
										</c:choose>
									</div>
								</div>

								<div class="col-md-6">
									<label for="phone_Number" class="form-label">Contact No</label>
									<input
										class="form-control ${not empty err_phone_Number ? 'is-invalid' : ''}"
										type="tel" id="phone_Number" name="phone_Number"
										pattern="\d{10}" required
										value="${fn:escapeXml(phone_Number)}">
									<div class="invalid-feedback">
										<c:choose>
											<c:when test="${not empty err_phone_Number}">${err_phone_Number}</c:when>
											<c:otherwise>Enter a 10-digit phone number.</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>

							<!-- Username & Password -->
							<div class="row mb-3">
								<div class="col-md-6">
									<label for="user_name" class="form-label">User Name</label> <input
										class="form-control ${not empty err_user_name ? 'is-invalid' : ''}"
										type="text" id="user_name" name="user_name" required
										value="${fn:escapeXml(user_name)}">
									<div class="invalid-feedback">
										<c:choose>
											<c:when test="${not empty err_user_name}">${err_user_name}</c:when>
											<c:otherwise>User name is required.</c:otherwise>
										</c:choose>
									</div>
								</div>

								<div class="col-md-6">
									<label for="password" class="form-label">Password</label> <input
										class="form-control ${not empty err_password ? 'is-invalid' : ''}"
										type="password" id="password" name="password" minlength="4"
										required>
									<div class="invalid-feedback">
										<c:choose>
											<c:when test="${not empty err_password}">${err_password}</c:when>
											<c:otherwise>Password must be at least 4 characters.</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>

							<!-- Hidden action field -->
							<input type="hidden" id="action" name="action" value="register">

							<!-- Submit button -->
							<button type="submit" class="btn btn-info w-100">Submit</button>
						</form>
					</div>
				</div>

			</div>
		</div>
	</div>

	<%@include file="all_component/footer.jsp"%>
	<!-- Include footer -->

	<!-- Client-side form validation -->
	<script>
		const form = document.getElementById('registrationForm');
		form.addEventListener('submit', function(event) {
			if (!form.checkValidity()) { // Prevent submit if invalid
				event.preventDefault();
				event.stopPropagation();
			}
			form.classList.add('was-validated'); // Apply validation styling
		});
	</script>
</body>
</html>
