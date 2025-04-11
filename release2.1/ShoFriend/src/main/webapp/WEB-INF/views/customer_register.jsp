<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="${pageContext.request.contextPath}/resources/js/script.js"></script>
	<script type="text/javascript"></script>

</head>
<body>
	<table border="1" align="center">
		<form name="reg_frm" method="post" action="registerOk">
			<tr height="50">
				<td colspan="2">
					<h1>회원 가입 신청</h1>
				</td>
			<tr height="30">
				<td width="80">
					이름
				</td>
				<td>
					<input type="text" size="20" name="name">
				</td>
			</tr>
			<tr height="30">
				<td width="80">
					USERID(이메일)
				</td>
				<td>
					<input type="text" size="20" name="email">
				</td>
			</tr>

			<tr height="30">
				<td width="80">
					암호
				</td>
				<td>
					<input type="text" size="20" name="password">
				</td>
			</tr>
			<tr height="30">
				<td width="80">
					암호 확인
				</td>
				<td>
					<input type="text" size="20" name="password_check">
				</td>
			</tr>
			<tr height="30">
				<td width="80">
					연락처
				</td>
				<td>
					<input type="text" size="20" name="phone">
				</td>
			</tr>

			<tr height="30">
				<td width="80">
					주소
				</td>
				<td>
					<input type="text" size="20" name="address">
				</td>
			</tr>
			<tr height="30">
				<td colspan="2">
					<input type="button" onclick="check_ok()" value="등록">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>