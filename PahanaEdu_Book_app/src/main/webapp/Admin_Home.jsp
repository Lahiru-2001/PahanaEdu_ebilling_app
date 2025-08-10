
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="com.DB.DBConnecter"%>
<%@ page session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<%@include file="all_component/all_css.jsp"%>
<c:if test="${sessionScope.role != 'admin'}">
	<c:redirect url="Login.jsp" />
</c:if>

<head>
<meta charset="UTF-8">
<title>Admin-Home Page</title>
</head>
<body data-topbar="colored" data-layout="horizontal">


	<%@include file="all_component/navbar.jsp"%>

	<%-- <h2>Welcome,${sessionScope.username}</h2> --%>
	<!-- admin content -->

	<div class="main-content">

		<div class="page-content" style="margin-top: 30px;">
			<div class="container-fluid">
				<div class="row">
					<!--Customers-->
					<div class="col-xl-4 col-md-6">
						<div class="card">
							<div class="card-body">
								<div class="d-flex">
									<div class="flex-grow-1">
										<p class="text-truncate font-size-14 mb-2">Total Customers
										</p>
										<h4 class="mb-2"></h4>
									</div>
									<div class="avatar-sm">
										<span class="avatar-title bg-light text-primary rounded-3">
											<i class="ri-store-2-line font-size-24"></i>
										</span>
									</div>
								</div>
							</div>
							<!-- end cardbody -->
						</div>
						<!-- end card -->
					</div>
					<!-- end col -->


					<!--Items-->

					<div class="col-xl-4 col-md-6">
						<div class="card">
							<div class="card-body">
								<div class="d-flex">
									<div class="flex-grow-1">
										<p class="text-truncate font-size-14 mb-2">Total Items</p>
										<h4 class="mb-2"></h4>

									</div>
									<div class="avatar-sm">
										<span class="avatar-title bg-light text-primary rounded-3">
											<i class="ri-store-2-line font-size-24"></i>
										</span>
									</div>
								</div>
							</div>
							<!-- end cardbody -->
						</div>
						<!-- end card -->
					</div>
					<!-- end col -->


					<!-- total_investment -->
					<div class="col-xl-4 col-md-6" style="">
						<div class="card">
							<div class="card-body">
								<div class="d-flex">
									<div class="flex-grow-1">
										<p class="text-truncate font-size-14 mb-2">Month Earned</p>
										<h4 class="mb-2"></h4>

									</div>
									<div class="avatar-sm">
										<span class="avatar-title bg-light text-primary rounded-3">
											<i class="ri-store-2-line font-size-24"></i>
										</span>
									</div>
								</div>
							</div>
							<!-- end cardbody -->
						</div>
						<!-- end card -->
					</div>
					<!-- end col -->
				</div>
				<!-- end row -->
				<br>
				<hr>
	<br>
				<div class="row">

					<div class="col">
						<div class="card shadow">
							<div class="card-body">
								<h4 class="card-title mb-4">Items Details</h4>
								<div class="table-responsive">
									<table class="table table-hover align-middle" id="items-table">
										<caption class="visually-hidden">List of items in
											inventory with actions</caption>
										<thead class="table-light">
											<tr>
												<th scope="col">Name</th>
												<th scope="col">Description</th>
												<th scope="col">Category</th> 
												<th scope="col">Price</th>
												<th scope="col">Stock Quantity</th>
												<th scope="col">Image</th>

											</tr>
										</thead>
										<tbody id="items-tbody">
											<!-- Placeholder for "no items" -->
											<tr id="no-items-row">
												<td colspan="8" class="text-center text-muted">No items
													found.</td>
											</tr>
											<!-- Item rows will be injected here -->
										</tbody>
									</table>
								</div>
								<!-- Optional: pagination / filter controls could go here -->
							</div>
						</div>
					</div>

				</div>
			</div>


		</div>



	</div>
	<!-- end main content-->




	<%@include file="all_component/footer.jsp"%>
</body>
</html>