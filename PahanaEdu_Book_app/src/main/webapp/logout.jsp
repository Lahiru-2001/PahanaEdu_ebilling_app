<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Home Page</title>
<script type="text/javascript">
	function confirmLogout(redirectUrl) {
		if (confirm("Are you sure you want to log out?")) {
			// Redirect to the given URL (e.g., index.jsp or a logout handler)
			window.location.href = redirectUrl;
		} else {
			// Optional: feedback when cancelled
			// alert("Logout cancelled.");
		}
	}
</script>
</head>
<body>
	<!-- Example logout link -->
	<a href="#" onclick="confirmLogout('index.jsp'); return false;">Logout</a>






</body>
</html>
