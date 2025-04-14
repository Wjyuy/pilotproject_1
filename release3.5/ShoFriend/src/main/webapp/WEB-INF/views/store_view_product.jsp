<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>점포별 상품 목록</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
<!-- 2025/04/14 우주연 추가 -->
    <h2 class="text-center mb-4">해당 점포의 상품 목록</h2>
    <table class="table table-bordered table-hover">
        <thead class="table-light">
            <tr>
                <th>상품번호</th>
                <th>카테고리</th>
                <th>상품명</th>
                <th>가격</th>
                <th>재고</th>
                <th>상태</th>
                <th>할인율</th>
                <th>할인기간</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="product" items="${productList}">
                <tr>
                    <td>
                    	<a href="content?id=${product.id}">${product.id}</a>
                    </td>
                    <td>${product.category_id}</td>
                    <td>${product.title}</td>
                    <td><fmt:formatNumber value="${product.price}" pattern="#,##0" /></td>
                    <td>${product.stock}</td>
                    <td>${product.status}</td>
                    <td>
                        <c:choose>
                            <c:when test="${product.discount_percentage > 0}">
                                ${product.discount_percentage}%
                            </c:when>
                            <c:otherwise>
                                -
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty product.discount_start}">
                                ${product.discount_start} ~ ${product.discount_end}
                            </c:when>
                            <c:otherwise>
                                -
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <div class="text-end">
        <a href="store_list" class="btn btn-secondary">점포 목록으로 돌아가기</a>
    </div>
</div>
</body>
</html>
