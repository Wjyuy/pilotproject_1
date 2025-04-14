<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/info.css">
<script src="${pageContext.request.contextPath}/resources/js/script.js"></script>
</head>
<!-- 25/04/14    김채윤   프론트엔드 적용 -->
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


<c:choose>
    <c:when test="${sessionScope.userType == 'customer' || sessionScope.userType == 'seller'}">
        <div class="container">
            <div class="form-box">
                <h2 class="text-center fw-bold">비밀번호 변경</h2>
                <form name="pwd_frm" method="post" action="updatePwdOk">
                    <label class="form-label mt-4">새 비밀번호: </label>
                    <input type="password" class="form-control w-100" name="new_pwd" required />
                    <input type="button" style="margin-top:20px;" class="btn btn-primary w-100" value="변경하기" onclick="update_pwd()" />
                </form>

                <c:choose>
                    <c:when test="${sessionScope.userType == 'customer'}">
                        <div class="text-end mt-4">
                            <button class="btn btn-outline-secondary btn-sm" onclick="location.href='customer_info'">내 정보 보기</button>
                        </div>
                    </c:when>
                    <c:when test="${sessionScope.userType == 'seller'}">
                        <div class="text-end mt-4">
                            <button class="btn btn-outline-secondary btn-sm" onclick="location.href='seller_info'">내 정보 보기</button>
                        </div>
                    </c:when>
                </c:choose>

            </div>
        </div>
    </c:when>

    <c:otherwise>
        <div class="text-center mt-5">
            <p>로그인이 필요합니다.</p>
            <a href="login">로그인 페이지로 이동</a>
        </div>
    </c:otherwise>
</c:choose>

</body>
</html>