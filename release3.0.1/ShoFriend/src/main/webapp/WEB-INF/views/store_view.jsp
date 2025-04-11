<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table width="500" border="1">
		<form method="post" action="store_modify">
			<input type="hidden" name="id" value="${content_view.id}">
			<tr>
				<td>점포번호</td>
				<td>
					${content_view.id}
				</td>
			</tr>

			<tr>
				<td>점포이름</td>
				<td>
<%-- 					${content_view.boardName} --%>
					<input type="text" name="name" value="${content_view.name}">
				</td>
			</tr>
			<tr>
				<td>점포설명</td>
				<td>
<%-- 					${content_view.boardTitle} --%>
					<input type="text" name="description" value="${content_view.description}">
				</td>
			</tr>
			<tr>
				<td>주소</td>
				<td>
<%-- 					${content_view.boardContent} --%>
					<input type="text" name="address" value="${content_view.address}">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="수정">
					&nbsp;&nbsp;<a href="list">목록보기</a>
					&nbsp;&nbsp;<a href="store_delete?id=${content_view.id}">삭제</a>
				</td>
			</tr>
		</form>
	</table>
</body>
</html>













