<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Cart</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/static/css/style.css" type="text/css">
<style>
    /* Black and White theme */
    body {
        background-color: #f8f9fa;
        color: #343a40;
        font-family: Arial, sans-serif;
    }

    .table-container {
        margin: 0 auto;
        width: 100%;
    }

    table {
        background-color: white;
        width: 100%; /* 테이블을 컨테이너에 맞게 확장 */
    }

    th, td {
        vertical-align: middle;
    }

    th {
        background-color: #333333;
        color: white;
        text-align: center;
    }

    td {
        text-align: center;
    }

    h2 {
        margin: 20px 0;
    }

    .total-price-container {
        text-align: right;
        font-size: 1.2em;
        font-weight: bold;
        margin-top: 20px;
        color: #343a40;
    }

    .product-info {
        display: flex;
        align-items: center;
    }

    .product-info img {
        width: 70px;
        height: 70px;
        margin-right: 15px;
    }

    .product-info .product-details {
        text-align: left;
    }

    .product-info .product-details .product-name {
        font-weight: bold;
        font-size: 1.1em;
    }

    .product-info .product-details .product-colorsize {
        font-size: 0.9em;
        color: #6c757d; /* 작은 글씨로 색상 표시 */
    }
    
    /* 주문 버튼 스타일 */
	.orderBtn, #orderBtn {
		background-color: #000; /* 검은색 배경 */
		color: #fff; /* 하얀색 텍스트 */
		border: 1px solid #000; /* 검은색 테두리 */
		padding: 10px 20px;
		border-radius: 5px; /* 둥근 모서리 */
		cursor: pointer;
		transition: background-color 0.3s ease, color 0.3s ease;
		box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 버튼 그림자 추가 */
	}

	/* 마우스 오버 시 효과 */
	.orderBtn:hover, #orderBtn:hover {
		background-color: #fff; /* 하얀색 배경 */
		color: #000; /* 검은색 텍스트 */
		border: 1px solid #000; /* 검은색 테두리 */
		box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3); /* 호버 시 그림자 깊이 증가 */
	}

	/* 이외 버튼 스타일 */
	.deleteBtn, #cancelBtn {
		background-color: red; /* 빨간색 배경 */
		color: #fff; /* 하얀색 텍스트 */
		border: 1px solid red; /* 빨간색 테두리 */
		padding: 10px 20px;
		border-radius: 5px; /* 둥근 모서리 */
		cursor: pointer;
		transition: background-color 0.3s ease, color 0.3s ease;
		box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 버튼 그림자 추가 */
	}

	/* 삭제 버튼 마우스 오버 시 효과 */
	.deleteBtn:hover, #cancelBtn:hover {
		background-color: #fff; /* 하얀색 배경 */
		color: red; /* 빨간색 텍스트 */
		border: 1px solid red; /* 빨간색 테두리 */
		box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3); /* 호버 시 그림자 깊이 증가 */
	}
</style>
</head>
<body>
    <header>
        <jsp:include page="../include/header.jsp" />
    </header>

    <div class="container">
        <h2 class="ml-1">${userName }님의 장바구니 <i class="fa-solid fa-basket-shopping"></i> </h2>
        <div class="table-container">
            <table class="table text-center" id="basketList">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="selectAll" style="width: 15px; height: 15px;"></th>
                        <th>상품정보</th>
                        <th>판매가격</th>
                        <th>수량</th>
                        <th>결제할 금액</th>
                        <th>선택</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="basket" items="${basketList }">
                        <c:if test="${basket.clothStatus == '장바구니' }">
                            <tr>
                                <!-- 체크박스 -->
                                <td style="vertical-align: middle;">
                                	<input type="checkbox" class="item-checkbox" data-expected-price="${basket.clothPrice * basket.clothCount}" id="${basket.id }" style="width: 15px; height: 15px;">
                                </td>
                                
                                <!-- 상품정보 -->
                                <td style="vertical-align: middle;" class="product-info">
                                    <img src="${basket.clothImagePath }" alt="상품 이미지">
                                    <div class="product-details">
                                        <div class="product-name">${basket.clothName }</div>
                                        <div class="product-colorsize">${basket.clothColor }, ${basket.clothSize }</div>
                                    </div>
                                </td>
                                
                                <!-- 판매가격 -->
                                <td style="vertical-align: middle;">${basket.clothPrice }원</td>
                                
                                <!-- 수량 -->
								<td style="vertical-align: middle; text-align: center;">
								    <input type="number" class="form-control quantity-input" value="${basket.clothCount }" 
								        min="1" data-price="${basket.clothPrice }" data-id="${basket.id }" autocomplete="off" 
								        style="width: 60px; height: 40px; margin: 0 auto; font-size: 16px;">
								</td>
                                
                                <!-- 결제할 금액 -->
                                <td style="vertical-align: middle;" class="expected-price">
                                    <c:set var="expectedPrice" value="${basket.clothPrice * basket.clothCount }" />
                                    ${expectedPrice }원
                                </td>
                                
                                <!-- 주문/삭제 버튼 -->
                                <td style="vertical-align: middle;">
                                    <input type="button" class="orderBtn" data-basket-id="${basket.id }" value="주문">
                                    <input type="button" class="deleteBtn" data-basket-id="${basket.id }" value="삭제">
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </table>
        </div>
		<hr>        

        <!-- 총 금액 -->
        <div class="total-price-container">
            총 주문 금액: <span id="totalPrice">0</span>원
        </div>

        <!-- Buttons -->
        <div class="d-flex justify-content-between mt-3">
            <input type="button" id="cancelBtn" value="돌아가기" onclick="window.history.back()">
            <input type="button" id="orderBtn" value="주문하기">
        </div>
        
    </div>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>

    <script>
	    $(document).ready(function() {
	
	        // 모두 선택
	        $("#selectAll").on("click", function() {
	            $(".item-checkbox").prop('checked', this.checked);
	            updateTotalPrice();
	        });
	
	        // 체크박스 선택에 따라 주문 총 금액 변경
	        $(".item-checkbox").on("change", function() {
	            updateTotalPrice();
	        });
	
	        // 수량 변경에 의해 주문 총 금액 변경
	        $(".quantity-input").on("change", function() {
	            var price = $(this).data("price");
	            var quantity = $(this).val();
	            var basketId = $(this).data("id");
	
	            // 수량에 따라 결제 예정 금액 업데이트
	            var expectedPrice = price * quantity;
	            $(this).closest("tr").find(".expected-price").text(expectedPrice + " 원");
	
	            // 체크박스의 결제 예정 금액 데이터 업데이트
	            $(this).closest("tr").find(".item-checkbox").data("expected-price", expectedPrice);
	
	            // 총 금액 업데이트
	            updateTotalPrice();
	            
	         	// AJAX 요청으로 수량 업데이트
	            $.ajax({
	                type: "put", // put 메소드 사용
	                url: "/basket/update", // 서버에서 처리할 URL
	                data: {
	                    "id": basketId, // basket ID
	                    "clothCount": quantity // 수량
	                },
	                success: function(response) {
	                    // 서버 응답 처리
	                    if (response.result === "success") {
	                        console.log("수량이 성공적으로 업데이트되었습니다.");
	                    } else {
	                        alert("장바구니 수량은 최소 1개 이상이어야 합니다."); // 더 사용자 친화적인 메시지
	                        location.reload(); // 페이지 새로고침
	                    }
	                },
	                error: function() {
	                    alert("수량 업데이트 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
	                }
	            });
	        });
	
	        // 주문하기 버튼 클릭 이벤트
	        $("#orderBtn").on("click", function() {
	            var basketIds = [];
	
	            // 체크된 상품의 ID를 배열에 추가
	            $("input[type=checkbox]:checked").not("#selectAll").each(function() {
	                basketIds.push($(this).attr('id'));
	            });
	
	            // 체크된 상품이 없을 때 경고 메시지
	            if (basketIds.length === 0) {
	                alert("주문할 상품을 선택해주세요");
	                return;
	            }
	
	            // 주문이 성공했을 때 basketIds 데이터를 서버로 전송하고 페이지 이동
	            window.location.href = "/order?ids=" + basketIds.join(",");
	        });
	        
	        // 개별 주문 버튼 클릭 이벤트
	        $(".orderBtn").on("click", function() {
	            // 개별 ID를 배열에 추가
	            let basketId = $(this).data("basket-id");
	            var basketIds = [basketId]; 
	
	            // 주문이 성공했을 때 basketIds 데이터를 서버로 전송하고 페이지 이동
	            window.location.href = "/order?ids=" + basketIds.join(",");
	        });
	        
	        // 삭제 버튼 클릭 이벤트
	        $(".deleteBtn").on("click", function() {
	            let basketId = $(this).data("basket-id");
	
	            $.ajax({
	                type: "delete",
	                url: "/basket/delete",
	                data: { "id": basketId },
	                success: function(data) {
	                    if (data.result == "success") {
	                        location.reload();
	                    } else {
	                        alert("삭제 실패");
	                    }
	                },
	                error: function() {
	                    alert("삭제 에러");
	                }
	            });
	        });
	
	        // 총 금액을 업데이트하는 함수
	        function updateTotalPrice() {
	            var totalPrice = 0;
	
	            // 체크된 상품들의 결제 예정 금액 합산
	            $("input[type=checkbox]:checked").each(function() {
	                totalPrice += parseFloat($(this).data("expected-price")) || 0;
	            });
	
	            $("#totalPrice").text(totalPrice);
	        }
	    });
	</script>
    
</body>
</html>
