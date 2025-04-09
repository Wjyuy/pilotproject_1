<!-- product 출력, 지금구현된건 메인보단 카테고리단임-->
<!-- taglib fmt 이용해서 단위표현,/resources/images/${dto.picture} 이미지출력-->
<!-- 작성일      작성자   개발내용,수정내용 -->
<!-- 25/04/07    우주연-->
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
<body>
	<a href="main">홈으로가기</a>
	<div align="center" style="overflow: scroll; width: 100%; height: 100%">
	
	<!-- ✅ 카테고리 8번일 경우: flashlist 출력 -->
	<c:if test="${category_id == '8'}">
	    <h2 style="color: orange;">⏰ 반짝세일 상품</h2>
	    <table>
	        <c:forEach var="dto" items="${flashlist}" varStatus="status">
	            <c:if test="${status.index % 3 == 0}">
	                <tr>
	            </c:if>
	
	            <td style="max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
	                <a href="content?id=${dto.id}">
	                    <img src="${pageContext.request.contextPath}/resources/images/${dto.picture}" width="200" height="200" /><br>
	                    <c:choose>
	                        <c:when test="${dto.status == '품절'}">
	                            <del>${dto.title}</del>
	                            <span style="color: red;">[품절]</span><br>
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
	
	            <c:if test="${status.index % 3 == 2 || status.last}">
	                </tr>
	            </c:if>
	        </c:forEach>
	    </table>
	</c:if>
	
	<!-- ✅ 그 외 카테고리: 일반 상품 출력 -->
	<c:if test="${category_id != '8'}">
	    <table>
	        <c:set var="count" value="0" />
	        <c:forEach var="dto" items="${list}">
	            <c:if test="${dto.category_id == category_id}">
	                <c:if test="${count % 3 == 0}">
	                    <tr>
	                </c:if>
	
	                <td style="max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
	                    <a href="content?id=${dto.id}">
	                        <img src="${pageContext.request.contextPath}/resources/images/${dto.picture}" width="200" height="200" /><br>
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

