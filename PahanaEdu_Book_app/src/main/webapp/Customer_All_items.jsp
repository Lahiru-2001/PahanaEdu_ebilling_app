<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="com.DB.DBConnecter"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer-All Items Page</title>
<%@include file="all_component/all_css.jsp"%>
</head>
<body>

	<%@include file="all_component/navbar.jsp"%>

	<div class="content">
		<div class="card">
			<div class="card-body">
				<div class="row">
					<div class="col">
						<div class="header">
							<p>All Products</p>
							<div class="search-bar">
								<input type="text" id="searchInput"
									placeholder="Search products...">
								<button onclick="searchItems()">Search</button>
							</div>

						</div>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="col">
						<div class="card">
							<img src="/w3images/jeans3.jpg" alt="Denim Jeans"
								style="width: 100%">
							<h1>Item Name</h1>
							<p class="price">$19.99</p>
							<p class="stock_quantity">stock_quantity</p>
							<p class="category">category</p>
							<p>description</p>
							<p>
								<button>Add to Cart</button>
							</p>
						</div>
					</div>

					<div class="col">
						<div class="card">
							<img src="/w3images/jeans3.jpg" alt="Denim Jeans"
								style="width: 100%">
							<h1>Item Name</h1>
							<p class="price">$19.99</p>
							<p class="stock_quantity">stock_quantity</p>
							<p class="category">category</p>
							<p>description</p>
							<p>
								<button>Add to Cart</button>
							</p>
						</div>
					</div>

					<div class="col">
						<div class="card">
							<img src="/w3images/jeans3.jpg" alt="Denim Jeans"
								style="width: 100%">
							<h1>Item Name</h1>
							<p class="price">$19.99</p>
							<p class="stock_quantity">stock_quantity</p>
							<p class="category">category</p>
							<p>description</p>
							<p>
								<button>Add to Cart</button>
							</p>
						</div>
					</div>


					<div class="col">
						<div class="card">
							<img src="/w3images/jeans3.jpg" alt="Denim Jeans"
								style="width: 100%">
							<h1>Item Name</h1>
							<p class="price">$19.99</p>
							<p class="stock_quantity">stock_quantity</p>
							<p class="category">category</p>
							<p>description</p>
							<p>
								<button>Add to Cart</button>
							</p>
						</div>
					</div>

				</div>

				<br>
				<div class="row">

					<div class="col">
						<div class="card">
							<img src="/w3images/jeans3.jpg" alt="Denim Jeans"
								style="width: 100%">
							<h1>Item Name</h1>
							<p class="price">$19.99</p>
							<p class="stock_quantity">stock_quantity</p>
							<p class="category">category</p>
							<p>description</p>
							<p>
								<button>Add to Cart</button>
							</p>
						</div>
					</div>

					<div class="col">
						<div class="card">
							<img src="/w3images/jeans3.jpg" alt="Denim Jeans"
								style="width: 100%">
							<h1>Item Name</h1>
							<p class="price">$19.99</p>
							<p class="stock_quantity">stock_quantity</p>
							<p class="category">category</p>
							<p>description</p>
							<p>
								<button>Add to Cart</button>
							</p>
						</div>
					</div>

					<div class="col">
						<div class="card">
							<img src="/w3images/jeans3.jpg" alt="Denim Jeans"
								style="width: 100%">
							<h1>Item Name</h1>
							<p class="price">$19.99</p>
							<p class="stock_quantity">stock_quantity</p>
							<p class="category">category</p>
							<p>description</p>
							<p>
								<button>Add to Cart</button>
							</p>
						</div>
					</div>


					<div class="col">
						<div class="card">
							<img src="/w3images/jeans3.jpg" alt="Denim Jeans"
								style="width: 100%">
							<h1>Item Name</h1>
							<p class="price">$19.99</p>
							<p class="stock_quantity">stock_quantity</p>
							<p class="category">category</p>
							<p>description</p>
							<p>
								<button>Add to Cart</button>
							</p>
						</div>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="col">
						<div class="card">
							<img src="/w3images/jeans3.jpg" alt="Denim Jeans"
								style="width: 100%">
							<h1>Item Name</h1>
							<p class="price">$19.99</p>
							<p class="stock_quantity">stock_quantity</p>
							<p class="category">category</p>
							<p>description</p>
							<p>
								<button>Add to Cart</button>
							</p>
						</div>
					</div>

					<div class="col">
						<div class="card">
							<img src="/w3images/jeans3.jpg" alt="Denim Jeans"
								style="width: 100%">
							<h1>Item Name</h1>
							<p class="price">$19.99</p>
							<p class="stock_quantity">stock_quantity</p>
							<p class="category">category</p>
							<p>description</p>
							<p>
								<button>Add to Cart</button>
							</p>
						</div>
					</div>

					<div class="col">
						<div class="card">
							<img src="/w3images/jeans3.jpg" alt="Denim Jeans"
								style="width: 100%">
							<h1>Item Name</h1>
							<p class="price">$19.99</p>
							<p class="stock_quantity">stock_quantity</p>
							<p class="category">category</p>
							<p>description</p>
							<p>
								<button>Add to Cart</button>
							</p>
						</div>
					</div>


					<div class="col">
						<div class="card">
							<img src="/w3images/jeans3.jpg" alt="Denim Jeans"
								style="width: 100%">
							<h1>Item Name</h1>
							<p class="price">$19.99</p>
							<p class="stock_quantity">stock_quantity</p>
							<p class="category">category</p>
							<p>description</p>
							<p>
								<button>Add to Cart</button>
							</p>
						</div>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="col">
						<div class="card">
							<img src="/w3images/jeans3.jpg" alt="Denim Jeans"
								style="width: 100%">
							<h1>Item Name</h1>
							<p class="price">$19.99</p>
							<p class="stock_quantity">stock_quantity</p>
							<p class="category">category</p>
							<p>description</p>
							<p>
								<button>Add to Cart</button>
							</p>
						</div>
					</div>

					<div class="col">
						<div class="card">
							<img src="/w3images/jeans3.jpg" alt="Denim Jeans"
								style="width: 100%">
							<h1>Item Name</h1>
							<p class="price">$19.99</p>
							<p class="stock_quantity">stock_quantity</p>
							<p class="category">category</p>
							<p>description</p>
							<p>
								<button>Add to Cart</button>
							</p>
						</div>
					</div>

					<div class="col">
						<div class="card">
							<img src="/w3images/jeans3.jpg" alt="Denim Jeans"
								style="width: 100%">
							<h1>Item Name</h1>
							<p class="price">$19.99</p>
							<p class="stock_quantity">stock_quantity</p>
							<p class="category">category</p>
							<p>description</p>
							<p>
								<button>Add to Cart</button>
							</p>
						</div>
					</div>


					<div class="col">
						<div class="card">
							<img src="/w3images/jeans3.jpg" alt="Denim Jeans"
								style="width: 100%">
							<h1>Item Name</h1>
							<p class="price">$19.99</p>
							<p class="stock_quantity">stock_quantity</p>
							<p class="category">category</p>
							<p>description</p>
							<p>
								<button>Add to Cart</button>
							</p>
						</div>
					</div>
				</div>

			</div>

		</div>

	</div>

	<%@include file="all_component/footer.jsp"%>

</body>
</html>