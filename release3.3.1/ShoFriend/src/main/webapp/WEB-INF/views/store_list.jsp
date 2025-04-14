<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
<style>
body{ 
	height: 100vh;
	width: 100%;
	margin: 0;
}
.container {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100%
}
 tbody tr:hover{
 	background-color: #f0f8ff; 
 	cursor:pointer; 
 } 
</style>
</head>
<body>
<div class="container">
<div class = "form-box">
		<h1 class="text-center">점포 관리</h1>
	<table width="500" border="1">
<input type="hidden" name="seller_id" value="${sessionScope.loginSeller.id}">
		<thead>
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
	</div>
	<c:choose>
	    <c:when test="${not empty sessionScope.loginCustomer}">
	        <h3>세션에 저장된 로그인 정보</h3>
	        <ul>
	            <li>ID: ${sessionScope.loginCustomer.id}</li>
	            <li>이름: ${sessionScope.loginCustomer.name}</li>
	            <li>비밀번호: ${sessionScope.loginCustomer.password}</li>
	            <li>이메일: ${sessionScope.loginCustomer.email}</li>
	            <li>전화번호: ${sessionScope.loginCustomer.phone}</li>
	            <li>주소: ${sessionScope.loginCustomer.address}</li>
	        </ul>
	    </c:when>
	    <c:when test="${not empty sessionScope.loginSeller}">
	        <h3>세션에 저장된 로그인 정보</h3>
	        <ul>
	            <li>ID: ${sessionScope.loginSeller.id}</li>
	            <li>이름: ${sessionScope.loginSeller.name}</li>
	            <li>비밀번호: ${sessionScope.loginSeller.password}</li>
	            <li>이메일: ${sessionScope.loginSeller.email}</li>
	            <li>전화번호: ${sessionScope.loginSeller.phone}</li>
	        </ul>
	    </c:when>	    
	    <c:otherwise>
	        <p>로그인 상태가 아닙니다.</p>
	    </c:otherwise>
	</c:choose>
	
	<c:choose>
	    <c:when test="${sessionScope.userType == 'customer'}">
	        <p>당신의 로그인 타입 : <b>customer</b></p>
	    </c:when>
	    <c:when test="${sessionScope.userType == 'seller'}">
	        <p>당신의 로그인 타입 : <b>seller</b></p>
	    </c:when>
	    <c:otherwise>
	        <p>로그인 타입이 세션에 넘어오지 않았습니다.</p>
	    </c:otherwise>
	</c:choose>
</body>
</html>