<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Page directive: Java language, UTF-8 encoding -->

<!-- Import required Java and application-specific classes -->
<%@ page import="java.sql.Connection"%>
<%@ page import="java.util.List"%>
<%@ page import="com.DB.DBConnecter"%>
<%@ page import="com.DAO.ItemDAO"%>
<%@ page import="com.DAO.ItemDAOImple"%>
<%@ page import="com.entity.Item"%>

<%
// Fetch all items from the database
ItemDAO itemDAO = new ItemDAOImple(DBConnecter.getConnection());
List<Item> itemsList = itemDAO.getAllItems();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PahanaEdu Home Page</title>

<%@include file="all_component/all_css.jsp"%>
<!-- Include shared CSS -->
</head>

<body>

	<%@include file="all_component/navbar.jsp"%>
	<!-- Include navigation bar -->

	<!-- Welcome Section with Slider -->
	<section id="card_slider" class="my-5">
		<div class="container">
			<div class="card shadow">
				<div class="card-body">

					<div class="row align-items-center g-4">

						<!-- Welcome Text Card -->
						<div class="col-lg-4">
							<div class="card shadow h-100">
								<div class="card-body">
									<h2 class="card-title">
										Welcome,<br> PahanaEdu Book Online Web App
									</h2>
									<p class="card-text mt-3">Discover a world of knowledge at
										your fingertips with PahanaEdu Book Online Web App. Browse our
										wide collection of books and other products enjoy seamless online shopping, and
										bring your favorite reads straight to your doorstep. Your next
										great read is just a click away!</p><br>

									<a href="#" class="btn btn-primary mt-3">Shop Now</a>
								</div>
							</div>
						</div>

						<!-- Image Slider -->
						<div class="col-lg-8">
							<div class="slider">

								<!-- Radio buttons for slider navigation -->
								<input type="radio" name="radio-btn" id="radio1" checked>
								<input type="radio" name="radio-btn" id="radio2"> <input
									type="radio" name="radio-btn" id="radio3"> <input
									type="radio" name="radio-btn" id="radio4">

								<!-- Slides -->
								<div class="slides">
									<div class="slide first">
										<a href="#"><img src="images/sideshow1.png" alt="Slide 1"></a>
									</div>
									<div class="slide">
										<a href="#"><img src="images/sideshow2.jpg" alt="Slide 2"></a>
									</div>
									<div class="slide">
										<a href="#"><img src="images/sideshow3.jpg" alt="Slide 3"></a>
									</div>
									<div class="slide">
										<a href="#"><img src="images/sideshow4.png" alt="Slide 4"></a>
									</div>
								</div>

								<!-- Manual Navigation Buttons -->
								<div class="navigation-manual">
									<label for="radio1" class="manual-btn"></label> <label
										for="radio2" class="manual-btn"></label> <label for="radio3"
										class="manual-btn"></label> <label for="radio4"
										class="manual-btn"></label>
								</div>
							</div>
						</div>
						<!-- End of Slider Column -->

					</div>
				</div>
			</div>
		</div>
	</section>

	<hr class="line_hr">
	<!-- Horizontal separator -->

	<!-- All Products Section -->
	<section id="items_sider">
		<h2 class="text-center mb-4">All Products</h2>

		<div class="product-grid" id="productGrid">
			<%
			// Check if products are available
			if (itemsList != null && !itemsList.isEmpty()) {
				for (Item item : itemsList) {
			%>
			<!-- Product Card -->
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
					<a href="Login.jsp" class="btn btn-primary btn-sm">Shop Now</a>
				</div>
			</div>
			<%
			}
			} else {
			%>
			<!-- Message if no products found -->
			<p>No products found.</p>
			<%
			}
			%>
		</div>
	</section>

	<!-- Categories Section -->
	<section id="category_card">
		<h3>All Category</h3>
		<div class="container">
			<div class="item_school_book">
				<a href="#"> <img src="images/Bag_category.jpg"
					alt="school_book">
					<div class="text">School Book</div>
				</a>
			</div>
			<div class="item_Pen">
				<a href="#"> <img src="images/Pen_category.jpg" alt="Pen">
					<div class="text">Pen</div>
				</a>
			</div>
			<div class="item_Bag">
				<a href="#"> <img src="images/Book_category.jpg" alt="Book">
					<div class="text">Book</div>
				</a>
			</div>
			<div class="item_Pencil">
				<a href="#"> <img src="images/Pencile_category.jpg" alt="Pencil">
					<div class="text">Pencil</div>
				</a>
			</div>
		</div>
	</section>

	<%@include file="all_component/footer.jsp"%>
	<!-- Include footer -->

	<!-- JavaScript for Slider & Carousel -->
	<script type="text/javascript">
		// Auto image slider
		let counter = 1;
		setInterval(() => {
			document.getElementById('radio' + counter).checked = true;
			counter++;
			if (counter > 4) counter = 1;
		}, 5000);

		// Product carousel navigation (if implemented with scroll container)
		let scrollContainer = document.getElementById("carouselItems");
		let scrollAmount = 0;

		function next() {
			scrollContainer.scrollBy({
				left: 270, // width of card + margin
				behavior: "smooth"
			});
		}

		function prev() {
			scrollContainer.scrollBy({
				left: -270,
				behavior: "smooth"
			});
		}
	</script>

</body>
</html>
