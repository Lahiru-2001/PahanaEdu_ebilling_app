<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
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
        <c:when test="${empty sessionScope.loggedUser or sessionScope.role != 'customer'}">
            <c:redirect url="Login.jsp" />
        </c:when>
        <c:otherwise>
            <c:if test="${not empty sessionScope.customer}">
                <h2>Welcome, ${sessionScope.customer.firstName} ${sessionScope.customer.lastName}</h2>
                <p>Account Number: ${sessionScope.customer.accountNumber}</p>
                <p>Customer ID: ${sessionScope.customer.customerId}</p>
                <!-- other customer data -->
            </c:if>
            <c:if test="${empty sessionScope.customer}">
                <p>Customer details are not available. Please contact support.</p>
            </c:if>
        </c:otherwise>
    </c:choose>
<%@include file="all_component/footer.jsp"%>
</body>
</html>






 