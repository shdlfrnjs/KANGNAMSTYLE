<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Page</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/static/css/style.css" type="text/css">
<style>
/* 전체 페이지 스타일 */
body {
    background-color: #f8f9fa; /* 전체적으로 밝은 회색 배경 */
    color: #333; /* 기본 텍스트 색상 */
    font-family: 'Arial', sans-serif;
}

.container {
    margin-top: 20px;
    margin-bottom: 20px;
    background-color: #fff;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 카드 스타일 느낌 */
}

/* 주문 리스트 스타일 */
.order-summary h4 {
    border-bottom: 2px solid #333;
    padding-bottom: 10px;
    color: #333;
}

.table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 40px;
    margin-bottom: 40px;
}

.table th, .table td {
    border-top: 1px solid #dee2e6; /* 상단에만 테두리 */
    border-bottom: 1px solid #dee2e6; /* 하단에만 테두리 */
    padding: 15px;
    vertical-align: middle;
    text-align: center;
    color: #333;
}

.table th {
    background-color: #333;
    color: #fff;
    text-transform: uppercase;
}

.table td {
    background-color: #fff;
}

/* 상품 정보 스타일 */
.product-info {
    display: flex;
    align-items: center;
}

.product-info img {
    width: 70px;
    height: 70px;
    margin-right: 15px;
    border-radius: 5px;
    border: 1px solid #ddd;
}

.product-info .product-details {
    text-align: left;
}

.product-info .product-details .productName {
    font-weight: bold;
    font-size: 1.2em;
    color: #333;
}

.product-info .product-details .productColorSize {
    font-size: 0.9em;
    color: #6c757d;
}

/* 총 결제 금액 섹션 */
.total-price {
    margin-top: 20px;
    font-size: 1.3em;
    font-weight: bold;
    color: #333;
}

/* 폼 스타일 */
.order-form {
    margin-top: 40px;
}

.order-form h2 {
    font-size: 1.5em;
    font-weight: bold;
    color: #333;
    border-bottom: 2px solid #333;
    padding-bottom: 10px;
    margin-top: 40px; /* 각 섹션 위쪽 간격 */
    margin-bottom: 30px; /* 각 섹션 사이의 간격 */
}

.order-form .form-group {
    margin-bottom: 20px;
}

.order-form .form-control {
    border-radius: 5px;
    padding: 10px;
    font-size: 1em;
    border: 1px solid #ddd;
}

#paymentMethod {
    height: auto; /* 자동 높이로 설정 */
    padding: 8px; /* 안쪽 여백 추가 */
    line-height: 1.5; /* 글씨 높이 조정 */
    box-sizing: border-box; /* 패딩을 포함하여 크기 계산 */
}

/* 버튼 스타일 */
.order-form .form-group input[type="button"] {
	background-color: #000; /* 검은색 배경 */
	color: #fff; /* 하얀색 텍스트 */
	border: 1px solid #000; /* 하얀색 테두리 */
	padding: 10px 20px;
	border-radius: 5px; /* 둥근 모서리 */
	cursor: pointer;
	transition: background-color 0.3s ease, color 0.3s ease;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 버튼 그림자 추가 */
}

/* 버튼 마우스 오버 시 */
.order-form .form-group input[type="button"]:hover {
	background-color: #fff; /* 하얀색 배경 */
	color: #000; /* 검은색 텍스트 */
	border: 1px solid #000; /* 검은색 테두리 */
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3); /* 호버 시 그림자 깊이 증가 */
}
</style>
</head>

<header>
	<jsp:include page="../include/header.jsp" />
</header>

<body>

	<!-- jQuery -->
	<script type="text/javascript"
		src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<!-- iamport.payment.js -->
	<script type="text/javascript"
		src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

	<div class="container">
		<h2>${userName }님의 주문 확인 <i class="fa-solid fa-clipboard-check"></i></h2>
		<!-- 주문 요약 섹션 -->
		<div class="order-summary">
			<h4></h4>
			<table class="table text-center">
				<thead>
					<tr>
						<th>상품정보</th>
						<th>판매가격</th>
						<th>수량</th>
						<th>결제할 금액</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="order" items="${orderList}">
						<tr>
							<!-- 상품정보 -->
                            <td style="vertical-align: middle;" class="product-info">
                                <img src="${order.clothImagePath }" alt="상품 이미지">
                                <div class="product-details">
                                    <div class="productName" data-name="${order.clothName}">${order.clothName }</div>
                                    <div class="productColorSize">${order.clothColor }, ${order.clothSize }</div>
                                </div>
                            </td>
                            
                            <!-- 판매가격 -->
                            <td style="vertical-align: middle;">${order.clothPrice } 원</td>
                            
                            <!-- 수량 -->
							<td style="vertical-align: middle;">${order.clothCount}</td>
                            
                            <!-- 결제할 금액 -->
                            <td style="vertical-align: middle;" class="expected-price">
                                <c:set var="expectedPrice" value="${order.clothPrice * order.clothCount }" />
                                ${expectedPrice } 원
                            </td>
                            
                            <!-- 총 결제 금액 -->
							<c:set var="totalPrice"
								value="${totalPrice + order.clothPrice * order.clothCount }" />
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- 총 결제 금액 -->
		<div class="text-right total-price">
			<h5>
				총 결제할 금액: <span>${totalPrice} 원</span>
			</h5>
		</div>
		<!-- 주문 정보 입력 폼 -->
		<div class="order-form mt-3">
			<form id="orderForm" action="/order/orderCreate" method="post">
				
				<!-- 구매자 정보 섹션 -->
				<h2>구매자 정보</h2>
				<div class="form-check mb-3">
					<input type="checkbox" class="form-check-input" id="sameAsUserInfo">
					<label class="form-check-label" for="sameAsUserInfo">회원 정보와
						동일</label>
						
				</div>
				<!-- 이름 -->
				<div class="form-group">
					<label for="buyerName">이름</label> <input type="text"
						class="form-control" id="buyerName" name="buyerName"
						placeholder="ex)홍길동" required>
				</div>

				<!-- 전화번호 -->
				<div class="form-group">
					<label for="buyerPhone">전화번호</label> <input type="text"
						class="form-control" id="buyerPhone" name="buyerPhone"
						placeholder="ex)01012345678" required>
				</div>

				<!-- 이메일 -->
				<div class="form-group">
					<label for="buyerEmail">이메일</label> <input type="email"
						class="form-control" id="buyerEmail" name="buyerEmail"
						placeholder="example@example.com" required>
				</div>

				<!-- 배송지 정보 섹션 -->
				<h2>배송지 입력</h2>
				<div class="form-check mb-4">
					<input type="checkbox" class="form-check-input"
						id="sameAsRecipientInfo"> <label class="form-check-label"
						for="sameAsRecipientInfo">회원 정보와 동일</label>
				</div>
				<!-- 받으실 분 이름 -->
				<div class="form-group">
					<label for="recipientName">받으실 분</label> <input type="text"
						class="form-control" id="recipientName" name="recipientName"
						placeholder="ex)홍길동" required>
				</div>
				<!-- 받으실 분 전화번호 -->
				<div class="form-group">
					<label for="recipientPhone">전화번호 (받으실 분)</label> <input type="text"
						class="form-control" id="recipientPhone" name="recipientPhone"
						placeholder="ex)01012345678" required>
				</div>
				<!-- 주소 -->
				<div class="form-group">
					<label for="recipientAddress">주소</label> <input type="text"
						class="form-control" id="recipientAddress" name="recipientAddress"
						placeholder="ex)서울특별시 강남구..." required>
				</div>

				<!-- 결제 정보 섹션 -->
				<h2>결제 정보</h2>
				<div class="form-group">
					<label for="paymentMethod">결제 수단</label> <select
						class="form-control" id="paymentMethod" name="paymentMethod"
						required>
						<option value="">결제 수단을 선택하세요.</option>
						<option value="card">신용카드</option>
					</select>
				</div>

				<!-- 주문 버튼 -->
				<div class="form-group mt-5 text-center">
					<input type="button" value="돌아가기" id="cancelOrderBtn">
					<input type="button" value="결제하기" id="orderButton" onclick="requestPay()">
				</div>
			</form>
		</div>
	</div>
	
	<!-- 포트원 결제 스크립트 -->
    <script>
        var IMP = window.IMP;
        IMP.init("imp37255548");
     	
        // 서버에서 모델로 전달된 ids를 JavaScript 배열로 변환
        var ids = ${ids}; // IDs를 JSP에서 JavaScript 변수로 변환
        
        function requestPay() {
            // 폼 유효성 검사 확인
            var form = document.getElementById('orderForm');
            if (form.checkValidity() === false) {
                // 폼이 유효하지 않으면 결제 창을 띄우지 않음
                form.reportValidity(); // 브라우저가 기본 유효성 오류 메시지 표시
                return;
            }
            
            var buyerName = $("#buyerName").val(); // 구매자 이름
            var buyerEmail = $("#buyerEmail").val(); // 구매자 이메일
            var buyerPhone = $("#buyerPhone").val(); // 구매자 전화번호
            var buyerAddr = $("#recipientAddress").val(); // 배송지 주소 (배송지 정보가 아니라면 필요 없음)
            var paymethod = $("#paymentMethod").val(); // 결제 수단
            
            // 주문할 상품명 배열
            var productNames = [];
            $(".productName").each(function() {
                productNames.push($(this).data("name"));
            });
            // 상품명 배열을 문자열로 변환
            var productName = productNames.join(", ");
            
            var amount = ${totalPrice}; // 결제 금액

            IMP.request_pay({
                pg: "html5_inicis.INIpayTest",
                pay_method: paymethod,
                name: productName,
                amount: amount,
                buyer_email: buyerEmail,
                buyer_name: buyerName,
                buyer_tel: buyerPhone,
                buyer_addr: buyerAddr,
            }, function(rsp) {
                if (rsp.success) {
                    $.ajax({
                        type: 'POST',
                        url: '/order/' + rsp.imp_uid // 결제 검증 URL
                    }).done(function(data) {
                        if (rsp.paid_amount === data.response.amount) {
                            // 결제 검증 성공 후 주문 완료 요청
                            $.ajax({
                                type: 'PUT',
                                url: '/basket/orderComplete',
                                data: { "ids": ids }, // basket IDs 배열 전송
                				traditional: true, // 필요 시 사용
                                success: function(data) {
                                    if (data.result == "success") {
                                    	$.ajax({
                                    	    type: "POST",
                                    	    url: "/order/orderCreate",
                                    	    data: {
                                    	        "ids": ids,
                                    	        "imp_uid": rsp.imp_uid, // imp_uid 추가
                                    	        "buyerName": $("#buyerName").val(),    // 구매자 이름
                                    	        "recipientName": $("#recipientName").val(), // 수령자 이름
                                    	        "recipientPhone": $("#recipientPhone").val(), // 수령자 전화번호
                                    	        "recipientAddress": $("#recipientAddress").val(), // 수령자 주소
                                    	        "paymentMethod": $("#paymentMethod").val() // 결제 방법
                                    	    },
                                    	    success: function(data) {
                                    	        if (data.result == "success") {
                                    	            alert("주문 완료! 감사합니다.");
                                    	            window.location.href = "/main-view";
                                    	        } else {
                                    	            alert("주문 처리에 실패했습니다.");
                                    	        }
                                    	    },
                                    	    error: function() {
                                    	        alert("서버 오류가 발생했습니다.");
                                    	    }
                                    	});
                                    } else {
                                        // 재고가 부족할 경우 결제 취소
                                        alert("상품 재고가 부족합니다. 결제를 취소합니다.");
                                        $.ajax({
                                            type: "POST",
                                            url: "/order/cancel",
                                            data: JSON.stringify({
                                                imp_uid: rsp.imp_uid // imp_uid를 서버에 전송
                                            }),
                                            contentType: "application/json",
                                            success: function(cancelData) {
                                                if (cancelData.result === "success") {
                                                    alert("결제가 취소되었습니다.");
                                                    window.location.href = "/basket/list-view";
                                                } else {
                                                    alert("결제 취소에 실패했습니다: " + cancelData.message);
                                                }
                                            },
                                            error: function(jqXHR, textStatus, errorThrown) {
                                                console.error("Error occurred: ", textStatus, errorThrown);
                                                alert("결제 취소 요청 중 오류가 발생했습니다.");
                                            }
                                        });
                                    }
                                },
                                error: function() {
                                    alert("주문 완료 요청 중 오류 발생");
                                }
                            });
                        } else {
                            alert("결제 금액 불일치");
                        }
                    }).fail(function() {
                        alert("결제 검증 요청 중 오류 발생");
                    });
                } else {
                    alert("결제 요청 실패: " + rsp.error_msg);
                }
            });
        }
    </script>
	
	<!-- JavaScript -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>

	<script>
		$(document).ready(function() {
			// 사용자 정보 자동 입력
			$("#sameAsUserInfo").on("change", function() {
				if ($(this).is(":checked")) {
					// 사용자 정보로 구매자 정보 채우기
					$("#buyerName").val("${userName}");
					$("#buyerPhone").val("${userPhone}");
					$("#buyerEmail").val("${userEmail}");
				} else {
					// 체크 해제 시 구매자 정보 초기화
					$("#buyerName").val("");
					$("#buyerPhone").val("");
					$("#buyerEmail").val("");
				}
			});
	
			// 배송지 정보 자동 입력
			$("#sameAsRecipientInfo").on("change", function() {
				if ($(this).is(":checked")) {
					// 사용자 정보로 배송지 정보 채우기
					$("#recipientName").val("${userName}");
					$("#recipientPhone").val("${userPhone}");
					$("#recipientAddress").val("${userAddress}");
				} else {
					// 체크 해제 시 배송지 정보 초기화
					$("#recipientName").val("");
					$("#recipientPhone").val("");
					$("#recipientAddress").val("");
				}
			});
	
			// 주문 취소 버튼 클릭 시 페이지 이동
			$("#cancelOrderBtn").on("click", function() {
				alert("주문 취소 완료!");
			    window.location.href = "/basket/list-view"; // 취소 후 이동할 페이지
			});
	
			// 로고 클릭 시 페이지 이동
			$("#logo").on("click", function(e) {
				alert("주문 취소 완료!");
			    window.location.href = "/main-view"; // 이동할 페이지
			});
		});
	</script>

</body>
</html>
