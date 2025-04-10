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
	    	        alert("입력이 제대로 되었는지 확인해주세요.");
	    	    }
	    	});

	    }

	</script>
</head>
<body>
<!-- 		<form method="post" action="write"> -->
	<form id="frm_product" enctype="multipart/form-data">
		<table border="1">
			<tr>
				<td>가게번호(세션받아서 원래는 value에 가게번호, join 해서 가게이름이 떠야합니다!)</td>
				<td>
					<input type="hidden" name="id" value="${product.id}" >
					<input type="text" name="store_id" size="50" value="${product.store_id}" disabled>
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
					<input type="text" name="title" size="50" value="${product.title}">
				</td>
			</tr>
			<tr>
				<td>가격 *</td>
				<td>
					<input type="number" name="price" size="50" value="${product.price}">
				</td>
			</tr>
			<tr>
				<td>재고 *</td>
				<td>
					<input type="number" name="stock" id="stock" min="1" step="1" size="50" value="${product.stock}">
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
					<textarea rows="10" name="description">${product.description}</textarea>
				</td>
			</tr>
			<tr>
				<td>이미지 업로드</td>
				<td>
					<input type="file" name="picture" accept="image/*" >
					<input type="hidden" name="picture" value="${product.picture}">
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