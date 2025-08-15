<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.DB.DBConnecter"%>
<%@ page import="com.DAO.ItemDAO"%>
<%@ page import="com.DAO.ItemDAOImple"%>
<%@ page import="com.entity.Item"%>

<%
// Create an instance of ItemDAO implementation and connect to DB
ItemDAO itemDAO = new ItemDAOImple(DBConnecter.getConnection());

// Retrieve all items from the database
List<Item> itemsList = itemDAO.getAllItems();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index-All Items Page</title>

<!-- Include external CSS styles -->
<%@ include file="all_component/all_css.jsp"%>

<style>
/* ======= Page Content Styling ======= */
.content {
	max-width: 1200px;
	margin: auto;
	padding: 20px;
}

/* Header section with title and search bar */
.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	flex-wrap: wrap;
}

.header p {
	font-size: 1.5rem;
	font-weight: bold;
}

/* Search bar styling */
.search-bar {
	display: flex;
	gap: 10px;
}

.search-bar input {
	padding: 8px;
	border-radius: 5px;
	border: 1px solid #ccc;
}

.search-bar button {
	padding: 8px 12px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.search-bar button:hover {
	background-color: #0056b3;
}

/* ======= Product Grid Styling ======= */
.product-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
	gap: 20px;
	margin-top: 20px;
}

/* Product Card styling */
.card {
	border: 1px solid #ddd;
	border-radius: 10px;
	overflow: hidden;
	background-color: white;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	text-align: center;
	padding: 15px;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.card img {
	max-width: 100%;
	height: 200px;
	object-fit: cover;
	border-radius: 5px;
}

.card h1 {
	font-size: 1.2rem;
	margin: 10px 0 5px 0;
}

.price {
	color: green;
	font-weight: bold;
	margin: 5px 0;
}

.stock_quantity {
	font-size: 0.9rem;
	color: gray;
}

.category {
	font-size: 0.85rem;
	color: #555;
	margin-bottom: 5px;
}

.description {
	font-size: 0.85rem;
	color: #666;
	min-height: 40px;
}

/* Quantity input styling */
.qty-input {
	width: 60px;
	padding: 5px;
	text-align: center;
	margin-right: 5px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

/* Add to cart button styling */
.add-cart-btn {
	background-color: #28a745;
	color: white;
	border: none;
	padding: 7px 12px;
	border-radius: 5px;
	cursor: pointer;
}

.add-cart-btn:hover {
	background-color: #218838;
}
</style>
</head>
<body>

	<!-- Include navigation bar -->
	<%@ include file="all_component/navbar.jsp"%>

	<div class="content">
		<!-- Header with title and search bar -->
		<div class="header">
			<p>All Products</p>
			<div class="search-bar">
				<input type="text" id="searchInput" placeholder="Search products...">
				<button onclick="searchItems()">Search</button>
			</div>
		</div>

		<!-- Main product list container -->
		<div class="card shadow">
			<div class="card-body">

				<!-- Product grid -->
				<div class="product-grid" id="productGrid">
					<%
					// Check if product list is not empty
					if (itemsList != null && !itemsList.isEmpty()) {
						// Loop through each product and display its details
						for (Item item : itemsList) {
					%>
					<!-- Single product card -->
					<div class="card">
						<img src="<%=item.getImage()%>" alt="<%=item.getName()%>">
						<h1><%=item.getName()%></h1>
						<p class="price">
							Rs:<%=item.getPrice()%></p>
						<p class="stock_quantity">
							Stock:
							<%=item.getStock_quantity()%></p>
						<p class="category">
							Category:
							<%=item.getCategory()%></p>
						<p class="description"><%=item.getDescription()%></p>
						<div>
							<!-- Redirect to Login page when clicking Shop Now -->
							<a href="Login.jsp" class="btn btn-primary btn-sm">Shop Now</a>
						</div>
					</div>
					<%
					}
					} else {
					// If no products found, display message
					%>
					<p>No products found.</p>
					<%
					}
					%>
				</div>
			</div>
		</div>
	</div>

	<!-- Include footer -->
	<%@ include file="all_component/footer.jsp"%>

	<!-- JavaScript function for searching products -->
	<script>
    function searchItems() {
        let input = document.getElementById('searchInput').value.toLowerCase();
        let cards = document.querySelectorAll('#productGrid .card');

        cards.forEach(card => {
            let name = card.querySelector('h1').textContent.toLowerCase();
            let category = card.querySelector('.category').textContent.toLowerCase();
            let description = card.querySelector('.description').textContent.toLowerCase();

            // Show card if search term matches product name, category, or description
            if (name.includes(input) || category.includes(input) || description.includes(input)) {
                card.style.display = '';
            } else {
                card.style.display = 'none';
            }
        });
    }
</script>

</body>
</html>
