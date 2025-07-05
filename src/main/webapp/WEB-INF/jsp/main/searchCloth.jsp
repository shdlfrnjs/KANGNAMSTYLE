<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>
	/* 셀렉트 박스 크기 조정 */
    #sortSelect {
        font-size: 16px; /* 글자 크기 */
        padding: 5px; /* 여백 */
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

<%-- 검색 결과 --%>
<section>
    <div>
        <div class="d-flex align-items-center mt-5">
       		<%-- 검색어 표시 --%>
            <h3 class="my-0">
			    <span style="font-size: 1.1rem;">
			    	<i class="fa-solid fa-magnifying-glass"></i> 검색 결과 :
			    </span>
			    <span>
			    	'${keyword}' (${totalItems})
			    </span>
			</h3>
			<%-- 정렬 방식 --%>
            <select id="sortSelect" class="ml-auto" onchange="sortClothes()">
			    <option value="createdAt" <c:if test="${selectedSort == 'createdAt'}">selected</c:if>>신상품</option>
			    <option value="clothTotalSales" <c:if test="${selectedSort == 'clothTotalSales'}">selected</c:if>>인기상품</option>
			    <option value="clothName" <c:if test="${selectedSort == 'clothName'}">selected</c:if>>상품명</option>
			    <option value="clothPriceAsc" <c:if test="${selectedSort == 'clothPriceAsc'}">selected</c:if>>낮은 가격</option>
			    <option value="clothPriceDesc" <c:if test="${selectedSort == 'clothPriceDesc'}">selected</c:if>>높은 가격</option>
			</select>
        </div>
        <hr>
        <div class="d-flex flex-wrap justify-content-start mt-3" style="gap: 25px;">
		    <c:forEach var="cloth" items="${clothList}">
		        <a href="/main/clothes-detail?id=${cloth.clothId}" class="text-dark my-2">
		            <div>
		                <img src="${cloth.clothImagePath}" class="img-fluid" style="width: 260px; height: 325px;">
		                <div style="font-size: 18px; font-weight: bold;" class="my-1">${cloth.clothName}</div> <!-- 찐하게 강조 -->
		                <del style="font-size: 15px;"> <i class="fa-solid fa-won-sign"></i> ${cloth.clothRegularPrice}</del>
		                <div style="font-size: 15px;"> <i class="fa-solid fa-won-sign"></i> ${cloth.clothPrice}</div>
		            </div>
		        </a>
		    </c:forEach>
		</div>
		
		<!-- 검색 결과가 없을 경우 -->
		<c:if test="${empty clothList}">
		    <div class="text-center">
		        <h5>
		        	<i class="fa-solid fa-triangle-exclamation" style="font-size: 2rem; margin: 20px 0 10px;"></i>
		        	<br>
		        	검색된 상품이 없습니다.
		        </h5>
		    </div>
		</c:if>
		
		<!-- 페이징 네비게이션 -->
		<c:if test="${not empty clothList}">
		    <div class="pagination">
		        <!-- 이전 버튼 -->
		        <c:if test="${currentPage > 1}">
		            <a href="?page=${currentPage - 1}&size=10&sort=${selectedSort}&keyword=${keyword}">이전</a>
		        </c:if>
		        <c:if test="${currentPage == 1}">
		            <a class="disabled">이전</a>
		        </c:if>
		        
		        <!-- 페이지 번호 버튼 -->
		        <c:forEach begin="1" end="${totalPages}" var="i">
		            <a href="?page=${i}&size=10&sort=${selectedSort}&keyword=${keyword}" class="${i == currentPage ? 'active' : ''}">${i}</a>
		        </c:forEach>
		        
		        <!-- 다음 버튼 -->
		        <c:if test="${currentPage < totalPages}">
		            <a href="?page=${currentPage + 1}&size=10&sort=${selectedSort}&keyword=${keyword}">다음</a>
		        </c:if>
		        <c:if test="${currentPage == totalPages}">
		            <a class="disabled">다음</a>
		        </c:if>
		    </div>
		</c:if>
    </div>
</section>

<script>
	function sortClothes() {
		    const selectedSort = document.getElementById("sortSelect").value;
		    const urlParams = new URLSearchParams(window.location.search);
		    urlParams.set('page', 1); // 1페이지로
		    urlParams.set('sort', selectedSort); // 정렬 기준 추가
		    window.location.search = urlParams.toString(); // 페이지 새로고침
	}
</script>