<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>${product.title} 상세페이지</title>
	<script src="${pageContext.request.contextPath}/resources/js/timer.js"></script>
</head>
<body>
	<a href="main">홈으로가기</a>
	<hr>
    <%-- 	<img src="${pageContext.request.contextPath}/resources/images/${product.picture}" width="200" height="200"/><br> --%>
    <img src="${product.picture}" width="200" height="200"/><br>
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
	    </c:when>
	    <c:otherwise>
	        <fmt:formatNumber value="${product.price}" pattern="#,###" />원
	    </c:otherwise>
	</c:choose>
	<br>
	<input type="button" value="손님기능-구매하기">
	<input type="button" value="판매자기능-수정하기" onclick="location.href='product_modify?id=${product.id}'">
	<hr>
	<p>${product.description}</p>
    
</body>
</html>
