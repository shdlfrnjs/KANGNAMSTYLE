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

<%-- 종류별 옷 보여지는곳 --%>
<section>
    <div>
        <div class="d-flex align-items-center mt-5">
            <h3 class="my-0">
                <%-- 메인 카테고리 표시 --%>
                <i class="fa-solid fa-hashtag"></i>
                <c:choose>
                    <c:when test="${selectedCategory == '1'}">아우터</c:when>
                    <c:when test="${selectedCategory == '2'}">상의</c:when>
                    <c:when test="${selectedCategory == '3'}">하의</c:when>
                    <c:when test="${selectedCategory == '4'}">신발</c:when>
                    <c:when test="${selectedCategory == '5'}">액세서리</c:when>
                </c:choose>
            </h3>
            <span class="mx-2"> <i class="fa-solid fa-angle-right"></i> </span>
            <span style="font-weight: bold;">
                <%-- 서브 카테고리 표시 --%>
                <c:choose>
                    <c:when test="${selectedCategory == '1'}">
                        <c:choose>
                            <c:when test="${selectedSubCategory == 'hoodie_jacket'}">후드 집업</c:when>
                            <c:when test="${selectedSubCategory == 'blouson_ma1'}">블루종/MA-1</c:when>
                            <c:when test="${selectedSubCategory == 'leather_riders'}">레더/라이더스 재킷</c:when>
                            <c:when test="${selectedSubCategory == 'mustang_fur'}">무스탕/퍼</c:when>
                            <c:when test="${selectedSubCategory == 'trucker'}">트러커 재킷</c:when>
                            <c:when test="${selectedSubCategory == 'blazer_suit'}">슈트/블레이저 재킷</c:when>
                            <c:when test="${selectedSubCategory == 'cardigan'}">카디건</c:when>
                            <c:when test="${selectedSubCategory == 'anorak'}">아노락 재킷</c:when>
                            <c:when test="${selectedSubCategory == 'fleece'}">플리스/뽀글이</c:when>
                            <c:when test="${selectedSubCategory == 'training'}">트레이닝 재킷</c:when>
                            <c:when test="${selectedSubCategory == 'stadium'}">스타디움 재킷</c:when>
                            <c:when test="${selectedSubCategory == 'transition_coat'}">환절기 코트</c:when>
                            <c:when test="${selectedSubCategory == 'winter_single_coat'}">겨울 싱글 코트</c:when>
                            <c:when test="${selectedSubCategory == 'winter_double_coat'}">겨울 더블 코트</c:when>
                            <c:when test="${selectedSubCategory == 'winter_other_coat'}">겨울 기타 코트</c:when>
                            <c:when test="${selectedSubCategory == 'long_padding'}">롱패딩/헤비 아우터</c:when>
                            <c:when test="${selectedSubCategory == 'short_padding'}">숏패딩/헤비 아우터</c:when>
                            <c:when test="${selectedSubCategory == 'padding_vest'}">패딩 베스트</c:when>
                            <c:when test="${selectedSubCategory == 'vest'}">베스트</c:when>
                            <c:when test="${selectedSubCategory == 'safari_hunting'}">사파리/헌팅 재킷</c:when>
                            <c:when test="${selectedSubCategory == 'nylon_coach'}">나일론/코치 재킷</c:when>
                            <c:when test="${selectedSubCategory == 'other_outer'}">기타 아우터</c:when>
                            <c:otherwise>전체</c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:when test="${selectedCategory == '2'}">
                        <c:choose>
                            <c:when test="${selectedSubCategory == 'sweatshirt'}">맨투맨/스웨트</c:when>
                            <c:when test="${selectedSubCategory == 'shirt'}">셔츠/블라우스</c:when>
                            <c:when test="${selectedSubCategory == 'hoodie'}">후드 티셔츠</c:when>
                            <c:when test="${selectedSubCategory == 'knit'}">니트/스웨터</c:when>
                            <c:when test="${selectedSubCategory == 'polo'}">피케/카라 티셔츠</c:when>
                            <c:when test="${selectedSubCategory == 'longsleeve'}">긴소매 티셔츠</c:when>
                            <c:when test="${selectedSubCategory == 'shortsleeve'}">반소매 티셔츠</c:when>
                            <c:when test="${selectedSubCategory == 'sleeveless'}">민소매 티셔츠</c:when>
                            <c:when test="${selectedSubCategory == 'sports_top'}">스포츠 상의</c:when>
                            <c:when test="${selectedSubCategory == 'other_top'}">기타 상의</c:when>
                            <c:otherwise>전체</c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:when test="${selectedCategory == '3'}">
                        <c:choose>
                            <c:when test="${selectedSubCategory == 'denim_pants'}">데님 팬츠</c:when>
                            <c:when test="${selectedSubCategory == 'cotton_pants'}">코튼 팬츠</c:when>
                            <c:when test="${selectedSubCategory == 'suit_slacks'}">슈트 팬츠/슬랙스</c:when>
                            <c:when test="${selectedSubCategory == 'jogger_pants'}">트레이닝/조거 팬츠</c:when>
                            <c:when test="${selectedSubCategory == 'shorts'}">숏 팬츠</c:when>
                            <c:when test="${selectedSubCategory == 'leggings'}">레깅스</c:when>
                            <c:when test="${selectedSubCategory == 'jumpsuit_overalls'}">점프 슈트/오버올</c:when>
                            <c:when test="${selectedSubCategory == 'sports_bottom'}">스포츠 하의</c:when>
                            <c:when test="${selectedSubCategory == 'other_bottom'}">기타 하의</c:when>
                            <c:otherwise>전체</c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:when test="${selectedCategory == '4'}">
                        <c:choose>
                            <c:when test="${selectedSubCategory == 'sneakers'}">스니커즈</c:when>
                            <c:when test="${selectedSubCategory == 'shoes'}">구두</c:when>
                            <c:when test="${selectedSubCategory == 'sandals_slippers'}">샌들/슬리퍼</c:when>
                            <c:when test="${selectedSubCategory == 'boots_walkers'}">부츠/워커</c:when>
                            <c:when test="${selectedSubCategory == 'sports_shoes'}">운동화</c:when>
                            <c:when test="${selectedSubCategory == 'other_shoes'}">기타 신발</c:when>
                            <c:otherwise>전체</c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:when test="${selectedCategory == '5'}">
                        <c:choose>
                            <c:when test="${selectedSubCategory == 'hat'}">모자</c:when>
                            <c:when test="${selectedSubCategory == 'bag'}">가방</c:when>
                            <c:when test="${selectedSubCategory == 'watch'}">시계</c:when>
                            <c:when test="${selectedSubCategory == 'jewelry'}">주얼리</c:when>
                            <c:when test="${selectedSubCategory == 'other_accessory'}">기타 액세서리</c:when>
                            <c:otherwise>전체</c:otherwise>
                        </c:choose>
                    </c:when>
                </c:choose>
            </span>
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
		
		<!-- 카테고리 상품이 없을 경우 -->
		<c:if test="${empty clothList}">
		    <div class="text-center">
		        <h5>
		        	<i class="fa-solid fa-triangle-exclamation" style="font-size: 2rem; margin: 20px 0 10px;"></i>
		        	<br>
		        	해당 카테고리는 상품이 존재하지 않습니다.
		        </h5>
		    </div>
		</c:if>
		
		<!-- 페이징 네비게이션 -->
		<c:if test="${not empty clothList}">
			<div class="pagination">
			    <!-- 이전 버튼 -->
			    <c:if test="${currentPage > 1}">
			        <a href="?page=${currentPage - 1}&size=10&sort=${selectedSort}&clothCategory=${selectedCategory}&clothSubCategory=${selectedSubCategory}">이전</a>
			    </c:if>
			    <c:if test="${currentPage == 1}">
			        <a class="disabled">이전</a>
			    </c:if>
			    
			    <!-- 페이지 번호 버튼 -->
			    <c:forEach begin="1" end="${totalPages}" var="i">
			        <a href="?page=${i}&size=10&sort=${selectedSort}&clothCategory=${selectedCategory}&clothSubCategory=${selectedSubCategory}" class="${i == currentPage ? 'active' : ''}">${i}</a>
			    </c:forEach>
			    
			    <!-- 다음 버튼 -->
			    <c:if test="${currentPage < totalPages}">
			        <a href="?page=${currentPage + 1}&size=10&sort=${selectedSort}&clothCategory=${selectedCategory}&clothSubCategory=${selectedSubCategory}">다음</a>
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
