<%@ page
	import="java.util.*, com.DAO.ItemDAO, com.DAO.ItemDAOImple, com.DB.DBConnecter, com.entity.Item"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - View Items Page</title>
<%@ include file="all_component/all_css.jsp"%>
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" />
</head>
<body>
	<%@ include file="all_component/navbar.jsp"%>

	<!-- Server-side logic to fetch items -->
	<%
	List<Item> items = new ArrayList<>();
	try {
		ItemDAO dao = new ItemDAOImple(DBConnecter.getConnection());
		items = dao.getAllItems();
	} catch (Exception e) {
		request.setAttribute("error", "Failed to load items.");
	}
	request.setAttribute("items", items);
	%>

	<div class="container mt-4">
		<div class="row">
			<div class="col">
				<div class="card shadow">
					<div class="card-body">
						<h4 class="card-title mb-4">View Items</h4>

						<c:if test="${not empty error}">
							<div class="alert alert-danger">${error}</div>
						</c:if>

						<div class="table-responsive">
							<table class="table table-striped" id="items-table">
								<thead class="table-light">
									<tr>
										<th>Name</th>
										<th>Description</th>
										<th>Category</th>
										<th>Price</th>
										<th>Stock</th>
										<th>Image</th>
										<th>Status</th>
										<th>Actions</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${not empty items}">
											<c:forEach var="item" items="${items}">
												<tr>
													<td>${item.name}</td>
													<td>${item.description}</td>
													<td>${item.category}</td>
													<td>Rs. ${item.price}</td>
													<td>${item.stock_quantity}</td>
													<td><img
														src="${pageContext.request.contextPath}/${item.image}"
														style="width: 60px; height: auto;" alt="Item Image" /></td>
													<td>${item.status}</td>
													<td><a href="load_item?item_id=${item.item_id}"
														class="btn btn-sm btn-warning">Edit</a> <a
														href="delete_item?item_id=${item.item_id}"
														class="btn btn-sm btn-danger"
														onclick="return confirm('Are you sure you want to delete this item?');">Delete</a>
													</td>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<tr>
												<td colspan="8" class="text-center text-muted">No items
													found.</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="all_component/footer.jsp"%>

	<!-- DataTables JS (Make sure jQuery is already included in your all_css.jsp or separately) -->
	<script
		src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
	<script>
		$(document).ready(function() {
			$('#items-table').DataTable({
				responsive : true
			});
		});
	</script>
</body>
</html>
