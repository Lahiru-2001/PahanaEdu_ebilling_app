<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.DB.DBConnecter"%>
<%@ page import="com.DAO.ItemDAO"%>
<%@ page import="com.DAO.ItemDAOImple"%>
<%@ page import="com.entity.Item"%>

<%
// Fetch all items from DB
ItemDAO itemDAO = new ItemDAOImple(DBConnecter.getConnection());
List<Item> itemsList = itemDAO.getAllItems();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer - All Items</title>
<%@ include file="all_component/all_css.jsp"%>
<style>
/* Container */
.content {
	max-width: 1200px;
	margin: auto;
	padding: 20px;
}

/* Header */
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

/* Search Bar */
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

/* Grid Layout */
.product-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
	gap: 20px;
	margin-top: 20px;
}

/* Product Card */
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

/* Quantity & Button */
.qty-input {
	width: 60px;
	padding: 5px;
	text-align: center;
	margin-right: 5px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

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


	<%@ include file="all_component/navbar.jsp"%>

	<div class="content">
		<div class="header">
			<p>All Products</p>
			<div class="search-bar">
				<input type="text" id="searchInput" placeholder="Search products...">
				<button onclick="searchItems()">Search</button>
			</div>
		</div>
		<div class="card shadow">
			<div class="card-body">
	<%
	String msg = (String) session.getAttribute("message");
	if (msg != null) {
	%>
	<div
		style="background: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-bottom: 15px;">
		<%=msg%>
	</div>
	<%
	session.removeAttribute("message");
	}
	%>
				<div class="product-grid" id="productGrid">
					<%
					if (itemsList != null && !itemsList.isEmpty()) {
						for (Item item : itemsList) {
					%>
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
							<form action="AddToCartServlet" method="post">
								<input type="hidden" name="item_id"
									value="<%=item.getItem_id()%>"> <input type="number"
									name="quantity" class="qty-input" min="1"
									max="<%=item.getStock_quantity()%>" value="1">
								<button type="submit" class="add-cart-btn">Add to Cart</button>
							</form>

						</div>
					</div>
					<%
					}
					} else {
					%>
					<p>No products found.</p>
					<%
					}
					%>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="all_component/footer.jsp"%>


	<script>
    function searchItems() {
        let input = document.getElementById('searchInput').value.toLowerCase();
        let cards = document.querySelectorAll('#productGrid .card');
        cards.forEach(card => {
            let name = card.querySelector('h1').textContent.toLowerCase();
            let category = card.querySelector('.category').textContent.toLowerCase();
            let description = card.querySelector('.description').textContent.toLowerCase();
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
