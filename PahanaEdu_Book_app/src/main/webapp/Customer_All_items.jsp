<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.DB.DBConnecter"%>
<%@ page import="com.DAO.ItemDAO"%>
<%@ page import="com.DAO.ItemDAOImple"%>
<%@ page import="com.entity.Item"%>

<%
// Fetch all items from the database using ItemDAO
ItemDAO itemDAO = new ItemDAOImple(DBConnecter.getConnection());
List<Item> itemsList = itemDAO.getAllItems();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer - All Items Page</title>
<%@ include file="all_component/all_css.jsp"%>
</head>
<body>

	<!-- Include navigation bar -->
	<%@ include file="all_component/navbar.jsp"%>

	<div class="content-allItems">
		<!-- Header section with search bar -->
		<div class="header">
			<p>All Products</p>
			<div class="search-bar">
				<input type="text" id="searchInput" placeholder="Search products...">
				<button onclick="searchItems()">Search</button>
			</div>
		</div>

		<div class="card shadow">
			<div class="card-body">
				<!-- Display success message from session if available -->
				<%
				String msg = (String) session.getAttribute("message");
				if (msg != null) {
				%>
				<div
					style="background: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-bottom: 15px;">
					<%=msg%>
				</div>
				<%
				session.removeAttribute("message"); // Clear the message from session
				}
				%>

				<!-- Product grid -->
				<div class="product-grid" id="productGrid">
					<%
					if (itemsList != null && !itemsList.isEmpty()) {
						for (Item item : itemsList) {
					%>
					<div class="card-allItems">
						<!-- Product image -->
						<img src="<%=item.getImage()%>" alt="<%=item.getName()%>">
						<!-- Product details -->
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

						<!-- Add to Cart form -->
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

	<!-- Include footer -->
	<%@ include file="all_component/footer.jsp"%>

	<!-- JavaScript search functionality -->
	<script>
    function searchItems() {
        let input = document.getElementById('searchInput').value.toLowerCase();
        // Select all product cards
        let cards = document.querySelectorAll('#productGrid .card');
        cards.forEach(card => {
            // Get product details
            let name = card.querySelector('h1').textContent.toLowerCase();
            let category = card.querySelector('.category').textContent.toLowerCase();
            let description = card.querySelector('.description').textContent.toLowerCase();
            // Show or hide card based on search input
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
