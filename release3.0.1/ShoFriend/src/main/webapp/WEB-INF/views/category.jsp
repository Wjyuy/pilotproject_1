<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String categoryParam = request.getParameter("category_id");
    pageContext.setAttribute("category_id", categoryParam);
%>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리별 상품 출력</title>
	<script src="${pageContext.request.contextPath}/resources/js/timer.js"></script>
</head>
<!-- TODO: 숨김상태 본인 가게만 출력되게 해야함 -->
<!-- category_id 받아와서 카테고리 출력-->
<!-- taglib fmt 이용해서 단위표현,/resources/images/${dto.picture} 이미지출력-->
<!-- 작성일      작성자   개발내용,수정내용 -->
<!-- 25/04/07    우주연  -->
<!-- 25/04/10    우주연   일반카테고리,반짝세일까지 구현완료-->
<!-- 25/04/11    우주연   세션추가 -->
<body>
	<a href="main">홈으로가기</a>
	<div align="center" style="overflow: scroll; width: 100%; height: 100%">
		<c:choose>
		    <c:when test="${sessionScope.userType == 'customer'}">
		        <p>당신의 로그인 타입 : <b>customer</b></p>
				<a href="my_page">마이페이지</a>
				<a href="friend">친구</a>
				<u>${sessionScope.loginCustomer.name} 님 </u>
				<a href="logout">로그아웃</a>
		    </c:when>
		    <c:when test="${sessionScope.userType == 'seller'}">
		        <p>당신의 로그인 타입 : <b>seller</b></p>
				<a href="my_page">마이페이지</a>
				<a href="#">점포관리</a>
				<a href="product_insert">상품추가</a>
				<u>${sessionScope.loginSeller.name} 님 </u>
				<a href="logout">로그아웃</a>
		    </c:when>
		    <c:otherwise>
		        <p>로그인 상태가 아닙니다.</p>
				<a href="my_page">마이페이지</a>
				<a href="friend">친구</a>
				<a href="login">로그인</a>
		    </c:otherwise>
		</c:choose>
		<h1>쇼프렌입니다</h1>
		<a href="category?category_id=8">반짝세일</a>
		<a href="category?category_id=1">식품</a>
		<a href="category?category_id=2">가구</a>
		<a href="category?category_id=3">도서</a>
		<a href="category?category_id=4">스포츠/레저</a>
		<a href="category?category_id=5">출산/유아용품</a>
		<a href="category?category_id=6">반려동물용품</a>
		<a href="category?category_id=7">뷰티</a>
		
		
	<c:if test="${category_id == '8'}">
	    <h2 style="color: orange;">⏰ 반짝세일 상품</h2>
	    <table>
	        <c:set var="count" value="0" />
	        <c:forEach var="dto" items="${flashlist}">
	            <!-- seller가 아니고 숨김이면 출력 안함 -->
	            <c:if test="${dto.status != '숨김' or sessionScope.userType == 'seller'}">
	                <c:if test="${count % 3 == 0}">
	                    <tr>
	                </c:if>
	
	                <td style="max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
	                    <a href="content?id=${dto.id}">
	                        <img src="${pageContext.request.contextPath}/resources/images/${dto.picture}" width="200" height="200" /><br>
	
	                        <c:choose>
	                            <c:when test="${dto.status == '품절'}">
	                                <span style="color: red;">[품절]</span>
	                                <del>${dto.title}</del><br>
	                            </c:when>
	                            <c:when test="${dto.status == '숨김' and sessionScope.userType == 'seller'}">
	                                <span style="color: red;">[숨김]</span>
	                                <del>${dto.title}</del><br>
	                            </c:when>
	                            <c:otherwise>
	                                ${dto.title}<br>
	                            </c:otherwise>
	                        </c:choose>
	
	                        <del><fmt:formatNumber value="${dto.price}" pattern="#,###" />원</del> ${dto.discount_percentage}%<br>
	                        <strong style="color: red;">
	                            <fmt:formatNumber value="${dto.price - (dto.price * dto.discount_percentage / 100)}" pattern="#,###" />원
	                        </strong><br>
	
	                        <small class="time-left"
	                            data-end-time="<fmt:formatDate value='${dto.discount_end}' pattern='yyyy-MM-dd\'T\'HH:mm:ss' />">
	                            ⏰ 종료까지 ${hours}시간 ${minutes}분 ${seconds}초 남았어요!
	                        </small>
	                    </a>
	                </td>
	
	                <c:set var="count" value="${count + 1}" />
	                <c:if test="${count % 3 == 0}">
	                    </tr>
	                </c:if>
	            </c:if>
	        </c:forEach>
	
	        <c:if test="${count > 0 && count % 3 != 0}">
	            </tr>
	        </c:if>
	    </table>
	</c:if>
	
	
	<c:if test="${category_id != '8'}">
	    <table>
	        <c:forEach var="cat" items="${categorylist}">
	            <c:if test="${cat.id == category_id}">
	                <h2 style="color: orange;">${cat.name} 카테고리</h2>
	            </c:if>
	        </c:forEach>
	
	        <c:set var="count" value="0" />
	        <c:forEach var="dto" items="${list}">
	            <!-- seller가 아니고 숨김이면 출력 안함 -->
	            <c:if test="${dto.category_id == category_id && (dto.status != '숨김' || sessionScope.userType == 'seller')}">
	                <c:if test="${count % 3 == 0}">
	                    <tr>
	                </c:if>
	
	                <td style="max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
	                    <a href="content?id=${dto.id}">
	                        <img src="${pageContext.request.contextPath}/resources/images/${dto.picture}" width="200" height="200" /><br>
	
	                        <c:choose>
	                            <c:when test="${dto.status == '품절'}">
	                                <span style="color: red; font-weight: bold;"> [품절]</span>
	                                <del>${dto.title}</del><br>
	                            </c:when>
	                            <c:when test="${dto.status == '숨김' && sessionScope.userType == 'seller'}">
	                                <span style="color: red;">[숨김]</span>
	                                <del>${dto.title}</del><br>
	                            </c:when>
	                            <c:otherwise>
	                                <span title="${dto.title}">${dto.title}</span><br>
	                            </c:otherwise>
	                        </c:choose>
	
	                        <c:set var="now" value="<%= new java.util.Date() %>" />
	                        <c:choose>
	                            <c:when test="${dto.discount_start <= now and now <= dto.discount_end}">
	                                <del>
	                                    <fmt:formatNumber value="${dto.price}" pattern="#,###" />원
	                                </del> ${dto.discount_percentage}%<br>
	                                <strong>
	                                    <fmt:formatNumber value="${dto.price - (dto.price * dto.discount_percentage / 100)}" pattern="#,###" />원
	                                </strong>
	                            </c:when>
	                            <c:otherwise>
	                                <fmt:formatNumber value="${dto.price}" pattern="#,###" />원
	                            </c:otherwise>
	                        </c:choose>
	                    </a>
	                </td>
	
	                <c:set var="count" value="${count + 1}" />
	                <c:if test="${count % 3 == 0}">
	                    </tr>
	                </c:if>
	            </c:if>
	        </c:forEach>
	
	        <c:if test="${count > 0 && count % 3 != 0}">
	            </tr>
	        </c:if>
	    </table>
	</c:if>

	</div>
</body>
</html>

