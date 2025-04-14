<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- product_id값을 쿼리스트링으로 받아서 그 상품의 정보 불러온 상태로, 값을 수정 하는 기능 제작-->
<!-- 작성일      작성자   개발내용,수정내용 -->
<!-- 25/04/10    우주연-->
<!-- 25/04/14    김채윤 css 적용 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product_insert.css ">
	<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/product_check.js"></script>
	<script type="text/javascript">
	
		const discountStartVal = '${product.discount_start}';
		const discountEndVal = '${product.discount_end}';
		const discountPercentVal = ${product.discount_percentage};
		
		document.addEventListener("DOMContentLoaded", function () {
		    const start = document.getElementById("discount_start");
		    const end = document.getElementById("discount_end");
		    const percentage = document.getElementById("discount_percentage");
		    const checkbox = document.getElementById("discountCheck");
	
		    const isDiscountEmpty =
		      (!discountStartVal || discountStartVal === 'null') &&
		      (!discountEndVal || discountEndVal === 'null') &&
		      (!discountPercentVal || discountPercentVal === 0);
	
		    if (isDiscountEmpty) {
		        toggleDiscount(checkbox); 
		        checkbox.checked = false;
		    } else {
		        checkbox.checked = true;
		        start.disabled = false;
		        end.disabled = false;
		        percentage.disabled = false;
		        
		        const now = new Date();
		        const offset = now.getTimezoneOffset() * 60000;
		        const localNow = new Date(now - offset).toISOString().slice(0, 16); //
		        
		        start.value = discountStartVal.replace(' ', 'T').slice(0, 16);
		        end.value = discountEndVal.replace(' ', 'T').slice(0, 16);
		        percentage.value = discountPercentVal;
	
		        start.min = localNow;
		        end.min = start.value;
		        
		        start.addEventListener('input', function () {
		            end.min = this.value;
		            if (end.value < this.value) {
		                end.value = this.value;
		            }
		        });
		    }
		});
		function toggleDiscount(checkbox) {
		    const start = document.getElementById("discount_start");
		    const end = document.getElementById("discount_end");
		    const percentage = document.getElementById("discount_percentage");
	
		    if (checkbox.checked) {
		        const now = new Date();
		        const offset = now.getTimezoneOffset() * 60000;
		        const localNow = new Date(now - offset).toISOString().slice(0, 16); // 
	
		        start.disabled = false;
		        end.disabled = false;
		        percentage.disabled = false;
		        
		        start.value = discountStartVal.replace(' ', 'T').slice(0, 16);
		        end.value = discountEndVal.replace(' ', 'T').slice(0, 16);
		        percentage.value = discountPercentVal;
	
		        start.min = localNow;
		        end.min = start.value;
		        
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

		const originalStockValue = ${product.stock};

		function handleStatusChange(status) {
			const stock = document.getElementById("stock");

			if (status.value === "품절") {
				stock.disabled = true;
				stock.value = 0;
			} else {
				stock.disabled = false;
				stock.value = originalStockValue;
			}
		}
			
	    function fn_submit() {
	    	var formData = new FormData($("#frm_product")[0]);

	    	$.ajax({
	    	    type: "post",
	    	    url: "product_modify_ok",
	    	    data: formData,
	    	    processData: false,
	    	    contentType: false,
	    	    success: function (data) {
	    	        alert("수정완료");
	    	        location.href = "main";
	    	    },
	    	    error: function () {
	    	    	alert("예상치 못한 응답입니다: " + data);
	    	    	alert("오류 발생\n상태코드: " + xhr.status + "\n응답 텍스트: " + xhr.responseText + "\n에러: " + error);
	    	    }
	    	});

	    }

	</script>
</head>
<body>
<div class ="container">
	<!-- 		<form method="post" action="write"> -->
		<h1 class="text-center" style="margin-bottom: 80px;">상품 수정</h1>
	<form id="frm_product" enctype="multipart/form-data">
		<table class="table">
			<tr>
				<td>가게 이름</td>
				<td>
					<input type="hidden" name="store_id" value="${product.store_id}">
				    <c:forEach var="store" items="${stores}">
				      <c:if test="${store.id == product.store_id}">
				        <input type="text" size="50" value="${store.name}" disabled>
				      </c:if>
					</c:forEach>
				</td>
			</tr>
			<tr>
				<td>카테고리</td>
				<td>
					<c:forEach var="cat" begin="1" end="7">
					  <label>
					    <input type="radio" name="category_id" value="${cat}"
					           <c:if test="${product.category_id == cat}">checked</c:if> >
					    <c:choose>
					   
					      <c:when test="${cat == 1}">식품</c:when>
					      <c:when test="${cat == 2}">가구</c:when>
					      <c:when test="${cat == 3}">도서</c:when>
					      <c:when test="${cat == 4}">스포츠/레저</c:when>
					      <c:when test="${cat == 5}">출산/유아용품</c:when>
					      <c:when test="${cat == 6}">반려동물용품</c:when>
					      <c:when test="${cat == 7}">뷰티</c:when>
					    </c:choose>
					  </label><br>
					</c:forEach>
				</td>
			</tr>
			
			<tr>
				<td>상품명 *</td>
				<td>
					<input type="text" class="form-control" name="title" size="50" value="${product.title}">
				</td>
			</tr>
			<tr>
				<td>가격 *</td>
				<td>
					<input type="number" class="form-control" name="price" size="50" value="${product.price}">
				</td>
			</tr>
			<tr>
				<td>재고 *</td>
				<td>
					<input type="number" class="form-control" name="stock" id="stock" min="1" step="1" size="50" value="${product.stock}">
				</td>
			</tr>
			<tr>
			  <td>상태</td>
			  <td>
			    <label>
			      <input type="radio" name="status" value="판매중"
			             onclick="handleStatusChange(this)"
			             <c:if test="${product.status == '판매중'}">checked</c:if> >
			      판매중
			    </label><br>
			
			    <label>
			      <input type="radio" name="status" value="품절"
			             onclick="handleStatusChange(this)"
			             <c:if test="${product.status == '품절'}">checked</c:if> >
			      품절
			    </label><br>
			
			    <label>
			      <input type="radio" name="status" value="숨김"
			             onclick="handleStatusChange(this)"
			             <c:if test="${product.status == '숨김'}">checked</c:if> >
			      숨김
			    </label>
			  </td>
			</tr>
			<tr>
			    <td>
					할인
					<input type="checkbox" id="discountCheck" onclick="toggleDiscount(this)" 
						<c:if test="${product.discount_start != null}">checked</c:if> >
				</td>
			    <td>
			        시작  
			        <input type="datetime-local" class="form-control" name="discount_start" id="discount_start" disabled><br>
			        끝  
			        <input type="datetime-local" class="form-control" name="discount_end" id="discount_end" disabled><br>
			        할인율(%)  
			        <input type="number" class="form-control" name="discount_percentage" id="discount_percentage" value="0" min="1" max="100" step="1" disabled> 
			    </td>
			</tr>
			<tr>
				<td>상품설명</td>
				<td>
					<textarea rows="10" class="form-control" style="height: 150px" name="description">${product.description}</textarea>
				</td>
			</tr>
			<tr>
				<td>이미지 업로드</td>
				<td>
					<input type="file" class="form-control" name="picture" accept="image/*" >
					<input type="hidden" name="old_picture" value="${product.picture}">
				</td>
			</tr>
			<tr>
				<td colspan="2">
<!-- 					<input type="submit" value="입력"> -->
					<input type="button" class="btn btn-primary w-100" onclick="product_check_ok()" value="입력">
					<div class="text-end">
					<a href="main">메인으로</a>
					</div>
					</table>
	</form>
	</div>
</body>
</html>