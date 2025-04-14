<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<!-- * 25/04/08 성유리  -->
<!-- * customerlogin : 구매자 로그인 -->
<!-- * sellerlogin : 판매자 로그인 -->

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${not empty requestScope.msg and requestScope.msg ne ''}">
	    <script>
	        alert("${requestScope.msg}");
	    </script>
	</c:if>
	<form method="post" action="customer_login">
		<button type="submit" class="btn btn-primary btn-lg">구매자</button>
	</form>
	
	<form method="post" action="seller_login">
		<button type="submit" class="btn btn-secondary btn-lg">판매자</button>
	</form>
</body>
</html>