<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<!-- * 25.04.10 권준우 최초 작성 -->
<!-- 25/04/14    김채윤   프론트엔드 적용 -->
</head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/info.css ">
<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
<script>
	function updateInfo2(field) {
// 		alert("업데이트 함수 도달: " + field);  // 작동 확인
		const newValue = document.getElementById(field + "_input").value;

		$.ajax({
			type: "post",
			url: "updateSellerInfo",
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
<c:choose>
		    
		    <c:when test="${sessionScope.userType == 'customer'}">
		   <nav class="nav justify-content-end">
		        <a class="nav-link disabled" aria-disabled="true">${sessionScope.loginCustomer.name} 님은 <b>customer</b> 입니다.</a>
   				<a class="nav-link" href="main">홈으로가기</a>
				<a class="nav-link" aria-current="page" href="my_page">마이페이지</a>
				<a class="nav-link" href="friend">친구</a>
<%-- 				<a class="nav-link disabled" aria-disabled="true"><u>${sessionScope.loginCustomer.name} 님 </u></a> --%>
				<a class="nav-link" href="logout">로그아웃</a>
			
			</nav>
		    </c:when>
		  
		    <c:when test="${sessionScope.userType == 'seller'}">
		    <nav class="nav justify-content-end">
		     <a class="nav-link disabled" aria-disabled="true">${sessionScope.loginSeller.name} 님은 <b>seller</b> 입니다.</a>
<!-- 		        <p>당신의 로그인 타입 : <b>seller</b></p> -->
				<a class="nav-link" href="my_page">마이페이지</a>
				<a class="nav-link" href="#">점포관리</a>
				<a class="nav-link" href="product_insert">상품추가</a>
<%-- 				<u>${sessionScope.loginSeller.name} 님 </u> --%>
				<a class="nav-link" href="logout">로그아웃</a>
				</nav>
		    </c:when>
		    <c:otherwise>
		        <p>로그인 상태가 아닙니다.</p>
				<a href="my_page">마이페이지</a>
				<a href="friend">친구</a>
				<a href="login">로그인</a>
		    </c:otherwise>
		   
		</c:choose>
<div class ="container">
<div class ="form-box">
     <h2 class="text-center" style="margin-bottom: 50px; font-weight: bold;">내 정보 확인</h2>

    <c:choose>
        <c:when test="${not empty sessionScope.loginSeller}">
            <table cellpadding="10">
                <tr>
                    <td>아이디(E-mail)</td>
                    <td colspan="2">${loginSeller.email}</td>
                </tr>
<!--                 <tr> -->
<!--                     <td>비밀번호</td> -->
<%--                     <td colspan="2">${loginCustomer.password}</td> --%>
<!--                 </tr> -->
                <tr>
                    <td>이름</td>
                    <td>
                     <div class="d-flex mb-3" style="gap: 8px;">
                    <input type="text" class="form-control form-control-sm" id="name_input" value="${loginSeller.name}">
                    <input type="button" class="btn btn-outline-secondary btn-sm"  value="수정" onclick="updateInfo2('name')" >
                    </div></td>
                </tr>
                <tr>
                    <td>전화번호</td>
                    <td>
                    <div class="d-flex mb-3" style="gap: 8px;">
                    <input type="text" class="form-control form-control-sm" id="phone_input" value="${loginSeller.phone}">
                    <input type="button" class="btn btn-outline-secondary btn-sm" value="수정" onclick="updateInfo2('phone')" >
                    </div>
                    </td>
                </tr>
            </table>
            
<!--             <form action="main" method="get"> -->
<!-- 			   	 <input type="submit" value="메인으로"> -->
<!-- 			</form> -->
			<div class="text-center" style="margin-top:30px;">
			<button class="btn btn-primary" onclick="location.href='main'">메인으로</button>
			<button class="btn btn-primary" onclick="location.href='my_page'">마이페이지</button>
			<button class="btn btn-primary" onclick="location.href='update_pwd'">비밀번호 변경</button>
			</div>
			
			<div class="text-end" style="margin-top:40px;">
            <a href="login">로그인 페이지로 이동</a>
            </div>
             </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-center">
            <p>로그인이 필요합니다.</p>
            <a href="login">로그인 페이지로 이동</a>
            </div>
        </c:otherwise>
    </c:choose>

</body>
</html>