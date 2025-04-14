<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 25/04/08    김채윤   최초 작성 -->
<!-- 25/04/14    김채윤   프론트엔드 적용 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/store_reg.css ">
<script src="${pageContext.request.contextPath}/resources/js/script.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
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
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }</script>
</head>
<body>
<div class ="container">
<h2 class="text-center" style="margin-bottom: 50px; font-size: 40px;"><b>점포 수정</b></h2>
		<form name="storeReg_frm2" method="post" action="store_modify">
			<input type="hidden" name="id" value="${store_view.id}">
<!-- 			<tr> -->
<!-- 				<td>점포번호</td> -->
<!-- 				<td> -->
<%-- 					${store_view.id} --%>
<!-- 				</td> -->
<!-- 			</tr> -->
			<label  class="form-label mt-4">점포 번호</label>
			<label  class="form-label mt-4">${store_view.id}</label><br>

			
			<label  class="form-label mt-4">점포 이름</label>
			<input type="text"  class="form-control" size="50" name="name" value="${store_view.name}">
		
				
			<label  class="form-label mt-4">점포설명</label>
			<textarea rows="15" class="form-control" cols="50" name="description" value="${store_view.description}"></textarea>
<%-- 			<input type="text" name="description" class="form-control" value="${store_view.description}"> --%>

 			<label class="form-label mt-4">주소</label>
 			<div class="zip-row">
				<input type="text" name="zipcode" class="form-control"  id="sample6_postcode" value="${store_view.zipcode}">
				<input type="button" onclick="sample6_execDaumPostcode()" class="btn btn-primary" value="우편번호 찾기"></div>
				<input type="text" name="address"  class="form-control" id="sample6_address" value="${store_view.address}">
				<input type="text" name="address1" class="form-control"  id="sample6_extraAddress" value="${store_view.address1}" >
<!-- 				address1 사용안해서 히든처리 (없으면 팝업창 안뜸) 04.10 -->
				<input type="hidden" name="address2" id="sample6_detailAddress" >

				
					<input type="submit" style="margin-top:40px;" class="btn btn-primary w-100" value="수정">
					<div class="text-end">
					&nbsp;&nbsp;<a href="store_list">목록보기</a>
					&nbsp;&nbsp;<a href="store_delete?id=${store_view.id}">삭제</a>
					</div>

		</form>
	</div>
</body>
</html>










