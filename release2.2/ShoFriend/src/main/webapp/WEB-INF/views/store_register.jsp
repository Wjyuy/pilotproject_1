<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/resources/js/script.js"></script>
	<script type="text/javascript"></script>
</head>
<body>
	<table border="1" align="center">
		<form name="storeReg_frm" method="post" action="store_registerOk">
			<tr height="50">
				<td colspan="2">
					<h1 align="center">점포 등록</h1>
				</td>
			<tr height="30">
				<td width="200">
					점포 이름
				</td>
				<td>
					<input type="text" size="50" name="name">
				</td>
			</tr>
			<tr height="30">
				<td width="200">
					점포 설명
				</td>
				<td>
					<textarea rows="15" cols="50" name="description" placeholder="점포를 소개해주세요"></textarea>
				</td>
			</tr>
			<tr height="30">
				<td width="200">
					주소
				</td>
				<td>
					<input type="text" size="50" name="address">
				</td>
			</tr>

			<tr height="30">
				<td colspan="2" align="center">
					<input type="button" onclick="StoreRegi_ok()" value="등록">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>