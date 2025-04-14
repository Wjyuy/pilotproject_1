<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 25/04/08    김채윤   최초 작성 -->
<!-- 25/04/14    김채윤   프론트엔드 적용 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product_insert.css ">
<style>

table{
	width: 100%;
	margin: 0 auto;
}
th, td{
	text-align: center;
}
.logo img{
	display: block;
	max-width: 1000px;
	width: 100%;
	height: auto;
	margin: 0 auto;
}
</style>
</head>
<body>
<c:choose>
		    
		    <c:when test="${sessionScope.userType == 'customer'}">
		   <nav class="nav justify-content-end">
		        <a class="nav-link disabled" aria-disabled="true">${sessionScope.loginCustomer.name} 님은 <b>customer</b> 입니다.</a>
   				<a class="nav-link" href="main">홈으로가기</a>
				<a class="nav-link" aria-current="page" href="my_page">마이페이지</a>
				<a class="nav-link" href="friend">친구</a>
<%-- 				<a class="nav-link disabled" aria-disabled="true"><u>${sessionScope.loginCustomer.name} 님 </u></a> --%>
				<a class="nav-link" href="logout">로그아웃</a>
			
			</nav>
		    </c:when>
		  
		    <c:when test="${sessionScope.userType == 'seller'}">
		    <nav class="nav justify-content-end">
		     <a class="nav-link disabled" aria-disabled="true">${sessionScope.loginSeller.name} 님은 <b>seller</b> 입니다.</a>
<!-- 		        <p>당신의 로그인 타입 : <b>seller</b></p> -->
				<a class="nav-link" href="my_page">마이페이지</a>
				<a class="nav-link" href="#">점포관리</a>
				<a class="nav-link" href="product_insert">상품추가</a>
<%-- 				<u>${sessionScope.loginSeller.name} 님 </u> --%>
				<a class="nav-link" href="logout">로그아웃</a>
				</nav>
		    </c:when>
		    <c:otherwise>
		        <p>로그인 상태가 아닙니다.</p>
				<a href="my_page">마이페이지</a>
				<a href="friend">친구</a>
				<a href="login">로그인</a>
		    </c:otherwise>
		   
		</c:choose>
		<br>
		<br>
		<br>
		<br>
<div class="container">
<div class="logo">
	<img src="resources/images/ShoFriend_rogo.PNG" class="img-fluid" alt="...">
</div>
	<br>
	<br>
	<br>
	<br>
	
	<hr>

		<div style= "margin-top: 50px; margin-bottom: 50px;">
		<h1 class="text-center">점포 관리</h1>
		</div>
	<table class="table table-hover" >
		<thead>
<input type="hidden" name="seller_id" value="${sessionScope.loginSeller.id}">
		<tr>
			<th>점포번호</th>
			<th>점포이름</th>
			<th>점포설명</th>
			<th>주소</th>
		</tr>
		</thead>
		<tbody>
<!-- 		조회결과 -->
		<c:forEach var="dto" items="${store_list}">
			<tr>
				<td>${dto.id}</td>
				<td>
					<a href="store_view?id=${dto.id}">${dto.name}</a>
				</td>
				<td>${dto.description}</td>
				<td>${dto.address}</td>
			</tr>
		</c:forEach>
<!-- 		<tr> -->
<!-- 			<td colspan="5" class="text-center mt-4"> -->
<!-- 				<a href="store_register">점포등록</a> -->

<!-- 			</td> -->
<!-- 		</tr> -->
		</tbody>

	</table>
	<div style="text-align: right; margin-top:10px;">
				<a href="store_register" class="btn btn-primary">점포등록</a>
</div>
	</div>
</body>
</html>