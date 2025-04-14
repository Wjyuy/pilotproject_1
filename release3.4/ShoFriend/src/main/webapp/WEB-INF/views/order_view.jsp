<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>주문 내역</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product_insert.css ">
</head>

<body>
<div class ="container">
	<h2 class="text-center" style="margin-bottom: 50px; font-size: 40px;"><b>나의 주문 목록</b></h2>

		<table class="table table-hover" border="1" align="center">
		<thead>
			<tr>
				<th scope="col">주문번호</th>
				<th scope="col">상품 ID</th>
				<th scope="col">총금액</th>
				<th scope="col">주문일자</th>
				<th scope="col">상태</th>
			</tr>
		</thead>
		<tbody>	
			<c:forEach var="order" items="${orderList}">
				<tr>
					<td>${order.id}</td>
					<td>${order.product_id}</td>
					<td>${order.total_price}</td>
					<td>${order.created_at}</td>
					<td>${order.status}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
<!-- 		밋밋해서 그냥 넣어본 툴바.. 동작은 안함 -->
		<div style="display:flex; justify-content:center; margin-top: 70px;">
		<div class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups">
  <div class="btn-group me-2" role="group" aria-label="First group">
    <button type="button" class="btn btn-primary">1</button>
    <button type="button" class="btn btn-primary">2</button>
    <button type="button" class="btn btn-primary">3</button>
    <button type="button" class="btn btn-primary">4</button>
  </div>
  </div>
  </div>
 </div>
 
</body>
</html>