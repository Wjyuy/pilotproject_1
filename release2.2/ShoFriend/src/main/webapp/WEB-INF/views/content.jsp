<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>${product.title} 상세페이지</title>
	<script src="${pageContext.request.contextPath}/resources/js/timer.js"></script>
</head>
<!-- product_id 받아와서 상세페이지 출력-->
<!-- 작성일      작성자   개발내용,수정내용 -->
<!-- 25/04/10    우주연   세션이랑 디자인전까지 완성됨-->
<!-- 25/04/11    우주연   세션추가 -->
<body>
	<a href="main">홈으로가기</a>
	<c:choose>
		    <c:when test="${sessionScope.userType == 'customer'}">
		        <p>당신의 로그인 타입 : <b>customer</b></p>
				<a href="my_page">마이페이지</a>
				<a href="friend">친구</a>
				<a href="logout">로그아웃</a>
		    </c:when>
		    <c:when test="${sessionScope.userType == 'seller'}">
		        <p>당신의 로그인 타입 : <b>seller</b></p>
				<a href="my_page">마이페이지</a>
				<a href="logout">로그아웃</a>
				<a href="#">점포관리</a>
				<a href="product_insert">상품추가</a>
		    </c:when>
		    <c:otherwise>
		        <p>로그인 상태가 아닙니다.</p>
				<a href="my_page">마이페이지</a>
				<a href="friend">친구</a>
				<a href="login">로그인</a>
		    </c:otherwise>
		</c:choose>
		<h1>쇼프렌입니다</h1>
	<hr>
   	<img src="${pageContext.request.contextPath}/resources/images/${product.picture}" width="200" height="200"/><br>
<%--     <img src="${product.picture}" width="200" height="200"/><br> --%>
    <h2>${product.title}</h2>
    <strong>가게번호:</strong> ${product.store_id}<br>
    <p>
	  카테고리: 
	  <c:forEach var="cat" items="${categorylist}">
	    <c:if test="${cat.id == product.category_id}">
	      ${cat.name}
	    </c:if>
	  </c:forEach>
	</p>
	<strong>재고:</strong> ${product.stock}개<br>
    <c:choose>
    	<c:when test="${product.status == '품절'}">
    		<span style="color: red;">해당 상품은 품절입니다. </span><br>
    	</c:when>
    	<c:when test="${product.status == '숨김'}">
    		<span style="color: red;">해당 상품은 숨김상태입니다. </span><br>
    	</c:when>
    </c:choose>
    
	<c:set var="now" value="<%= new java.util.Date() %>" />
    <c:choose>
	    <c:when test="${product.discount_start <= now and now <= product.discount_end}">
	        <del><fmt:formatNumber value="${product.price}" pattern="#,###" />원</del> ${product.discount_percentage}%<br>
	        <strong><fmt:formatNumber value="${product.price - (product.price * product.discount_percentage / 100)}" pattern="#,###" />원</strong>
			<br>
			
		    <small class="time-left"
				data-end-time="<fmt:formatDate value='${product.discount_end}' pattern='yyyy-MM-dd\'T\'HH:mm:ss' />">
			</small> 
			<small> 남았습니다! </small>
	    </c:when>
	    <c:otherwise>
	        <fmt:formatNumber value="${product.price}" pattern="#,###" />원
	    </c:otherwise>
	</c:choose>
	<br>
	<c:choose>
		<c:when test="${sessionScope.userType == 'customer'}">
			<input type="button" onclick="location.href='product_order?id=${product.id}'" value="구매하기 > order 추가하기 ! ">
		</c:when>
		<c:when test="${sessionScope.userType == 'seller'}">
			<input type="button" value="본인가게일때만추가필요-수정하기" onclick="location.href='product_modify?id=${product.id}'">
			<input type="button" value="본인가게일때만추가필요-삭제하기" onclick="location.href='product_delete?id=${product.id}'">
		</c:when>
		<c:otherwise>
			<input type="button" value="구매하기-세션없을때는 구매튕기고>로그인가도록! ">
		</c:otherwise>
	</c:choose>
	
	<hr>
	<p>${product.description}</p>
    
</body>
</html>
