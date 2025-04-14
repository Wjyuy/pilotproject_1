<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product_insert.css ">
<!-- product 등록 -->
<!-- 할인 체크박스, 품절 라디오박스 등 선택시 JS 이용해 동적으로 구현완료 -->
<!-- 작성일      작성자   개발내용,수정내용 -->
<!-- 25/04/10    우주연-->
<!-- 25/04/14    우주연   css적용단 위에 카테고리적용, 가게적용 수정-->
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
		
		function updateStoreId() {
		    const selectedStoreId = document.getElementById("storeSelect").value;
		    document.getElementById("store_id").value = selectedStoreId;
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
<div class ="container">
	<form id="frm_product" enctype="multipart/form-data">
	<h1 class="text-center" style="margin-bottom: 50px;">상품 등록</h1>
		
		<label  class="form-label mt-4">가게 선택</label>

			        <select class="form-select" aria-label="Default select example" id="storeSelect" onchange="updateStoreId()">
			            <c:forEach var="store" items="${stores}">
			                <option value="${store.id}">${store.name}</option>
			            </c:forEach>
			        </select>
			        <!-- 실제 전송되는 store_id -->
			        <input type="hidden" name="store_id" id="store_id" value="${stores[0].id}" />
			    
				<label class="form-label mt-4">카테고리</label>
				<div class="form-check">
				  <input class="form-check-input" type="radio" name="category_id" id="cat1" value="1" checked>
				  <label class="form-check-label" for="cat1">식품</label><br>
				
				  <input class="form-check-input" type="radio" name="category_id" id="cat2" value="2">
				  <label class="form-check-label" for="cat2">가구</label><br>
				
				  <input class="form-check-input" type="radio" name="category_id" id="cat3" value="3">
				  <label class="form-check-label" for="cat3">도서</label><br>
				
				  <input class="form-check-input" type="radio" name="category_id" id="cat4" value="4">
				  <label class="form-check-label" for="cat4">스포츠/레저</label><br>
				
				  <input class="form-check-input" type="radio" name="category_id" id="cat5" value="5">
				  <label class="form-check-label" for="cat5">출산/유아용품</label><br>
				
				  <input class="form-check-input" type="radio" name="category_id" id="cat6" value="6">
				  <label class="form-check-label" for="cat6">반려동물용품</label><br>
				
				  <input class="form-check-input" type="radio" name="category_id" id="cat7" value="7">
				  <label class="form-check-label" for="cat7">뷰티</label>
				</div>

				<label  class="form-label mt-4">상품명</label>
					<input type="text" class="form-control" name="title" size="50">
			
				<label  class="form-label mt-4">가격</label>
					<input type="number" class="form-control" name="price" size="50">
				
				<label  class="form-label mt-4">재고</label>
					<input type="number" class="form-control" name="stock" id="stock" min="1" step="1" size="50" value="0" disabled>
				
				<label  class="form-label mt-4">상태</label>
				<div class="form-check">
<!-- 			    <input class="form-check-input" type="radio" name="radioDefault" id="radioDefault1"> -->
<!-- 					<label class="form-check-label" for="radioDefault1" name="status" value="판매중" min="1" onclick="handleStatusChange(this)"> 판매중</label><br> -->
<!-- 			    <input class="form-check-input" type="radio" name="radioDefault" id="radioDefault2"> -->
<!-- 					<label class="form-check-label" for="radioDefault2" name="status" value="품절" onclick="handleStatusChange(this)" checked> 품절</label><br> -->
<!-- 			    <input class="form-check-input" type="radio" name="radioDefault" id="radioDefault3"> -->
<!-- 					<label class="form-check-label" for="radioDefault3" name="status" value="숨김" min="1" onclick="handleStatusChange(this)"> 숨김</label> -->
					<label><input type="radio" name="status" value="판매중" min="1" onclick="handleStatusChange(this)"> 판매중</label><br>
					<label><input type="radio" name="status" value="품절" onclick="handleStatusChange(this)" checked> 품절</label><br>
					<label><input type="radio" name="status" value="숨김" min="1" onclick="handleStatusChange(this)"> 숨김</label>
				</div>
				
					<div class="form-check" style="margin-top:20px;">
			        <input type="checkbox" class="form-check-input" id="discountCheck" onclick="toggleDiscount(this)">
			        <label  class="form-check-label"  for="defaultCheck1">할인</label>
			  		</div>
			        시작  
			        <input type="datetime-local" class="form-control" name="discount_start" id="discount_start" disabled><br>
			        끝  
			        <input type="datetime-local" class="form-control" name="discount_end" id="discount_end" disabled><br>
			        할인율(%)  
			        <input type="number" class="form-control" name="discount_percentage" id="discount_percentage" value="0" min="1" max="100" step="1" disabled>
			
			
				<label  class="form-label mt-4">상품설명</label>
				<div class="form-floating">
					<textarea class="form-control" style="height: 150px" rows="10" name="description"></textarea>
			</div>
			
				<label  class="form-label mt-4">이미지 업로드</label>
				<div class="input-group mb-3">
					<input type="file" class="form-control" id="inputGroupFile02" name="picture" accept="image/*" required>
				</div>
				<br>
				<br>
				<div class="text-center">
<!-- 					<input type="submit" value="입력"> -->
					<input type="button" class="btn btn-primary w-100" onclick="product_check_ok()" value="입력">
				</div>
				<div class="text-end">
					<a href="main">메인으로</a>
					</div>
	</form>
	</div>
</body>
</html>