<!-- product 출력, 지금구현된건 메인보단 카테고리단임-->
<!-- taglib fmt 이용해서 단위표현,/resources/images/${dto.picture} 이미지출력-->
<!-- 작성일      작성자   개발내용,수정내용 -->
<!-- 25/04/07    우주연-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div align="center" style="overflow: scroll; width: 100%; height: 100%">
		<h1>쇼프렌입니다</h1>
		<a href="category?category_id=1">추천상품</a>
		<a href="category?category_id=2">반짝세일</a>
		<a href="category?category_id=3">식품</a>
		<a href="category?category_id=4">가구</a>
		<a href="category?category_id=5">도서</a>
		<a href="category?category_id=6">스포츠/레저</a>
		<a href="category?category_id=7">출산/유아용품</a>
		<a href="category?category_id=8">반려동물용품</a>
		<a href="category?category_id=9">뷰티</a>
		<table>
		<c:forEach var="dto" items="${list}" varStatus="status">
		    <c:if test="${status.index % 3 == 0}">
		        <tr>
		    </c:if>
		
		    <td style="max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
			    <img src="${pageContext.request.contextPath}/resources/images/${dto.picture}" width="200" height="200"/><br>
			    <span title="${dto.title}">
			        ${dto.title}
			    </span><br>
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
			</td>
		
		    <c:if test="${status.index % 3 == 2 || status.last}">
		        </tr>
		    </c:if>
		</c:forEach>
		
<%-- 			<c:forEach var="dto" items="${list}"> --%>
<!-- 				<tr> -->
<!-- 					<td> -->
<%-- 						<img src="${pageContext.request.contextPath}/resources/images/${dto.id}.jpg" width="200" height="200"/><br> --%>
<%-- 						${dto.title}<br> --%>
<%-- 						<fmt:formatNumber value="${dto.price}" pattern="#,###" />원 --%>
<!-- 					</td> -->
<!-- 				</tr> -->
<%-- 			</c:forEach> --%>
		</table>
	</div>
</body>
</html>