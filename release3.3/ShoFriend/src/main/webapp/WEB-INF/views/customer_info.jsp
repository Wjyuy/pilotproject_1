<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<!-- * 25.04.08 권준우 최초 작성 -->

</head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function updateInfo() {
// 		alert("업데이트 함수 도달");  // 작동 확인
		const name = document.getElementById("name_input").value;
		const phone = document.getElementById("phone_input").value;
		const address = document.getElementById("address_input").value;
		const address1 = document.getElementById("address1_input").value;
		const zipcode = document.getElementById("zipcode_input").value;
//		alert("변환 정상작동");  // 작동 확인
		
		$.ajax({
			type: "post",
			url: "updateCustomerInfo",
			data: {
				name: name,
				phone: phone,
				address: address,
				address1: address1,
				zipcode: zipcode
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
	
	function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                 
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
//                     표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
//                     조합된 참고항목을 해당 필드에 넣는다. //address1 사용안해서 주석처리 04.10
//                     document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
//                    document.getElementById("sample6_extraAddress").value = ''
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("zipcode_input").value = data.zonecode;
                document.getElementById("address_input").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address1_input").focus();
            }
        }).open();
    }
</script>
<body>
    <h2>내 정보 확인</h2>

    <c:choose>
        <c:when test="${not empty sessionScope.loginCustomer}">
            <table border="1" cellpadding="10">
                <tr>
                    <td>아이디(E-mail)</td>
<%--                     <td colspan="2">${loginCustomer.email}</td> --%>
                    <td>${loginCustomer.email}</td>
                </tr>
<!--                 <tr> -->
<!--                     <td>비밀번호</td> -->
<%--                     <td colspan="2">${loginCustomer.password}</td> --%>
<!--                 </tr> -->
                <tr>
                    <td>이름</td>
                    <td><input type="text" id="name_input" value="${loginCustomer.name}"></td>
<!--                     <td><input type="button" value="수정" onclick="updateInfo('name')" ></td> -->
                </tr>
                <tr>
                    <td>전화번호</td>
                    <td><input type="text" id="phone_input" value="${loginCustomer.phone}"></td>
<!--                     <td><input type="button" value="수정" onclick="updateInfo('phone')" ></td> -->
                </tr>
                <tr>
                    <td>주소</td>
	                <td colspan="2" width="80">
						<input type="text" name="zipcode" id="zipcode_input" value="${loginCustomer.zipcode}">
						<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
						<input type="text" name="address" id="address_input" value="${loginCustomer.address}"><br>
						<input type="text" name="address1" id="address1_input" value="${loginCustomer.address1}" >
		<!-- 				address1 사용안해서 히든처리 (없으면 팝업창 안뜸) 04.10 -->
<!-- 						<input type="hidden" name="address2" id="address2_input" > -->
					</td>
                </tr>
                <tr>
                	<td colspan="2" align="center">
                		<input type="button" value="전체 정보 수정" onclick="updateInfo()" />
                	</td>
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
            <a href="log/login">로그인 페이지로 이동</a>
        </c:otherwise>
    </c:choose>

    <br>
    <br>
</body>
</html>