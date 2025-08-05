<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin-Manage Users</title>
<%@include file="all_component/all_css.jsp"%>
</head>
<body>
	<%@include file="all_component/navbar.jsp"%>


	<div class="container mt-4">
		<div class="row">
			<div class="col">
				<div class="card shadow">
					<div class="card-body">
						<h4 class="card-title mb-4">Manage Users</h4>
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
										<th scope="col">Status</th>
										<th scope="col" style="min-width: 160px;">Actions</th>
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








	<%@include file="all_component/footer.jsp"%>
</body>
</html>