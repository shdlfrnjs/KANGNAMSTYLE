<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product List</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/static/css/style.css" type="text/css">
<style>
    body {
        padding: 20px;
        font-family: Arial, sans-serif;
        background-color: #ffffff; /* 배경 흰색 */
        color: #000000; /* 기본 텍스트 검은색 */
    }
    table {
        width: 100%;
        border-collapse: collapse;
        background-color: #f9f9f9; /* 약간 회색 톤 */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
    }
    th, td {
        padding: 15px;
        text-align: center;
        border-bottom: 1px solid #000000; /* 테두리 검은색 */
        vertical-align: middle;
    }
    th {
        background-color: #333333; /* 짙은 회색 */
        color: #ffffff; /* 흰색 텍스트 */
        font-weight: bold;
    }
    td {
        background-color: #ffffff; /* 흰색 배경 */
    }
    h1 a {
        text-decoration: none;
        color: #000000; /* 검은색 */
    }
    h1 a:hover {
        color: #007bff; /* 파란색으로 강조 */
    }
    .page-title {
	    font-size: 2.5rem;
	    font-weight: bold;
	    color: #333;
	    margin-bottom: 10px;
	    text-align: center;
	}
    /* 상품 수정 버튼 스타일 */
	.modifyProductBtn {
		background-color: #000; /* 검은색 배경 */
		color: #fff; /* 하얀색 텍스트 */
		border: 1px solid #000; /* 검은색 테두리 */
		padding: 10px 20px;
		border-radius: 5px; /* 둥근 모서리 */
		cursor: pointer;
		transition: background-color 0.3s ease, color 0.3s ease;
		box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 버튼 그림자 추가 */
	}
	/* 상품 수정 버튼 마우스 오버 시 */
	.modifyProductBtn:hover {
		background-color: #fff; /* 하얀색 배경 */
		color: #000; /* 검은색 텍스트 */
		border: 1px solid #000; /* 검은색 테두리 */
		box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3); /* 호버 시 그림자 깊이 증가 */
	}
	/* 상품 등록 버튼 스타일 */
	.register-button-container {
	    position: fixed;
	    top: 20px;
	    right: 20px;
	}
	#addProductBtn {
	    padding: 10px 20px;
	    font-size: 16px;
	   	background-color: #fff; /* 하얀색 배경 */
		color: #000; /* 검은색 텍스트 */
		border: 1px solid #000; /* 하얀색 테두리 */
	    border-radius: 5px;
	    cursor: pointer;
	    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	}
	#addProductBtn:hover {
	    background-color: #000; /* 검은색 배경 */
		color: #fff; /* 하얀색 텍스트 */
		border: 1px solid #000; /* 검은색 테두리 */
		box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
	}
	.pagination {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: 20px;
        gap: 5px;
    }
    .pagination a {
        display: inline-block;
        padding: 8px 12px;
        margin: 0 4px;
        color: black;
        text-decoration: none;
        border: 1px solid black;
        border-radius: 4px;
        transition: background-color 0.3s, color 0.3s;
    }
    .pagination a:hover {
        background-color: black;
        color: white;
    }
    .pagination a.active {
        background-color: black;
        color: white;
        pointer-events: none; /* 활성화된 페이지는 클릭 불가 */
    }
    .pagination a.disabled {
        color: #aaa;
        border-color: #aaa;
        pointer-events: none; /* 비활성화된 버튼은 클릭 불가 */
    }
</style>
</head>
<body>
<div>
    <a href="/main-view">
   		<img src="/static/img/logo.png" width="400px">
    </a>
</div>
<div>
   	<h1 class="page-title">
    	상품 관리 <i class="fa-solid fa-shirt"></i>
	</h1>
</div>
<div>
	<table class="table text-center mt-3">
		<thead>
			<tr>
				<th>상품번호</th>
				<th>등록일</th>
				<th>상품명</th>
				<th>판매가격</th>
				<th>카테고리</th>
				<th>상품재고</th>
				<th>수정일</th>
				<th>상품수정</th>
			</tr>
		</thead>

		<tbody>
			<c:forEach var="product" items="${productList}">
				<tr>
					<td style="vertical-align: middle;">${product.clothId}</td>
					<td style="vertical-align: middle;"><fmt:formatDate value="${product.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td style="vertical-align: middle;">${product.clothName}</td>
					<td style="vertical-align: middle;">${product.clothPrice}원</td>
					<td style="vertical-align: middle;">
					    <c:choose>
					        <c:when test="${product.clothCategory == 1}">
					            아우터
					        </c:when>
					        <c:when test="${product.clothCategory == 2}">
					            상의
					        </c:when>
					        <c:when test="${product.clothCategory == 3}">
					            하의
					        </c:when>
					        <c:when test="${product.clothCategory == 4}">
					            신발
					        </c:when>
					        <c:when test="${product.clothCategory == 5}">
					            악세사리
					        </c:when>
					        <c:otherwise>
					            기타
					        </c:otherwise>
					    </c:choose>
					</td>				
					<td style="vertical-align: middle;">${product.clothCount}</td>
					<td style="vertical-align: middle;"><fmt:formatDate value="${product.updatedAt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td style="vertical-align: middle;">
						<input type="button" value="수정하기" class="modifyProductBtn" data-clothid="${product.clothId}">
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<!-- 목록이 없을 경우 -->
	<c:if test="${empty productList}">
	    <div class="text-center">
	        <h5>
	        	<i class="fa-solid fa-triangle-exclamation" style="font-size: 2rem; margin: 20px 0 10px;"></i>
	        	<br>
	        	상품 목록이 존재하지 않습니다.
	        </h5>
	    </div>
	</c:if>
	
	<!-- 페이징 네비게이션 추가 -->
	<c:if test="${not empty productList}">
	    <div class="pagination">
		    <!-- 이전 버튼 -->
		    <c:if test="${currentPage > 1}">
		        <a href="?page=${currentPage - 1}&size=10">이전</a>
		    </c:if>
		    <c:if test="${currentPage == 1}">
		        <a class="disabled">이전</a>
		    </c:if>
		    
		    <!-- 페이지 번호 버튼 -->
		    <c:forEach begin="1" end="${totalPages}" var="i">
		        <a href="?page=${i}&size=10" class="${i == currentPage ? 'active' : ''}">${i}</a>
		    </c:forEach>
		    
		    <!-- 다음 버튼 -->
		    <c:if test="${currentPage < totalPages}">
		        <a href="?page=${currentPage + 1}&size=10">다음</a>
		    </c:if>
		    <c:if test="${currentPage == totalPages}">
		        <a class="disabled">다음</a>
		    </c:if>
		</div>
	</c:if>
</div>

<!-- 상품 등록 버튼 -->
<div class="register-button-container">
    <button class="btn btn-primary" id="addProductBtn">상품 등록</button>
</div>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>
    
    <script>
	    $(document).ready(function() {
	        // 수정하기 버튼 클릭 시
	        $(".modifyProductBtn").on("click", function() {
	        	let clothId = $(this).data("clothid");  // data-clothid 속성에서 가져오기
	            window.location.href = "/admin/modify/product?clothId=" + clothId;
	        });
	        
	     	// 상품 등록 버튼 클릭 시
	        $("#addProductBtn").on("click", function() {
	            window.location.href = "/admin/add/product";
	        });
	    });
    </script>
</body>
</html>