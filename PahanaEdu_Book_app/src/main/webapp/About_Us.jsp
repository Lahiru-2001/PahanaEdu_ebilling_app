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
						<p>Welcome to Pahana Edu, a leading bookshop in the heart of
							Colombo City, proudly serving hundreds of customers each month.
							With a passion for knowledge and a dedication to exceptional
							service, we are committed to providing a modern and efficient
							shopping experience. In our journey to better serve our valued
							customers, we are introducing a computerized, web-based system to
							manage billing information seamlessly. Each customer is assigned
							a unique account number, and our system ensures quick and
							accurate registration by securely collecting essential details
							such as name, address, telephone number, and purchase history.</p>
					</div>

					<section class="about">

						<div class="about-content"> 

							<div class="luxury-image">
								<img src="images/Book-Shop-2.jpg" alt="Luxurious Comfort">
							</div>
							<br>
							<p>At Pahana Edu, we believe in blending the warm, personal
								touch of a traditional bookstore with the convenience and
								efficiency of modern technology. Whether you are visiting our
								shop in person or exploring our upcoming online services, we are
								here to ensure your experience is smooth, enjoyable, and
								tailored to your needs. Your satisfaction is our top priority,
								and we look forward to serving you for many more years to come.</p>
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
							class="fa-brands fa-square-facebook" style="color: #135bd8;"></i></a>
						<a href="#" target="_blank" class="icon-link"><i
							class="fa-brands fa-square-x-twitter"></i> </a> <a href="#"
							target="_blank" class="icon-link"><i
							class="fa-brands fa-square-instagram" style="color: #050505;"></i></a>
					</div>
				</div>


			</div>
		</div>

	</section>

	<%@include file="all_component/footer.jsp"%>

</body>
</html>
