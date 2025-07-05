<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>
	/* 셀렉트 박스 크기 조정 */
    #styleSelect {
        font-size: 16px; /* 글자 크기 */
        padding: 5px; /* 여백 */
    }
</style>

<%-- 오늘의 코디 --%>
<section>
    <div>
        <div class="d-flex align-items-center mt-5">
            <h3 class="my-0">
                MD's Pick <i class="fa-solid fa-star"></i>
            </h3>
            <select id="styleSelect" class="ml-auto" onchange="styleClothes()">
			    <option value="casual" <c:if test="${selectedStyle == 'casual'}">selected</c:if>>캐주얼</option>
			    <option value="street" <c:if test="${selectedStyle == 'street'}">selected</c:if>>스트릿</option>
			    <option value="minimal" <c:if test="${selectedStyle == 'minimal'}">selected</c:if>>미니멀</option>
			    <option value="classic" <c:if test="${selectedStyle == 'classic'}">selected</c:if>>클래식</option>
			    <option value="sportswear" <c:if test="${selectedStyle == 'sportswear'}">selected</c:if>>스포츠웨어</option>
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
    </div>
</section>

<script>
	function styleClothes() {
		    const selectedStyle = document.getElementById("styleSelect").value;
		    const urlParams = new URLSearchParams(window.location.search);
		    urlParams.set('style', selectedStyle); // 정렬 기준 추가
		    window.location.search = urlParams.toString(); // 페이지 새로고침
	}
</script>