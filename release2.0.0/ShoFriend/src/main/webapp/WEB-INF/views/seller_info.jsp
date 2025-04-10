<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<!-- * 25.04.10 권준우 최초 작성 -->

</head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
<script>
	function updateInfo(field) {
// 		alert("업데이트 함수 도달: " + field);  // 작동 확인
		const newValue = document.getElementById(field + "_input").value;

		$.ajax({
			type: "post",
			url: "updateCustomerInfo",
			data: {
				field: field,
				value: newValue
			},
			success: function(response) {
				alert("수정 완료!");
				location.reload();
			},
			error: function() {
				alert("수정 실패!");
			}
		});
	}
</script>
<body>
    <h2>내 정보 확인</h2>

    <c:choose>
        <c:when test="${not empty sessionScope.loginCustomer}">
            <table border="1" cellpadding="10">
                <tr>
                    <td>아이디(E-mail)</td>
                    <td colspan="2">${loginCustomer.email}</td>
                </tr>
<!--                 <tr> -->
<!--                     <td>비밀번호</td> -->
<%--                     <td colspan="2">${loginCustomer.password}</td> --%>
<!--                 </tr> -->
                <tr>
                    <td>이름</td>
                    <td><input type="text" id="name_input" value="${loginCustomer.name}"></td>
                    <td><input type="button" value="수정" onclick="updateInfo('name')" ></td>
                </tr>
                <tr>
                    <td>전화번호</td>
                    <td><input type="text" id="phone_input" value="${loginCustomer.phone}"></td>
                    <td><input type="button" value="수정" onclick="updateInfo('phone')" ></td>
                </tr>
                <tr>
                    <td>주소</td>
<%--                     <td><input type="text" name="name" value="${loginCustomer.address}"></td> --%>
                    <td><input type="text" id="address_input" value="${loginCustomer.address}"></td>
                    <td><input type="button" value="수정" onclick="updateInfo('address')" ></td>
                </tr>
            </table>
            
<!--             <form action="main" method="get"> -->
<!-- 			   	 <input type="submit" value="메인으로"> -->
<!-- 			</form> -->
			
			<button onclick="location.href='main'">메인으로</button>
			<button onclick="location.href='my_page'">마이페이지</button>
			<button onclick="location.href='update_pwd'">비밀번호 변경</button>
        </c:when>
        <c:otherwise>
            <p>로그인이 필요합니다.</p>
            <a href="login">로그인 페이지로 이동</a>
        </c:otherwise>
    </c:choose>

    <br>
    <br>

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
	            <li>주소상세: ${sessionScope.loginCustomer.address2}</li>
	            <li>우편번호: ${sessionScope.loginCustomer.zipcode}</li>
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
	        <p>로그인 세션이 없습니다.</p>
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
	        <p>로그인 상태가 아닙니다.</p>
	    </c:otherwise>
	</c:choose>
</body>
</html>
