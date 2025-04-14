<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>주문 내역</title></head>
<body>

	<h2>나의 주문 목록</h2>

		<table border="1" align="center">
			<tr>
				<th>주문번호</th>
				<th>상품 ID</th>
				<th>총금액</th>
				<th>주문일자</th>
				<th>상태</th>
			</tr>
			
			<c:forEach var="order" items="${orderList}">
				<tr>
					<td>${order.id}</td>
					<td>${order.product_id}</td>
					<td>${order.total_price}</td>
					<td>${order.created_at}</td>
					<td>${order.status}</td>
				</tr>
			</c:forEach>
		</table>
 
 
</body>
</html>
