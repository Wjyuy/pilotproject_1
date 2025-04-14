<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/my_page.css ">
</head>
<body>
<div class ="container">
<div class ="form-box">
	<h2 style="font-weight: bold; margin-bottom:40px;">마이 페이지</h2>
	<div class="text-center">
	<button class="btn btn-primary" style="margin-bottom:10px;" onclick="location.href='check_pwd'">내 정보 보기</button><br>
	
    <c:choose>
    	<c:when test="${sessionScope.userType == 'seller'}">
    		<button class="btn btn-primary"  style="margin-bottom:10px;" onclick="location.href='store_list'">점포 관리</button><br>
    	</c:when>
    	<c:when test="${sessionScope.userType == 'customer'}">
    		<button class="btn btn-primary" style="margin-bottom:10px;" onclick="location.href='order_view'" >주문 조회</button><br>
    	</c:when>
    </c:choose>
    	
    <button class="btn btn-outline-secondary" onclick="location.href='logout'">로그아웃</button>
   </div>
   </div>
   </div>
    
<!--     아래는 sesssion 확인용 임시정보 -->
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