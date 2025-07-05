<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<%-- 신상품 --%>
<section>
    <div>
        <div class="d-flex align-items-center mt-5">
            <h3 class="my-0">
                New Collection <i class="fa-solid fa-bolt"></i>
            </h3>
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
