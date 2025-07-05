<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Product Detail</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.18/dist/css/bootstrap-select.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/js/bootstrap-select.min.js"></script>
</head>

<style>
.product-detail {
    padding: 40px 0;
}

.container {
    max-width: 1200px;
    margin: auto;
}

.image-section {
    text-align: center;
    padding-right: 20px;
}

.product-image {
	width: 500px;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.info-section {
    padding-left: 20px;
}

.product-category {
    font-size: 16px; /* 카테고리와 서브카테고리의 글자 크기 */
    color: #666; /* 회색 글자색 */
    margin-bottom: 5px; /* 상품명과의 간격 */
}

.product-name {
    font-size: 32px;
    font-weight: bold;
    color: #212529; /* Dark color */
}

.product-price {
    font-size: 1.8rem; /* 가격 크기 */
    font-weight: 600; /* 굵기 */
    color: #000; /* 검은색 */
    margin-top: 10px;
}

.product-price span {
    color: #ff5722; /* 강조색 */
}

.size-selection {
    margin-top: 15px;
}

.selectpicker {
    background-color: #ffffff;
    border: 1px solid #343a40; /* Dark border */
    border-radius: 5px;
    padding: 8px;
}

.quantity-section {
    display: flex;
    flex-direction: column;
}

.btn-control {
    background-color: black; /* Dark background */
    color: white;
}

.btn-control:hover {
    background-color: white; /* Darker shade */
    color: black;
}

.action-buttons .btn {
    border-radius: 5px;
    font-weight: bold;
}

.btn-black {
        background-color: black;
        color: white;
        border: 1px solid black;
}

.btn-black:hover {
    background-color: white;
    color: black;
    border: 1px solid black;
}

.btn-gray {
    background-color: gray;
    color: white;
    border: 1px solid black;
}

.btn-gray:hover {
    background-color: white;
    color: black;
    border: 1px solid black;
}

.btn-white {
    background-color: white;
    color: black;
    border: 1px solid black;
}

.btn-white:hover {
    background-color: black;
    color: white;
    border: 1px solid black;
}
</style>

<body>

<section class="product-detail">
    <div class="container">
        <div class="row">
            <div class="col-md-6 image-section">
                <img src="${clothInfo.clothImagePath}" alt="${clothInfo.clothName}" class="product-image">
            </div>
            <div class="col-md-6 info-section">
            	<div class="product-category">
            		<i class="fa-solid fa-hashtag"></i>
				    <c:choose>
				        <c:when test="${clothInfo.clothCategory == 1}">
				            <span>아우터</span>
				        </c:when>
				        <c:when test="${clothInfo.clothCategory == 2}">
				            <span>상의</span>
				        </c:when>
				        <c:when test="${clothInfo.clothCategory == 3}">
				            <span>하의</span>
				        </c:when>
				        <c:when test="${clothInfo.clothCategory == 4}">
				            <span>신발</span>
				        </c:when>
				        <c:when test="${clothInfo.clothCategory == 5}">
				            <span>액세서리</span>
				        </c:when>
				        <c:otherwise>
				            <span></span>
				        </c:otherwise>
				    </c:choose>
				    <i class="fa-solid fa-angle-right"></i>
				    <c:choose>
				        <c:when test="${clothInfo.clothCategory == 1}">
				            <c:choose>
				                <c:when test="${clothInfo.clothSubCategory == 'hoodie_jacket'}">후드 집업</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'blouson_ma1'}">블루종/MA-1</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'leather_riders'}">레더/라이더스 재킷</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'mustang_fur'}">무스탕/퍼</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'trucker'}">트러커 재킷</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'blazer_suit'}">슈트/블레이저 재킷</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'cardigan'}">카디건</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'anorak'}">아노락 재킷</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'fleece'}">플리스/뽀글이</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'training'}">트레이닝 재킷</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'stadium'}">스타디움 재킷</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'transition_coat'}">환절기 코트</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'winter_single_coat'}">겨울 싱글 코트</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'winter_double_coat'}">겨울 더블 코트</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'winter_other_coat'}">겨울 기타 코트</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'long_padding'}">롱패딩/헤비 아우터</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'short_padding'}">숏패딩/헤비 아우터</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'padding_vest'}">패딩 베스트</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'vest'}">베스트</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'safari_hunting'}">사파리/헌팅 재킷</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'nylon_coach'}">나일론/코치 재킷</c:when>
				                <c:otherwise>기타 아우터</c:otherwise>
				            </c:choose>
				        </c:when>
				        <c:when test="${clothInfo.clothCategory == 2}">
				            <c:choose>
				                <c:when test="${clothInfo.clothSubCategory == 'sweatshirt'}">맨투맨/스웨트</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'shirt'}">셔츠/블라우스</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'hoodie'}">후드 티셔츠</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'knit'}">니트/스웨터</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'polo'}">피케/카라 티셔츠</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'longsleeve'}">긴소매 티셔츠</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'shortsleeve'}">반소매 티셔츠</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'sleeveless'}">민소매 티셔츠</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'sports_top'}">스포츠 상의</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'other_top'}">기타 상의</c:when>
				                <c:otherwise>기타 상의</c:otherwise>
				            </c:choose>
				        </c:when>
				        <c:when test="${clothInfo.clothCategory == 3}">
				            <c:choose>
				                <c:when test="${clothInfo.clothSubCategory == 'denim_pants'}">데님 팬츠</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'cotton_pants'}">코튼 팬츠</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'suit_slacks'}">슈트 팬츠/슬랙스</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'jogger_pants'}">트레이닝/조거 팬츠</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'shorts'}">숏 팬츠</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'leggings'}">레깅스</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'jumpsuit_overalls'}">점프 슈트/오버올</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'sports_bottom'}">스포츠 하의</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'other_bottom'}">기타 바지</c:when>
				                <c:otherwise>기타 바지</c:otherwise>
				            </c:choose>
				        </c:when>
				        <c:when test="${clothInfo.clothCategory == 4}">
				            <c:choose>
				                <c:when test="${clothInfo.clothSubCategory == 'sneakers'}">스니커즈</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'shoes'}">구두</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'sandals_slippers'}">샌들/슬리퍼</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'boots_walkers'}">부츠/워커</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'sports_shoes'}">운동화</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'other_shoes'}">기타 신발</c:when>
				                <c:otherwise>기타 신발</c:otherwise>
				            </c:choose>
				        </c:when>
				        <c:when test="${clothInfo.clothCategory == 5}">
				            <c:choose>
				                <c:when test="${clothInfo.clothSubCategory == 'hat'}">모자</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'bag'}">가방</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'watch'}">시계</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'jewelry'}">주얼리</c:when>
				                <c:when test="${clothInfo.clothSubCategory == 'other_accessory'}">기타 액세서리</c:when>
				                <c:otherwise>기타 액세서리</c:otherwise>
				            </c:choose>
				        </c:when>
				        <c:otherwise>
				            <span></span>
				        </c:otherwise>
				    </c:choose>
				</div>
                <h1 class="product-name">${clothInfo.clothName}</h1>
                <h3 class="product-price"> <i class="fa-solid fa-won-sign"></i> ${clothInfo.clothPrice}</h3>
                
                <hr>

                <div class="size-selection">
                    <select class="selectpicker" id="selectSize">
                        <option value="0" selected>사이즈 선택</option>
                        <c:if test="${sizeInfo.size_XS > 0}">
                            <option value="XS">XS</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_S > 0}">
                            <option value="S">S</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_M > 0}">
                            <option value="M">M</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_L > 0}">
                            <option value="L">L</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_XL > 0}">
                            <option value="XL">XL</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_2XL > 0}">
                            <option value="2XL">2XL</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_26 > 0}">
                            <option value="26">26</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_28 > 0}">
                            <option value="28">28</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_30 > 0}">
                            <option value="30">30</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_32 > 0}">
                            <option value="32">32</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_34 > 0}">
                            <option value="34">34</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_36 > 0}">
                            <option value="36">36</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_38 > 0}">
                            <option value="38">38</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_40 > 0}">
                            <option value="40">40</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_240 > 0}">
                            <option value="240">240</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_245 > 0}">
                            <option value="245">245</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_250 > 0}">
                            <option value="250">250</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_255 > 0}">
                            <option value="255">255</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_260 > 0}">
                            <option value="260">260</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_265 > 0}">
                            <option value="265">265</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_270 > 0}">
                            <option value="270">270</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_275 > 0}">
                            <option value="275">275</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_280 > 0}">
                            <option value="280">280</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_285 > 0}">
                            <option value="285">285</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_290 > 0}">
                            <option value="290">290</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_295 > 0}">
                            <option value="295">295</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_300 > 0}">
                            <option value="300">300</option>
                        </c:if>
                        <c:if test="${sizeInfo.size_free > 0}">
                            <option value="free">free</option>
                        </c:if>
                    </select>
                </div>

                <div class="quantity-section mt-3">
				    <div class="d-flex align-items-center">
				        <button type="button" class="btn btn-control btn-lg px-3 d-flex align-items-center justify-content-center" 
				                id="decCntBtn" style="height: 45px;">-</button>
				        <input type="text" class="form-control text-center mx-2" value="1" id="productCnt" autocomplete="off" style="width: 80px; height: 45px;">
				        <button type="button" class="btn btn-control btn-lg px-3 d-flex align-items-center justify-content-center" 
				                id="incCntBtn" style="height: 45px;">+</button>
				    </div>
				</div>

                <div class="action-buttons mt-3">
                	<button type="button" class="btn btn-black col-6 mt-3" id="likeBtn"><i class="fa-solid fa-heart"></i></button>
				    <button type="button" class="btn btn-black col-6 mt-3" id="orderProductBtn">구매하기</button>
				    <button type="button" class="btn btn-black col-6 mt-3" id="addCartBtn">장바구니</button>
				    <button type="button" class="btn btn-white col-6 mt-3" onclick="window.history.back()">돌아가기</button>
				</div>
            </div>
        </div>
    </div>
</section>
	<script>
	    // noConflict 모드로 jQuery를 사용
	    var jq = jQuery.noConflict();
	
	    jq(document).ready(function() {
	        let chooseSize = 0;
	        let cnt = 1;
	
	        jq("#productCnt").on("input", function() {
	            cnt = jq("#productCnt").val();
	        });
	
	        jq("#incCntBtn").on("click", function() {
	            cnt = jq("#productCnt").val();
	            cnt++;
	            jq("#productCnt").val(cnt);
	        });
	
	        jq("#decCntBtn").on("click", function() {
	            if (cnt > 1) {
	                cnt = jq("#productCnt").val();
	                cnt--;
	                jq("#productCnt").val(cnt);
	            } else {
	                alert("0 이하의 숫자는 입력할 수 없습니다.");
	                jq("#productCnt").val(1); // 0 이하로 입력한 후 버튼 눌렀을 때 기본 숫자 1로 만들어주기
	            }
	        });
	
	        jq("#selectSize").change(function() {
	            let selectSize = document.getElementById("selectSize");
	            let size = selectSize.options[selectSize.selectedIndex].value;
	            chooseSize = size;
	        });
	
	        jq('#likeBtn').click(function() {
	            var clothId = "${clothInfo.id}"; // 상품 ID 가져오기
	
	            jq.ajax({
	                type: "POST",
	                url: "/user/add/like",
	                data: { "clothId": clothId },
	                success: function(data) {
	                    if (data.result == "success") {
	                        if (confirm("상품이 찜목록에 추가되었습니다! 마이페이지로 이동하시겠습니까?")) {
	                            window.location.href = "/user/myPage-view";
	                        }
	                    } else if (data.result === "already_exists") {
	                        if (confirm("이미 찜목록에 추가된 상품입니다. 삭제하시겠습니까?")) {
	                            jq.ajax({
	                                type: "POST",
	                                url: "/user/delete/like",
	                                data: { "clothId": clothId },
	                                success: function(data) {
	                                    if (data.result === "success") {
	                                        if (confirm("상품이 찜목록에서 삭제되었습니다. 마이페이지로 이동하시겠습니까?")) {
	                                            window.location.href = "/user/myPage-view";
	                                        }
	                                    } else {
	                                        alert("삭제할 상품을 찾을 수 없습니다.");
	                                    }
	                                },
	                                error: function() {
	                                    alert("오류가 발생했습니다.");
	                                }
	                            });
	                        }
	                    }
	                },
	                error: function() {
	                    alert("로그인이 필요합니다.");
	                    window.location.href = "/user/sign-in-view";
	                }
	            });
	        });
	
	        jq("#orderProductBtn").on("click", function() {
	            var clothName = "${clothInfo.clothName}";
	
	            if (chooseSize == 0) {
	                alert("사이즈를 선택하세요");
	                return;
	            }
	
	            // 장바구니 ID를 저장할 배열 선언
	            var basketIds = [];
	
	            jq.ajax({
	                type: "get",
	                url: "/user/add-basket",
	                data: {
	                    "clothName": clothName,
	                    "clothSize": chooseSize,
	                    "clothCount": cnt
	                },
	                success: function(data) {
	                    if (data.result == "success") {
	                        // 반환된 basketId를 배열에 추가
	                        basketIds.push(data.basketId);
	
	                        // 주문이 성공했을 때 basketIds 데이터를 서버로 전송하고 페이지 이동
	                        window.location.href = "/order?ids=" + basketIds.join(",");
	                    } else {
	                        alert("장바구니 추가 실패.");
	                    }
	                },
	                error: function() {
	                    alert("로그인이 필요합니다.");
	                    window.location.href = "/user/sign-in-view";
	                }
	            });
	        });
	
	        jq("#addCartBtn").on("click", function() {
	            var clothName = "${clothInfo.clothName}";
	
	            if (chooseSize == 0) {
	                alert("사이즈를 선택하세요");
	                return;
	            }
	
	            jq.ajax({
	                type: "get",
	                url: "/user/add-basket",
	                data: {
	                    "clothName": clothName,
	                    "clothSize": chooseSize,
	                    "clothCount": cnt
	                },
	                success: function(data) {
	                    if (data.result == "success") {
	                        if (confirm("장바구니에 담겼습니다! 장바구니로 이동하시겠습니까?")) {
	                            window.location.href = '/basket/list-view'; // 장바구니 페이지로 이동
	                        }
	                    } else {
	                        alert("장바구니 담기 실패.");
	                    }
	                },
	                error: function() {
	                    alert("로그인이 필요합니다.");
	                    window.location.href = "/user/sign-in-view";
	                }
	            });
	        });
	
	        jq(".selectpicker").selectpicker({});
	    });
	</script>
	
</body>

</html>