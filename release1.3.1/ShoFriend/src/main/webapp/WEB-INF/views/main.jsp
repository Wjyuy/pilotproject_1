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
	<script src="${pageContext.request.contextPath}/resources/js/timer.js"></script>
</head>
<body>
	<div align="center" style="overflow: scroll; width: 100%; height: 100%">
		<a href="mypage">마이페이지</a>
		<a href="#">상점</a>
		<a href="#">친구</a>
		<a href="login">로그인</a>
		<h1>쇼프렌입니다</h1>
<!-- 		TODO:추천상품 recommend (order)하고함-->
<!-- 		<a href="category?category_id=9">추천상품</a> -->
		<a href="category?category_id=8">반짝세일</a>
		<a href="category?category_id=1">식품</a>
		<a href="category?category_id=2">가구</a>
		<a href="category?category_id=3">도서</a>
		<a href="category?category_id=4">스포츠/레저</a>
		<a href="category?category_id=5">출산/유아용품</a>
		<a href="category?category_id=6">반려동물용품</a>
		<a href="category?category_id=7">뷰티</a>
		<table>
			<tr>
			   <td colspan="3" style="text-align: center; font-weight: bold; color: #d9534f;">
			        ⏰ 반짝세일! 종료 임박 상품
			        <a href="category?category_id=8">더보기</a>
			    </td>
			</tr>
			
			<c:set var="flashCount" value="0" />
			
			<c:forEach var="dto" items="${flashlist}" varStatus="status">
			   <c:if test="${flashCount < 3}">
			       <c:if test="${flashCount % 3 == 0}">
			           <tr>
			       </c:if>
			
	
	            <td style="max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
	                <a href="content?id=${dto.id}">
	                    <%-- 	<img src="${pageContext.request.contextPath}/resources/images/${dto.picture}" width="200" height="200"/><br> --%>
				                <img src="${dto.picture}" width="200" height="200"/><br>
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
			
			       <c:set var="flashCount" value="${flashCount + 1}" />
			
			       <c:if test="${flashCount % 3 == 0}">
			           </tr>
			       </c:if>
			   </c:if>
			</c:forEach>
			
			<c:if test="${flashCount > 0 && flashCount % 3 != 0}">
			   </tr>
			</c:if>
				<!-- 		TODO:인기상품 추천 알고리즘로직 생각해봐야함(지금은최신순) -->
			<c:forEach var="category" items="${categorylist}" varStatus="catStatus">
			    <tr>
			        <td colspan="3" style="text-align: center; font-weight: bold; color: #2e6da4;">
			            🔥 ${category.name} 인기상품🔥
			            <a href="category?category_id=${category.id}">더보기</a>
			        </td>
			    </tr>
			
			    <c:set var="count" value="0" />
			
			    <c:forEach var="dto" items="${list}" varStatus="status">
			        <c:if test="${dto.category_id == category.id && count < 3}">
			            <c:if test="${count % 3 == 0}">
			                <tr>
			            </c:if>
			
			            <td style="max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
			             	<a href="content?id=${dto.id}">
<!-- 			             	이미지 안나오는 문제 해결 위해 api이용했습니다! 주석경로는 sts /resources/images/ 유저가 업로드 경로 -->
<%-- 				                <img src="${pageContext.request.contextPath}/resources/images/${dto.picture}" width="200" height="200"/><br> --%>
				                <img src="${dto.picture}" width="200" height="200"/><br>
				                <c:choose>
								    <c:when test="${dto.status == '품절'}">
								        <span title="${dto.title}">
								            <del>${dto.title}</del>
								            <span style="color: red; font-weight: bold;"> [품절]</span>
								        </span><br>
								    </c:when>
								    <c:otherwise>
								        <span title="${dto.title}">${dto.title}</span><br>
								    </c:otherwise>
								</c:choose>

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
		    	<a href="content?id=${dto.id}">
		    <%-- 	<img src="${pageContext.request.contextPath}/resources/images/${dto.picture}" width="200" height="200"/><br> --%>
		                <img src="${dto.picture}" width="200" height="200"/><br>
<!-- 				    TODO: 세션받아서 손님일땐 숨김안보이기 셀러일땐 숨김보이기 -->
	                <c:choose>
					    <c:when test="${dto.status == '품절'}">
					        <span title="${dto.title}">
					            <del>${dto.title}</del>
					            <span style="color: red; font-weight: bold;"> [품절]</span>
					        </span><br>
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
		
		    <c:if test="${status.index % 3 == 2 || status.last}">
		        </tr>
		    </c:if>
		</c:forEach>
		
		</table>
	</div>
</body>
</html>