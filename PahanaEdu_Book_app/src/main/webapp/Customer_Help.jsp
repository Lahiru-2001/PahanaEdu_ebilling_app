<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="com.DB.DBConnecter"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer-Help Page</title>
<%@include file="all_component/all_css.jsp"%>
</head>

<body>
	<%@include file="all_component/navbar.jsp"%>
	<section id="card_slider">
		<div class="container-sm">
			<div class="row justify-content-center">
				<div class="col-md-10">
					<div class="card shadow border-0">
						<div class="card-body">
							<div class="row g-4 align-items-start">

								<!-- Welcome Card -->
								<div class="col-md-6">
									<div class="card" id="welcom_card">
										<div class="card-body">
											<h2 class="card-title">
												Welcome,<br> PahanaEdu Book Online Web App
											</h2>
											<p class="card-text mt-3">Need help with your experience?
												Submit your issue using the form, and we'll get back to you
												shortly. We're here to assist with anything from,</p>
											<ul>
												<li>Orders</li>
												<li>Account Access</li>
												<li>Technical Issues</li>
											</ul>
											<p>And, any othere problams</p>



										</div>
									</div>
								</div>

								<!-- Help Form Card -->
								<div class="col-md-6">
									<div class="card" id="help_card">
										<div class="card-body">
											<h4 class="mb-4">Submit a Help Request</h4>
											<%
											String succMsg = (String) session.getAttribute("succMsg");
											String failedMsg = (String) session.getAttribute("failedMsg");

											if (succMsg != null) {
											%>
											<p class="text-success"><%=succMsg%></p>
											<%
											session.removeAttribute("succMsg");
											}

											if (failedMsg != null) {
											%>
											<p class="text-danger"><%=failedMsg%></p>
											<%
											session.removeAttribute("failedMsg");
											}
											%>

											<form action="customer_help" method="post">
												<div class="mb-3">
													<label for="title" class="form-label">Help Title</label> <input
														type="text" class="form-control" id="title" name="title"
														required placeholder="Enter your issue title">
												</div>
												<div class="mb-3">
													<label for="message" class="form-label">Message /
														Description</label>
													<textarea class="form-control" id="message" name="message"
														rows="5" required
														placeholder="Describe your issue or question..."></textarea>
												</div>
												<button type="submit" class="btn btn-success text-white"
													style="background-color: #28a745">Submit Help
													Request</button>
											</form>
										</div>
									</div>
								</div>
							</div>
							<!-- end row -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>


	<%@include file="all_component/footer.jsp"%>
</body>
</html>