<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order List</title>
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
    .orderStatusSelect {
        width: 100%;
        padding: 5px;
        border: 1px solid #000000; /* 검은색 테두리 */
        border-radius: 4px;
        text-align: center;
        background-color: #ffffff; /* 흰색 배경 */
        color: #000000; /* 검은색 텍스트 */
    }
    /* 버튼 스타일 */
	.updateStatusBtn {
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
	.updateStatusBtn:hover {
		background-color: #fff; /* 하얀색 배경 */
		color: #000; /* 검은색 텍스트 */
		border: 1px solid #000; /* 검은색 테두리 */
		box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3); /* 호버 시 그림자 깊이 증가 */
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
	    주문 관리 <i class="fa-solid fa-truck-fast"></i>
	</h1>
</div>
<div>
	<table class="table text-center mt-3">
		<thead>
			<tr>
				<th>번호</th>
				<th>주문일</th>
				<th>주문번호</th>
				<th>주문내역</th>
				<th>회원 id</th>
				<th>받는 사람</th>
				<th>연락처</th>
				<th>배송지 주소</th>
				<th>배송상태</th>
				<th>배송수정</th>
			</tr>
		</thead>

		<tbody>
			<c:forEach var="order" items="${orderList}">
				<tr>
					<td style="vertical-align: middle;">${order.orderIndex}</td>
					<td style="vertical-align: middle;"><fmt:formatDate value="${order.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td style="vertical-align: middle;">${order.orderNumber}</td>
					<td style="vertical-align: middle;">${order.orderDetailsString}</td>
					<td style="vertical-align: middle;">${order.userLoginId}</td>
					<td style="vertical-align: middle;">${order.recipientName}</td>
					<td style="vertical-align: middle;">${order.recipientPhone}</td>
					<td style="vertical-align: middle;">${order.recipientAddress}</td>
					<td style="vertical-align: middle;">
						<select class="form-control orderStatusSelect" data-order-number="${order.orderNumber}" data-imp-uid="${order.imp_uid}">
							<c:choose>
								<%-- 현재 상태가 주문 완료일 경우 --%>
								<c:when test="${order.clothStatus == '주문 완료'}">
									<option value="주문 완료" selected>주문 완료</option>
									<option value="배송중">배송중</option>
									<option value="배송 완료">배송 완료</option>
								</c:when>
								<%-- 현재 상태가 배송중일 경우 --%>
								<c:when test="${order.clothStatus == '배송중'}">
									<option value="주문 완료">주문 완료</option>
									<option value="배송중" selected>배송중</option>
									<option value="배송 완료">배송 완료</option>
								</c:when>
								<%-- 현재 상태가 배송 완료일 경우 --%>
								<c:when test="${order.clothStatus == '배송 완료'}">
									<option value="주문 완료">주문 완료</option>
									<option value="배송중">배송중</option>
									<option value="배송 완료" selected>배송 완료</option>
								</c:when>
								<%-- 현재 상태가 주문 취소일 경우 --%>
								<c:when test="${order.clothStatus == '주문 취소'}">
									<option value="주문 취소" selected>주문 취소</option>
									<option value="주문 취소 완료">주문 취소 완료</option>
								</c:when>
								<%-- 현재 상태가 주문 취소 완료일 경우 --%>
								<c:when test="${order.clothStatus == '주문 취소 완료'}">
									<option value="주문 취소 완료" selected>주문 취소 완료</option>
								</c:when>
							</c:choose>
						</select>
					</td>
					<td style="vertical-align: middle;">
						<input type="button" value="수정하기" class="updateStatusBtn">
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<!-- 목록이 없을 경우 -->
	<c:if test="${empty orderList}">
	    <div class="text-center">
	        <h5>
	        	<i class="fa-solid fa-triangle-exclamation" style="font-size: 2rem; margin: 20px 0 10px;"></i>
	        	<br>
	        	주문 목록이 존재하지 않습니다.
	        </h5>
	    </div>
	</c:if>
			
	<!-- 페이징 네비게이션 추가 -->
	<c:if test="${not empty orderList}">
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
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>
    
    <script>
    $(document).ready(function() {
        // 수정하기 버튼 클릭 시
        $(".updateStatusBtn").on("click", function() {
            let orderNumber = $(this).closest('tr').find('.orderStatusSelect').data("order-number");
            let newStatus = $(this).closest('tr').find('.orderStatusSelect').val();
            let impUid = $(this).closest('tr').find('.orderStatusSelect').data("imp-uid");
            
            $.ajax({
                type: "PUT",
                url: "/admin/change/status",
                data: {
                    "orderNumber": orderNumber,
                    "status": newStatus
                },
                success: function(data) {
                    if (data.result == "success") {
                        alert("배송상태 수정 완료");
                        
                     	// 주문 상태가 "주문 취소 완료"일 경우 결제 취소 요청
                        if (newStatus === "주문 취소 완료") {
                            $.ajax({
                                type: "POST",
                                url: "/order/cancel",
                                contentType: "application/json",
                                data: JSON.stringify({
                                    "imp_uid": impUid // imp_uid를 포함하여 요청
                                }),
                                success: function(cancelData) {
                                    if (cancelData.result === "success") {
                                        alert("결제가 성공적으로 취소되었습니다.");
                                        location.reload(); // 페이지 새로 고침
                                    } else {
                                        alert("결제 취소 실패: " + cancelData.message);
                                    }
                                },
                                error: function() {
                                    alert("결제 취소 요청 중 오류가 발생했습니다.");
                                }
                            });
                        } else {
                            location.reload(); // 다른 상태일 경우 페이지 새로 고침
                        }
                    } else {
                        alert("배송상태 수정 실패");
                    }
                },
                error: function() {
                    alert("수정 에러");
                }
            });
        });
    });
    </script>
</body>
</html>
