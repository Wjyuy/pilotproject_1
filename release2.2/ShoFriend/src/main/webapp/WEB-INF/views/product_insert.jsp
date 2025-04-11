<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- product 등록 (TODO:버튼 seller세션연결해서 만들어야함)-->
<!-- 할인 체크박스, 품절 라디오박스 등 선택시 JS 이용해 동적으로 구현완료 -->
<!-- TODO: 정규표현식 이용해서 product_check.js (2글자이상작성해주세요 같은거) 할거면 해야함-->
<!-- TODO: 가게번호 세션 연결 필요함 -->
<!-- 작성일      작성자   개발내용,수정내용 -->
<!-- 25/04/10    우주연-->
	<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/product_check.js"></script>
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
		        end.value = start.value;
		        start.min = localNow;
		        end.min = start.value; 
		        percentage.value = 1;
	
		        start.addEventListener('input', function () {
		            end.value = this.value;
		            end.min = this.value;
		        });
	
		    } else {
		        start.disabled = true;
		        end.disabled = true;
		        percentage.disabled = true;
	
		        start.value = "";
		        end.value = "";
		        percentage.value = 0;
		    }
		}

		function handleStatusChange(status) {
			const stock = document.getElementById("stock");
			if (status.value === "품절") {
			 	stock.disabled = true;
			 	stock.value = 0;
			} else {
			  	stock.disabled = false;
			  	stock.value = 100;
			}
		}
			
	    function fn_submit() {
	    	const stock = document.getElementById("stock");
	    	const store_id = document.getElementById("store_id");
	    	store_id.disabled = false; 

	        if (stock.disabled) {
	            stock.disabled = false; 
	        }
	    	var formData = new FormData($("#frm_product")[0]);

	    	$.ajax({
	    	    type: "post",
	    	    url: "product_write",
	    	    data: formData,
	    	    processData: false,
	    	    contentType: false,
	    	    success: function (data) {
	    	        alert("저장완료");
	    	        location.href = "main";
	    	    },
	    	    error: function () {
	    	        alert("입력이 제대로 되었는지 확인해주세요.");
	    	        store_id.disabled = true; 
	    	        stock.disabled = true; 
	    	    }
	    	});

	    }

	</script>
</head>
<body>
	<form id="frm_product" enctype="multipart/form-data">
		<table border="1">
			<tr>
				<td>가게번호(세션받아서 원래는 value에 가게번호, join 해서 가게이름이 떠야합니다!)</td>
				<td>
					<input type="text" name="store_id" id="store_id" size="50" value="1" disabled>
				</td>
			</tr>
			<tr>
				<td>카테고리</td>
			    <td>
			        <label><input type="radio" name="category_id" value="1" checked> 식품</label><br>
			        <label><input type="radio" name="category_id" value="2"> 가구</label><br>
			        <label><input type="radio" name="category_id" value="3"> 도서</label><br>
			        <label><input type="radio" name="category_id" value="4"> 스포츠/레저</label><br>
			        <label><input type="radio" name="category_id" value="5"> 출산/유아용품</label><br>
			        <label><input type="radio" name="category_id" value="6"> 반려동물용품</label><br>
			        <label><input type="radio" name="category_id" value="7"> 뷰티</label>
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
					<input type="number" name="price" size="50">
				</td>
			</tr>
			<tr>
				<td>재고</td>
				<td>
					<input type="number" name="stock" id="stock" min="1" step="1" size="50" value="0" disabled>
				</td>
			</tr>
			<tr>
				<td>상태</td>
				<td>
					<label><input type="radio" name="status" value="판매중" min="1" onclick="handleStatusChange(this)"> 판매중</label><br>
					<label><input type="radio" name="status" value="품절" onclick="handleStatusChange(this)" checked> 품절</label><br>
					<label><input type="radio" name="status" value="숨김" min="1" onclick="handleStatusChange(this)"> 숨김</label>
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
			        <input type="number" name="discount_percentage" id="discount_percentage" value="0" min="1" max="100" step="1" disabled> %
			    </td>
			</tr>
			<tr>
				<td>상품설명</td>
				<td>
					<textarea rows="10" name="description"></textarea>
				</td>
			</tr>
			<tr>
				<td>이미지 업로드</td>
				<td>
					<input type="file" name="picture" accept="image/*" required>
				</td>
			</tr>
			<tr>
				<td colspan="2">
<!-- 					<input type="submit" value="입력"> -->
					<input type="button" onclick="product_check_ok()" value="입력">
					&nbsp;&nbsp;
					<a href="main">메인으로</a>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>