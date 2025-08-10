<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="com.DB.DBConnecter"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>About Us Page</title>
<%@include file="all_component/all_css.jsp"%>
</head>

<body>
	<%@include file="all_component/navbar.jsp"%>
	<section id="About_us" class="my-5">
		<div class="container">
			<div class="card shadow" id="Edu_About_Us">
				<div class="card-body">

					<div class="heading">
						<h1>About Us</h1>
						<p>Welcome to CINEPLEX, where the magic of movies comes to
							life! Nestled in the heart of Colombo, we are proud to be your
							premier destination for an unparalleled cinematic experience. As
							a beacon of entertainment in the community, CINEPLEX has been a
							cherished destination for movie enthusiasts since 1984.</p>
					</div>
					<div class="container">
						<section class="about">

							<div class="about-content">

								<div class="luxury-image">
									<img src="images/Book-Shop-2.jpg" alt="Luxurious Comfort">
								</div>
								<p>Our user-friendly website makes online shopping a breeze,
									offering a seamless and convenient experience. Visit our
									family-friendly store, where every member of your family will
									feel welcome and enjoy a delightful shopping experience. Our
									friendly and knowledgeable staff are always ready to assist you
									with a smile, ensuring you find everything you need with ease
									and satisfaction.</p>
							</div>
						</section>
					</div>
					<div class="social-container">
						<div class="social-text">
							<p>More updates on our socials:</p>
						</div>
						<!-- Social media icons -->
						<div class="social-icons">
							<a href="#" target="_blank" class="icon-link"><i
								class="fa-brands fa-square-facebook" style="color: #135bd8;"></i>
								<a href="#" target="_blank" class="icon-link"><i
									class="fa-brands fa-square-x-twitter"></i> <a href="#"
									target="_blank" class="icon-link"><i
										class="fa-brands fa-square-instagram" style="color: #050505;"></i></a>
						</div>
					</div>


				</div>
			</div>
		</div>
	</section>

	<%@include file="all_component/footer.jsp"%>

</body>
</html>
