<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A List</title>
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
        max-width: 1200px; /* 테이블의 최대 너비 설정 */
        margin: 0 auto; /* 가운데 정렬 */
        border-collapse: collapse;
        background-color: #f9f9f9; /* 약간 회색 톤 */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
    }
    th, td {
        padding: 10px; /* 기존 padding 조정 */
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
        word-break: break-word; /* 긴 단어 줄바꿈 */
    }
    th:nth-child(1), td:nth-child(1) {
        width: 5%; /* 번호 열의 폭 조정 */
    }
    th:nth-child(2), td:nth-child(2) {
        width: 30%; /* 제목 열의 폭 조정 */
    }
    th:nth-child(3), td:nth-child(3) {
        width: 15%; /* 작성자 열의 폭 조정 */
    }
    th:nth-child(4), td:nth-child(4),
    th:nth-child(5), td:nth-child(5) {
        width: 20%; /* 작성일 및 수정일 열의 폭 조정 */
    }
    th:nth-child(6), td:nth-child(6) {
        width: 10%; /* 작성자 열의 폭 조정 */
    }
    .page-title {
	    font-size: 2.5rem;
	    font-weight: bold;
	    color: #333;
	    margin-bottom: 30px;
	    text-align: center;
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
    	고객센터 <i class="fa-solid fa-headset"></i>
	</h1>
</div>
<div class="d-flex justify-content-between align-items-center mt-4 mb-3" style="max-width: 1200px; margin: 0 auto;">
    <form action="/qna/search" method="get" class="form-inline">
	    <select name="searchField" class="form-control mr-2" style="width: 120px;">
	        <option value="title" ${searchField == 'title' ? 'selected' : ''}>제목</option>
	        <option value="writer" ${searchField == 'writer' ? 'selected' : ''}>작성자</option>
	        <option value="content" ${searchField == 'content' ? 'selected' : ''}>내용</option>
	    </select>
	    <input type="text" name="keyword" class="form-control mr-2" placeholder="검색어를 입력하세요" style="width: 200px;" autocomplete="off" value="${keyword}">
	    <button type="submit" class="btn btn-outline-dark">검색</button>
	</form>
    <a href="/qna/addform" class="btn btn-outline-dark"><i class="fa-solid fa-pen"> 글쓰기</i></a>
</div>
<div>
	<table class="table text-center mt-3">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>수정일</th>
				<th>답변</th>
			</tr>
		</thead>

		<tbody>
			<c:forEach var="qna" items="${qnaList}">
				<tr>
					<td style="vertical-align: middle;">${qna.id}</td>
					<td style="vertical-align: middle;">
					    <a href="/qna/${qna.id}">${qna.title}</a>
					</td>					
					<td style="vertical-align: middle;">${qna.writer}</td>
					<td style="vertical-align: middle;"><fmt:formatDate value="${qna.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td style="vertical-align: middle;"><fmt:formatDate value="${qna.updatedAt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td style="vertical-align: middle;">${qna.status}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<!-- 목록이 없을 경우 -->
	<c:if test="${empty qnaList}">
	    <div class="text-center">
	        <h5>
	        	<i class="fa-solid fa-triangle-exclamation" style="font-size: 2rem; margin: 20px 0 10px;"></i>
	        	<br>
	        	Q&A 목록이 존재하지 않습니다.
	        </h5>
	    </div>
	</c:if>
	
	<!-- 페이징 네비게이션 추가 -->
	<c:if test="${not empty qnaList}">
	    <div class="pagination">
	        <!-- 이전 버튼 -->
	        <c:if test="${currentPage > 1}">
	            <a href="?page=${currentPage - 1}&size=5&searchField=${param.searchField}&keyword=${param.keyword}">이전</a>
	        </c:if>
	        <c:if test="${currentPage == 1}">
	            <a class="disabled">이전</a>
	        </c:if>
	
	        <!-- 페이지 번호 버튼 -->
	        <c:forEach begin="1" end="${totalPages}" var="i">
	            <a href="?page=${i}&size=5&searchField=${param.searchField}&keyword=${param.keyword}" class="${i == currentPage ? 'active' : ''}">${i}</a>
	        </c:forEach>
	
	        <!-- 다음 버튼 -->
	        <c:if test="${currentPage < totalPages}">
	            <a href="?page=${currentPage + 1}&size=5&searchField=${param.searchField}&keyword=${param.keyword}">다음</a>
	        </c:if>
	        <c:if test="${currentPage == totalPages}">
	            <a class="disabled">다음</a>
	        </c:if>
	    </div>
	</c:if>
</div>

</body>
</html>
