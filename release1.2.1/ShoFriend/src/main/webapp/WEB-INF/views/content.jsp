<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head><title>${product.title} 상세페이지</title></head>
<body>
    <h2>${product.title}</h2>
    <img src="${pageContext.request.contextPath}/resources/images/${product.picture}" width="200"/><br><br>

    <strong>상품번호:</strong> ${product.id}<br>
    <strong>가게번호:</strong> ${product.store_id}<br>
    <strong>카테고리번호:</strong> ${product.category_id}<br>
    <strong>가격:</strong> <fmt:formatNumber value="${product.price}" pattern="#,###" /> 원<br>
    <strong>재고:</strong> ${product.stock}개<br>
    <strong>상태:</strong> ${product.status}<br>
    <strong>설명:</strong> ${product.description}<br>
    <strong>할인 시작:</strong> ${product.discount_start}<br>
    <strong>할인 종료:</strong> ${product.discount_end}<br>
    <strong>할인율:</strong> ${product.discount_percentage}%<br>
</body>
</html>
