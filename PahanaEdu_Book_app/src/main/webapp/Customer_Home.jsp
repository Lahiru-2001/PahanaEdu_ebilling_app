<%@ page import="java.util.*, com.entity.Item"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>
<%@ page import="java.util.List"%>
<%@ page import="com.DB.DBConnecter"%>
<%@ page import="com.DAO.ItemDAO"%>
<%@ page import="com.DAO.ItemDAOImple"%>
<%@ page import="com.entity.Item"%>

<%
/* 
  Fetch all items from the database using ItemDAO.
  This list will be displayed in the "All Products" section.
*/
ItemDAO itemDAO = new ItemDAOImple(DBConnecter.getConnection());
List<Item> itemsList = itemDAO.getAllItems();
%>

<!DOCTYPE html>
<html>
<head>

<%@include file="all_component/all_css.jsp"%>

<!-- Redirect non-customers to login page -->
<c:if test="${sessionScope.role != 'customer'}">
	<c:redirect url="Login.jsp" />
</c:if>

<!-- Include Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<meta charset="UTF-8">
<title>Customer-Home Page</title>

<!-- Inline styling for headings -->
<style>
h2 {
	text-align: center;
	margin-bottom: 25px;
	font-size: 28px;
	font-weight: 700;
}
</style>
</head>

<body>
	<!-- Include navbar component -->
	<%@include file="all_component/navbar.jsp"%>

	<!-- Welcome section with image slider -->
	<section id="card_slider" class="my-5">
		<div class="container">
			<div class="card shadow">
				<div class="card-body">

					<div class="row align-items-center g-4">

						<!-- Welcome Card on the left -->
						<div class="col-lg-4">
							<div class="card shadow h-100">
								<div class="card-body">
									<h2 class="card-title">
										Welcome,<br> PahanaEdu Book Online Web App
									</h2>
									<!-- Welcome paragraph -->
									<p class="card-text mt-3">Discover a world of knowledge at
										your fingertips with PahanaEdu Book Online Web App. Browse our
										wide collection of books and other products enjoy seamless online shopping, and
										bring your favorite reads straight to your doorstep. Your next
										great read is just a click away!</p><br>
									<a href="#" class="btn btn-primary mt-3">Shop Now</a>
								</div>
							</div>
						</div>

						<!-- Image slider on the right -->
						<div class="col-lg-8">
							<div class="slider">
								<!-- Radio buttons for slider navigation -->
								<input type="radio" name="radio-btn" id="radio1" checked>
								<input type="radio" name="radio-btn" id="radio2"> <input
									type="radio" name="radio-btn" id="radio3"> <input
									type="radio" name="radio-btn" id="radio4">

								<!-- Slides container -->
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

								<!-- Manual navigation buttons -->
								<div class="navigation-manual">
									<label for="radio1" class="manual-btn"></label> <label
										for="radio2" class="manual-btn"></label> <label for="radio3"
										class="manual-btn"></label> <label for="radio4"
										class="manual-btn"></label>
								</div>
							</div>
						</div>
					</div>
					<!-- End row -->
				</div>
				<!-- End card-body -->
			</div>
			<!-- End card -->
		</div>
		<!-- End container -->
	</section>

	<br>

	<hr class="line_hr">

	<!-- Products Section -->
	<section id="items_sider">
		<h2 class="text-center mb-4">All Products</h2>

		<div class="product-grid" id="productGrid">
			<%
			// Loop through items fetched from the database
			if (itemsList != null && !itemsList.isEmpty()) {
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
					<a href="Customer_All_items.jsp" class="btn btn-primary btn-sm">Shop
						Now</a>
				</div>
			</div>
			<%
			}
			} else {
			%>
			<!-- Display if no products found -->
			<p>No products found.</p>
			<%
			}
			%>
		</div>
	</section>

	<br>

	<!-- Category Section -->
	<section id="category_card">
		<h3>All Category</h3>
		<div class="container">
			<div class="item_school_book">
				<a href="#"> <img src="images/Bag_category.jpg"
					alt="school_book">
					<div class="text">School Book</div></a>
			</div>
			<div class="item_Pen">
				<a href="#"><img src="images/Pen_category.jpg" alt="Pen">
					<div class="text">Pen</div></a>
			</div>
			<div class="item_Bag">
				<a href="#"> <img src="images/Book_category.jpg" alt="Book">
					<div class="text">Book</div></a>
			</div>
			<div class="item_Pencil">
				<a href="#"> <img src="images/Pencile_category.jpg" alt="Pencil">
					<div class="text">Pencil</div></a>
			</div>
		</div>
	</section>

	<!-- Include footer component -->
	<%@include file="all_component/footer.jsp"%>

	<!-- JavaScript for slider and product carousel -->
	<script type="text/javascript">
    // Auto image slider every 5 seconds
    let counter = 1;
    setInterval(() => {
        document.getElementById('radio' + counter).checked = true;
        counter++;
        if (counter > 4) counter = 1;
    }, 5000);

    // Product carousel scrolling (if implemented)
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
