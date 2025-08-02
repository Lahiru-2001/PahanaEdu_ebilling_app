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

<%
Connection con = DBConnecter.getcon();
if (con != null) {
    out.println("<h3 style='color:green;'>Connection Successful</h3>");
} else {
    out.println("<h3 style='color:red;'>Connection Failed</h3>");
}
%>
	<%@include file="all_component/footer.jsp"%>
</body>
</html>
