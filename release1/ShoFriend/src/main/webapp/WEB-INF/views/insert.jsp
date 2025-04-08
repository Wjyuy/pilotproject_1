<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- product 등록-->
<!-- toggleDiscount: 할인 선택 시 날짜 시간 할인율 선택하게 함 -->
<!-- 작성일      작성자   개발내용,수정내용 -->
<!-- 25/04/07    우주연-->
<!--  	<script src="../resources/js/jquery.js"></script>-->
	<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
	<script type="text/javascript">
	    function toggleDiscount(checkbox) {
	        const start = document.getElementById("discount_start");
	        const end = document.getElementById("discount_end");
	        const percentage = document.getElementById("discount_percentage");
	
	        if (checkbox.checked) {
	            const now = new Date();
	            const offset = now.getTimezoneOffset() * 60000;
	            const localNow = new Date(now - offset).toISOString().slice(0, 16); // 'YYYY-MM-DDTHH:MM'
	
	            start.disabled = false;
	            end.disabled = false;
	            percentage.disabled = false;
	
	            start.value = localNow;
	            end.value = "";
	            percentage.value = "";
	        } else {
	            start.disabled = true;
	            end.disabled = true;
	            percentage.disabled = true;
	
	            start.value = "";
	            end.value = "";
	            percentage.value = 0;
	        }
	    }
		function fn_submit() {
			var formData= $("#frm").serialize(); //form 요소 자체
			//비동기 전송방식의 jquery함수
			$.ajax({
				type:"post"
				,data:formData
				,url:"write"
				,success: function (data) {
					alert("저장완료");
					location.href="main";
				}
				,error: function () {
					alert("오류발생");
				}
			});
		}

	</script>
</head>
<body>
	<table border="1">
<!-- 		<form method="post" action="write"> -->
		<form id="frm">
			<tr>
				<td>가게번호(테스트)</td>
				<td>
					<input type="text" name="store_id" size="50">
				</td>
			</tr>
			<tr>
				<td>카테고리</td>
			    <td>
			        <label><input type="radio" name="category_id" value="0" checked> 추천</label><br>
			        <label><input type="radio" name="category_id" value="1"> 반짝세일</label><br>
			        <label><input type="radio" name="category_id" value="2"> 식품</label><br>
			        <label><input type="radio" name="category_id" value="3"> 가구</label><br>
			        <label><input type="radio" name="category_id" value="4"> 도서</label><br>
			        <label><input type="radio" name="category_id" value="5"> 스포츠/레저</label><br>
			        <label><input type="radio" name="category_id" value="6"> 출산/유아용품</label><br>
			        <label><input type="radio" name="category_id" value="7"> 반려동물용품</label><br>
			        <label><input type="radio" name="category_id" value="8"> 뷰티</label>
				</td>
			</tr>
			<tr>
				<td>상품명</td>
				<td>
					<input type="text" name="title" size="50">
				</td>
			</tr>
			<tr>
				<td>가격</td>
				<td>
					<input type="text" name="price" size="50">
				</td>
			</tr>
			<tr>
				<td>재고</td>
				<td>
					<input type="number" name="stock" min="0" step="1" size="50">
				</td>
			</tr>
			<tr>
				<td>상태</td>
				<td>
					<input type="text" name="status" size="50">
				</td>
			</tr>
			<tr>
			    <td>
			        할인
			        <input type="checkbox" id="discountCheck" onclick="toggleDiscount(this)">
			    </td>
			    <td>
			        시작  
			        <input type="datetime-local" name="discount_start" id="discount_start" disabled><br>
			        끝  
			        <input type="datetime-local" name="discount_end" id="discount_end" disabled><br>
			        할인율  
			        <input type="number" name="discount_percentage" id="discount_percentage" value="0" min="0" max="100" step="1" disabled> %
			    </td>
			</tr>
			<tr>
				<td>상품설명</td>
				<td>
					<textarea rows="10" name="description"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
<!-- 					<input type="submit" value="입력"> -->
					<input type="button" onclick="fn_submit()" value="입력">
					&nbsp;&nbsp;
					<a href="main">목록보기</a>
				</td>
			</tr>
		</form>
	</table>
</body>
</html>