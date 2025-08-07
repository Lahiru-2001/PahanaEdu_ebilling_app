<%@ page import="java.util.*, com.entity.Item" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true"%>

<%@ page import="java.sql.Connection"%>
<%@ page import="com.DB.DBConnecter"%>
<%-- <%@ page import="com.servlet.Login_servlet"%>
<%@ page import="com.entity.User, com.entity.Customer"%> --%>
<!DOCTYPE html>
<html>
<head>
<%@include file="all_component/all_css.jsp"%>

<c:if test="${sessionScope.role != 'customer'}">
	<c:redirect url="Login.jsp" />
</c:if>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
</style>
<body>
	<%@include file="all_component/navbar.jsp"%>

	<%-- 
	<c:out value="${sessionScope}" />
	

	<h2>Welcome, ${sessionScope.firstName} ${sessionScope.lastName}</h2>
	<p>Account Number: ${sessionScope.accountNumber}</p>
	<p>Customer ID: ${sessionScope.customerId}</p>
	<!-- other customer data --> --%>



	<!-- Authorization guard: redirect if not logged in or not a customer -->
	<c:choose>
		<c:when
			test="${empty sessionScope.loggedUser or sessionScope.role != 'customer'}">
			<c:redirect url="index.jsp" />
		</c:when>
		<c:otherwise>
			<c:if test="${not empty sessionScope.customer}">
				<h2>Welcome, ${sessionScope.customer.firstName}
					${sessionScope.customer.lastName}</h2>
				<p>Account Number: ${sessionScope.customer.accountNumber}</p>
				<p>Customer ID: ${sessionScope.customer.customerId}</p>
				<!-- other customer data -->
			</c:if>
			<c:if test="${empty sessionScope.customer}">
				<p>Customer details are not available. Please contact support.</p>
			</c:if>
		</c:otherwise>
	</c:choose>

	<section id="card_slider" class="my-5">
		<div class="container">
			<div class="card shadow">
				<div class="card-body">

					<div class="row align-items-center g-4">
						<!-- Welcome Card -->
						<div class="col-lg-4">
							<div class="card shadow h-100">
								<div class="card-body">
									<h2 class="card-title">
										Welcome,<br> PahanaEdu Book Online Web App
									</h2>
									<p class="card-text mt-3">With supporting text below as a
										natural lead-in to additional content. With supporting text
										below as a natural lead-in to additional content. With
										supporting text below as a natural lead-in to additional
										content.</p>
									<a href="#" class="btn btn-primary mt-3">Shop Now</a>
								</div>
							</div>
						</div>

						<!-- Slider -->
						<div class="col-lg-8">
							<div class="slider">
								<!-- Radio buttons -->
								<input type="radio" name="radio-btn" id="radio1" checked>
								<input type="radio" name="radio-btn" id="radio2"> <input
									type="radio" name="radio-btn" id="radio3"> <input
									type="radio" name="radio-btn" id="radio4">

								<!-- Slides -->
								<div class="slides">
									<div class="slide first">
										<a href="#"><img src="images/home.jpg" alt="Slide 1"></a>
									</div>
									<div class="slide">
										<a href="#"><img src="images/lockscreen.jpg" alt="Slide 2"></a>
									</div>
									<div class="slide">
										<a href="#"><img
											src="images/sukuna-purple-5120x2880-16958.png" alt="Slide 3"></a>
									</div>
									<div class="slide">
										<a href="#"><img
											src="images/wallpapersden.com_horseman-in-forest-dark-night_1920x1080.jpg"
											alt="Slide 4"></a>
									</div>
								</div>

								<!-- Navigation buttons -->
								<div class="navigation-manual">
									<label for="radio1" class="manual-btn"></label> <label
										for="radio2" class="manual-btn"></label> <label for="radio3"
										class="manual-btn"></label> <label for="radio4"
										class="manual-btn"></label>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>


	<br>

	<hr class="line_hr">




	<section id="items_sider">
		<div class="carousel">
			<h3>All Products</h3>
			<div class="carousel-inner-wrapper">
				<div class="carousel-inner" id="carouselItems">
					<!-- Each .col is a product card -->
					<div class="col">
						<div class="card shadow">
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
						<div class="card shadow">
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
						<div class="card shadow">
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
						<div class="card shadow">
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
						<div class="card shadow">
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
						<div class="card shadow">
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
						<div class="card shadow">
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
						<div class="card shadow">
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
						<div class="card shadow">
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
						<div class="card shadow">
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
						<div class="card shadow">
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

		<!-- Arrow controls -->
		<div class="carousel-controls">
			<button onclick="prev()">&#10094;</button>
			<button onclick="next()">&#10095;</button>
		</div>
	</section>


	<br>


	<section id="category_card">
		<h3>All Category</h3>
		<div class="container">

			<div class="item_school_book">
				<a href="#"> <img src="images/home.jpg" alt="school_book">
					<div class="text">School Book</div></a>
			</div>
			<div class="item_Pen">
				<a href="#"><img src="images/lockscreen.jpg" alt="Pen">
					<div class="text">Pen</div></a>
			</div>
			<div class="item_Bag">
				<a href="#"> <img src="images/sukuna-purple-5120x2880-16958.png"
					alt="Bag">
					<div class="text">Bag</div></a>
			</div>
			<div class="item_Pencil">
				<a href="#"> <img
					src="images/wallpapersden.com_horseman-in-forest-dark-night_1920x1080.jpg"
					alt="Pencil">
					<div class="text">Pencil</div></a>
			</div>

		</div>

	</section>



	<%@include file="all_component/footer.jsp"%>

	<!-- JavaScript for auto slide -->
	<script type="text/javascript">
    // Auto image slider
  let counter = 1;
  setInterval(() => {
    document.getElementById('radio' + counter).checked = true;
    counter++;
    if (counter > 4) counter = 1;
  }, 5000);

    // Product carousel navigation (assuming 4 items visible)
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






