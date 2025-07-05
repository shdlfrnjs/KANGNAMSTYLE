<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<style>
.banner {
    position: relative;
    z-index: 1; /* 네비게이션보다 낮은 z-index */
}
.contents {
    padding-top: 50px;  /* 각 섹션의 상단에 여백 추가 */
    padding-bottom: 50px;  /* 섹션 하단 여백 추가 */
    margin-bottom: 150px; /* 섹션 간의 간격을 주기 위해 하단에 마진 추가 */
}
.weather-header {
    display: flex;
    align-items: center; /* 수직 중앙 정렬 */
}
.weather-icon {
    margin-right: 10px; /* 아이콘과 텍스트 간의 간격 조정 */
    width: 40px; /* 아이콘 크기 조정 */
    height: auto; /* 비율 유지 */
    vertical-align: middle; /* 수직 정렬 */
}
</style>
<body>
<!-- 배너 영역 -->
<section>
	<section class="banner">
	    <div class="slide_div_wrap">
	        <div class="slide_div">
	            <div>
	                <a href="/main/clothes/newCollection">
	                    <img src="/static/img/banner1.gif" alt="New Collection">
	                </a>
	            </div>
	            <div>
	                <a href="/main/clothes/bestSeller">
	                    <img src="/static/img/banner2.gif" alt="Best Seller">
	                </a>
	            </div>
	            <div>
	                <a href="/main/clothes/winterCollection">
	                    <img src="/static/img/banner3.gif" alt="Winter Collection">
	                </a>
	            </div>
	            <div>
	                <a href="/main/clothes/managerPickCloth">
	                    <img src="/static/img/banner4.gif" alt="Manager's Pick">
	                </a>
	            </div>
	            <div>
	                <a>
	                    <img src="/static/img/banner5.png" alt="Banner 5">
	                </a>
	            </div>            
	        </div>    
	    </div>
	</section>

	<!-- 상품 영역 -->
	<section class="contents">
		<h2 class="pt-2">Best Seller <i class="fa-solid fa-fire"></i></h2>
		<hr>
		<!-- 상품 목록 -->
		<div class="d-flex flex-wrap justify-content-start mt-3" style="gap: 25px;">
		    <c:forEach var="bestSellerCloth" items="${bestSellerClothes}">
		        <a href="/main/clothes-detail?id=${bestSellerCloth.clothId}" class="text-dark my-2">
		            <div>
		                <img src="${bestSellerCloth.clothImagePath}" class="img-fluid" style="width: 260px; height: 325px;">
		                <div style="font-size: 18px; font-weight: bold;" class="my-1">${bestSellerCloth.clothName}</div> <!-- 찐하게 강조 -->
		                <del style="font-size: 15px;"> <i class="fa-solid fa-won-sign"></i> ${bestSellerCloth.clothRegularPrice}</del>
		                <div style="font-size: 15px;"> <i class="fa-solid fa-won-sign"></i> ${bestSellerCloth.clothPrice}</div>
		            </div>
		        </a>
		    </c:forEach>
		</div>
	</section>

	<!-- 상품 영역 -->
	<section class="contents">
		<h2 class="pt-2 weather-header">
		    <img src="http://openweathermap.org/img/wn/${weather.icon}.png" alt="${weather.weather}" class="weather-icon"> 
			오늘의 날씨 : ${weather.weather} & ${weather.temperature}°C
		</h2>
		<hr>
		<!-- 상품 목록 -->
		<div class="d-flex flex-wrap justify-content-start mt-3" style="gap: 25px;">
		    <c:forEach var="weatherCloth" items="${weatherClothes}">
		        <a href="/main/clothes-detail?id=${weatherCloth.clothId}" class="text-dark my-2">
		            <div>
		                <img src="${weatherCloth.clothImagePath}" class="img-fluid" style="width: 260px; height: 325px;">
		                <div style="font-size: 18px; font-weight: bold;" class="my-1">${weatherCloth.clothName}</div> <!-- 찐하게 강조 -->
		                <del style="font-size: 15px;"> <i class="fa-solid fa-won-sign"></i> ${weatherCloth.clothRegularPrice}</del>
		                <div style="font-size: 15px;"> <i class="fa-solid fa-won-sign"></i> ${weatherCloth.clothPrice}</div>
		            </div>
		        </a>
		    </c:forEach>
		</div>
	</section>
	
	<!-- 상품 영역 -->
	<section class="contents">
		<h2 class="pt-2"><i class="fa-solid fa-up-long"></i> to 50%~ 특가 할인 중인 상품</h2>
		<hr>
		<!-- 상품 목록 -->
		<div class="d-flex flex-wrap justify-content-start mt-3" style="gap: 25px;">
		    <c:forEach var="onSaleCloth" items="${onSaleClothes}">
		        <a href="/main/clothes-detail?id=${onSaleCloth.clothId}" class="text-dark my-2">
		            <div>
		                <img src="${onSaleCloth.clothImagePath}" class="img-fluid" style="width: 260px; height: 325px;">
		                <div style="font-size: 18px; font-weight: bold;" class="my-1">${onSaleCloth.clothName}</div> <!-- 찐하게 강조 -->
		                <del style="font-size: 15px;"> <i class="fa-solid fa-won-sign"></i> ${onSaleCloth.clothRegularPrice}</del>
		                <div style="font-size: 15px;"> <i class="fa-solid fa-won-sign"></i> ${onSaleCloth.clothPrice}</div>
		            </div>
		        </a>
		    </c:forEach>
		</div>
	</section>
	
	<!-- 상품 영역 -->
	<c:if test="${recommendedClothes != null}">
	    <section class="contents">
	        <h2 class="pt-2">${userName }님이 좋아할 만한 상품</h2>
	        <hr>
	        <!-- 상품 목록 -->
	        <div class="d-flex flex-wrap justify-content-start mt-3" style="gap: 25px;">
	            <c:forEach var="recommendedCloth" items="${recommendedClothes}">
	                <a href="/main/clothes-detail?id=${recommendedCloth.clothId}" class="text-dark my-2">
	                    <div>
	                        <img src="${recommendedCloth.clothImagePath}" class="img-fluid" style="width: 260px; height: 325px;">
	                        <div style="font-size: 18px; font-weight: bold;" class="my-1">${recommendedCloth.clothName}</div>
	                        <del style="font-size: 15px;"> <i class="fa-solid fa-won-sign"></i> ${recommendedCloth.clothRegularPrice}</del>
	                        <div style="font-size: 15px;"> <i class="fa-solid fa-won-sign"></i> ${recommendedCloth.clothPrice}</div>
	                    </div>
	                </a>
	            </c:forEach>
	        </div>
	    </section>
	</c:if>
</section>

<script>
	var $jq = jQuery.noConflict();
	$jq(document).ready(function() { 
	  	$jq(".slide_div").slick(
			{
				dots: true,
				autoplay : true,
				autoplaySpeed: 5000
			}
		);
	});
</script>

</body>
</html>