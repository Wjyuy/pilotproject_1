<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table width="500" border="1">

		<tr>
			<td>점포번호</td>
			<td>점포이름</td>
			<td>점포설명</td>
			<td>주소</td>
		</tr>
<!-- 		조회결과 -->
<!-- 		list : 모델객체에서 보낸 이름 -->
		<c:forEach var="dto" items="${list}">
			<tr>
				<td>${dto.id}</td>
<%-- 				<td>${dto.name}</td> --%>
				<td>
<%-- 					${dto.boardTitle} --%>
<!-- 			content_view : 컨트롤러단 호출 -->
					<a href="content_view?id=${dto.id}">${dto.name}</a>
				</td>
				<td>${dto.description}</td>
				<td>${dto.address}</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="5">
			<!-- 			write_view : 컨트롤러단 호출 -->
				<a href="store_register">점포등록</a>
			</td>
		</tr>
	</table>
</body>
</html>