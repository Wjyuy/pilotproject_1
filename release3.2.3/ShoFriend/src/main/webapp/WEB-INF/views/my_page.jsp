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
</body>
</html>