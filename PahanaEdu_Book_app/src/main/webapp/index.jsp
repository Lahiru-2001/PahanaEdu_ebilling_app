<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="com.DB.DBConnecter"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PahanaEdu Home Page</title>
<%@include file="all_component/all_css.jsp"%>
</head>

<body>
	<%@include file="all_component/navbar.jsp"%>




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

	<br>

	<section id="items_sider">
		<div class="container mt-5">
			<h2 class="text-center mb-4">All Products</h2>
			<div class="row">


				<div class="col-md-3 mb-4">
					<div class="card shadow">
						<img src="" class="card-img-top" alt=""
							style="height: 200px; object-fit: cover;">
						<div class="card-body">
							<h5 class="card-title">${item.name}</h5>
							<p class="card-text">
								<strong>Price:</strong><br> <strong>Stock:</strong> <br>
								<strong>Category:</strong> <br> <strong>Description:</strong>
							</p>
							<button class="btn btn-primary btn-sm">Add to Cart</button>
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




	<%@include file="all_component/footer.jsp"%>


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
