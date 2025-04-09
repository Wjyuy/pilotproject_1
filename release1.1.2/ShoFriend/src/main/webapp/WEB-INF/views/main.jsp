<!-- product 출력, 지금구현된건 메인보단 카테고리단임-->
<!-- taglib fmt 이용해서 단위표현,/resources/images/${dto.picture} 이미지출력-->
<!-- 작성일      작성자   개발내용,수정내용 -->
<!-- 25/04/07    우주연-->
<!-- TODO : 추천상품 카테고리는 등록으로 가는게 이상함  -->
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
		<a href="mypage">마이페이지</a>
		<a href="#">상점</a>
		<a href="#">친구</a>
		<a href="login">로그인</a>
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
			<c:forEach var="category" items="${categorylist}" varStatus="catStatus">
			    <!-- 카테고리 제목 -->
			    <tr>
			        <td colspan="3" style="text-align: center; font-weight: bold; color: #2e6da4;">
			            🔥 ${category.name} 인기상품 🔥
			            <a href="category?category_id=${category.id}">더보기</a>
			        </td>
			    </tr>
			
			    <c:set var="count" value="0" />
			
			    <!-- 상품 목록 중, 해당 카테고리와 일치하는 상품만 출력 -->
			    <c:forEach var="dto" items="${list}" varStatus="status">
			        <c:if test="${dto.category_id == category.id && count < 3}">
			            <c:if test="${count % 3 == 0}">
			                <tr>
			            </c:if>
			
			            <td style="max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
			                <img src="${pageContext.request.contextPath}/resources/images/${dto.picture}" width="200" height="200"/><br>
			                <span title="${dto.title}">${dto.title}</span><br>
			                <c:set var="now" value="<%= new java.util.Date() %>" />
			                <c:choose>
			                    <c:when test="${dto.discount_start <= now and now <= dto.discount_end}">
			                        <del><fmt:formatNumber value="${dto.price}" pattern="#,###" />원</del> ${dto.discount_percentage}%<br>
			                        <strong><fmt:formatNumber value="${dto.price - (dto.price * dto.discount_percentage / 100)}" pattern="#,###" />원</strong>
			                    </c:when>
			                    <c:otherwise>
			                        <fmt:formatNumber value="${dto.price}" pattern="#,###" />원
			                    </c:otherwise>
			                </c:choose>
			            </td>
			
			            <c:set var="count" value="${count + 1}" />
			            <c:if test="${count % 3 == 0}">
			                </tr>
			            </c:if>
			        </c:if>
			    </c:forEach>
			
			    <!-- 만약 마지막 상품이 3의 배수가 아니면 tr을 닫아줌-->
			    <c:if test="${count > 0 && count % 3 != 0}">
			        </tr>
			    </c:if>
			</c:forEach>
		<table>
        <tr>
            <td colspan="3" align="left" style="text-align: left; font-weight: bold; color: #f44336; ">
                최신 등록된 상품들 🔥
            </td>
        </tr>
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