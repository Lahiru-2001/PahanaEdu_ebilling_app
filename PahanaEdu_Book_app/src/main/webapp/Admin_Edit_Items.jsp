<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - Edit Item Page</title>
<%@ include file="all_component/all_css.jsp"%>
</head>
<body>
	<%@ include file="all_component/navbar.jsp"%>
	<!-- Include navbar component -->

	<div class="container mt-4">
		<div class="card shadow">
			<div class="card-body">
				<h4 class="card-title mb-4">Edit Item</h4>

				<!-- Display error message if present -->
				<c:if test="${not empty error}">
					<div class="alert alert-danger">${error}</div>
				</c:if>

				<!-- Display success message if present -->
				<c:if test="${not empty success}">
					<div class="alert alert-success">${success}</div>
				</c:if>

				<!-- Edit Item Form -->
				<form action="edit_item" method="post" enctype="multipart/form-data"
					class="needs-validation" novalidate>


					<!-- Hidden field to store item ID -->
					<input type="hidden" name="item_id" value="${item.item_id}" />

					<div class="row">
						<!-- Item Name Input -->
						<div class="col-4">
							<div class="mb-3">
								<label>Name</label> <input type="text" name="name"
									class="form-control" value="${item.name}" required>
								<div class="invalid-feedback">Item name is required.</div>
							</div>
						</div>
						<!-- Item Description Input -->
						<div class="col-4">
							<div class="mb-3">
								<label>Description</label> <input type="text" name="description"
									class="form-control" value="${item.description}" required>
								<div class="invalid-feedback">Description is required.</div>
							</div>
						</div>

						<div class="col-4">
							<!-- Category Selection -->
							<div class="mb-3">
								<label>Category</label> <select name="category"
									class="form-select" required>
									<option value="">-- Select --</option>
									<option value="school_book"
										${item.category == 'school_book' ? 'selected' : ''}>School
										Book</option>
									<option value="pen_pencil"
										${item.category == 'pen_pencil' ? 'selected' : ''}>Pen/Pencil</option>
									<option value="school_bag"
										${item.category == 'school_bag' ? 'selected' : ''}>School
										Bag</option>
									<option value="other"
										${item.category == 'other' ? 'selected' : ''}>Other</option>
									<option value="pencil_sharpener"
										${item.category == 'pencil_sharpener' ? 'selected' : ''}>Pencil
										Sharpener</option>
									<option value="eraser"
										${item.category == 'eraser' ? 'selected' : ''}>Eraser</option>
								</select>
								<div class="invalid-feedback">Please select a category.</div>
							</div>
						</div>

					</div>





					<div class="row">
						<div class="col-3">
							<!-- Price Input -->
							<div class="mb-3">
								<label>Price (Rs.)</label> <input type="number" name="price"
									class="form-control" step="0.01" value="${item.price}" required
									min="0"
									oninvalid="this.setCustomValidity('Please provide a valid price (>= 0).')"
									oninput="setCustomValidity('')">
								<div class="invalid-feedback">Please provide a valid
									price.</div>
							</div>
						</div>
						<div class="col-3">
							<!-- Stock Quantity Input -->
							<div class="mb-3">
								<label>Stock Quantity</label> <input type="number"
									name="stock_quantity" class="form-control"
									value="${item.stock_quantity}" required min="0"
									oninvalid="this.setCustomValidity('Please provide stock quantity (>= 0).')"
									oninput="setCustomValidity('')">
								<div class="invalid-feedback">Stock quantity is required.</div>
							</div>
						</div>
					</div>




					<div class="row">
						<div class="col-4">
							<!-- Display existing image -->
							<div class="mb-3">
								<label>Existing Image</label><br> <img
									src="${pageContext.request.contextPath}/${item.image}"
									width="100" />
								<!-- Hidden field to pass existing image path if no new image is uploaded -->
								<input type="hidden" name="existing_image" value="${item.image}" />
							</div>

							<!-- Upload New Image Input -->
							<div class="mb-3">
								<label>Upload New Image</label> <input type="file" name="image"
									class="form-control" accept="image/png, image/jpeg">
								<div class="invalid-feedback">Please upload a valid image
									(PNG or JPEG).</div>
							</div>
						</div>

					</div>


					<!-- Submit button -->
					<button type="submit" class="btn btn-success">Update Item</button>



				</form>
			</div>
		</div>
	</div>

	<%@ include file="all_component/footer.jsp"%>
	<!-- Include footer component -->

	<!-- Bootstrap Validation Script -->
	<script>
		(function() {
			'use strict'
			const forms = document.querySelectorAll('.needs-validation')
			Array.from(forms).forEach(function(form) {
				form.addEventListener('submit', function(event) {
					if (!form.checkValidity()) {
						event.preventDefault()
						event.stopPropagation()
					}
					form.classList.add('was-validated')
				}, false)
			})
		})()
	</script>
</body>
</html>
