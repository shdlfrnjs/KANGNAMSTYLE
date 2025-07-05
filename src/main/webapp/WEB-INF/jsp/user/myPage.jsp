<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/static/css/style.css" type="text/css">
<style>
    body {
        padding: 20px;
        font-family: Arial, sans-serif;
        background-color: #ffffff;
        color: #000000;
    }
    h3 {
    	color: #fff;
    }
    .container {
        display: flex;
        width: 100%; /* 전체 화면 너비로 확장 */
        max-width: 2200px; /* 최대 너비를 설정하여 너무 넓지 않게 */
        margin: 0 auto; /* 화면 가운데로 정렬 */
        margin-top: 20px;
    }
    .form-container {
	    background-color: #f8f9fa; /* 부드러운 배경색 */
	    padding: 20px;
	    border-radius: 10px; /* 둥근 모서리 */
	    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* 부드러운 그림자 효과 */
	    margin: 0 auto; /* 좌우 중앙 정렬 */
	    max-width: 500px; /* 최대 너비 설정 */
	}
    .sidebar {
        width: 15%; /* 사이드바 너비를 25%로 확장 */
        min-width: 250px; /* 최소 너비를 설정하여 너무 좁아지지 않도록 */
        height: 100vh;
        padding: 20px;
        background-color: #000;
        border-right: 1px solid #ddd;
    }
    .content {
        width: 85%; /* 메인 콘텐츠 영역을 더 넓게 */
        padding: 20px;
    }
    .sidebar a {
        display: block;
        padding: 10px 0;
        font-weight: bold;
        color: #fff;
        text-decoration: none;
        transition: background-color 0.3s ease;
    }
    .sidebar a:hover {
        background-color: #fff;
        color: #000;
        border-radius: 5px;
    }
    th {
        background-color: #333333; /* 짙은 회색 */
        color: #ffffff; /* 흰색 텍스트 */
        font-weight: bold;
    }
    .cancelOrderBtn {
        background-color: #dc3545;
        color: #fff;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 버튼 그림자 추가 */
    }
    .cancelOrderBtn:hover {
        background-color: #fff;
        color: #dc3545;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3); /* 호버 시 그림자 깊이 증가 */
    }
    .updateUserInfoBtn, .changePasswordBtn {
    	display: block;
    	margin: 0 auto; /* 좌우 가운데 정렬 */
    	margin-top: 30px;
        background-color: #000;
        color: #fff;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 버튼 그림자 추가 */
    }
    .updateUserInfoBtn:hover, .changePasswordBtn:hover {
        background-color: #fff;
        color: #000;
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
   		<img src="/static/img/logo.png" width="320px">
    </a>
</div>
<div class="container">
    <!-- 사이드바 -->
    <div class="sidebar">
        <h3>My Page <i class="fa-regular fa-circle-user"></i> </h3>
        <a href="#orderHistory"><i class="fa-solid fa-minus"></i>주문 내역</a>
        <a href="#profileUpdate"><i class="fa-solid fa-minus"></i>회원 정보 수정</a>
        <a href="#passwordChange"><i class="fa-solid fa-minus"></i>비밀번호 변경</a>
        <a href="#wishlist"><i class="fa-solid fa-minus"></i>찜한 상품</a>
    </div>

    <!-- 메인 콘텐츠 -->
    <div class="content">
        <!-- 주문 내역 섹션 -->
        <div id="orderHistory">
            <h1 class="text-center">${user.name }님의 주문 내역 <i class="fa-solid fa-receipt"></i></h1>
            <table class="table text-center mt-3">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>주문일</th>
                        <th>주문번호</th>
                        <th>주문내역</th>
                        <th>배송상태</th>
                        <th>주문 취소</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="order" items="${orderList}">
                        <tr>
                            <td style="vertical-align: middle;">${order.orderIndex}</td>
                            <td style="vertical-align: middle;"><fmt:formatDate value="${order.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                            <td style="vertical-align: middle;">${order.orderNumber}</td>
                            <td style="vertical-align: middle;">${order.orderDetailsString}</td>
                            <td style="vertical-align: middle;">${order.clothStatus}</td>
                            <td style="vertical-align: middle;">
                                <c:choose>
                                    <c:when test="${order.clothStatus == '주문 완료'}">
                                        <button class="cancelOrderBtn" data-order-number="${order.orderNumber}">주문 취소</button>
                                    </c:when>
                                    <c:when test="${order.clothStatus == '주문 취소'}">
                                        <button class="cancelOrderBtn" disabled>취소 진행중</button>
                                    </c:when>
                                    <c:when test="${order.clothStatus == '주문 취소 완료'}">
                                        <button class="cancelOrderBtn" disabled>취소 완료</button>
                                    </c:when>
                                    <c:when test="${order.clothStatus == '배송중' || order.clothStatus == '배송완료'}">
                                        <button class="cancelOrderBtn" disabled>취소 불가</button>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="cancelOrderBtn" disabled>주문 상태 불가</button>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <!-- 내역이 없을 경우 -->
			<c:if test="${empty orderList}">
			    <div class="text-center">
			        <h5>
			        	<i class="fa-solid fa-triangle-exclamation" style="font-size: 2rem; margin: 20px 0 10px;"></i>
			        	<br>
			        	주문 내역이 존재하지 않습니다.
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

        <!-- 회원 정보 수정 섹션 -->
		<div id="profileUpdate" class="form-container" style="display: none; max-width: 500px; margin: auto;">
		    <!-- 회원 정보 수정 폼 -->
		    <form id="updateForm" action="/user/update/userInfo" method="post">
		        <h1 class="text-center mb-4">회원 정보 수정 <i class="fa-solid fa-user-pen"></i></h1>
		        <hr>
		        <div class="form-group">
		            <label for="loginId">아이디</label>
		            <input type="text" class="form-control" id="loginId" name="loginId" value="${user.loginId}" readonly required>
		        </div>
		        <div class="form-group">
		            <label for="password">비밀번호</label>
		            <input type="password" class="form-control" id="password" name="password" autocomplete="off" required>
		        </div>
		        <div class="form-group">
		            <label for="name">이름</label>
		            <input type="text" class="form-control" id="name" name="name" value="${user.name}" autocomplete="off" required>
		        </div>
		        <div class="form-group">
		            <label for="email">이메일</label>
		            <input type="email" class="form-control" id="email" name="email" value="${user.email}" autocomplete="off" required>
		        </div>
		        <div class="form-group">
		            <label for="address">주소</label>
		            <input type="text" class="form-control" id="address" name="address" value="${user.address}" autocomplete="off" required>
		        </div>
		        <div class="form-group">
		            <label for="phoneNumber">연락처</label>
		            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}" autocomplete="off" required>
		        </div>
		        <div class="form-group">
		            <button type="button" class="updateUserInfoBtn">수정하기</button>
		        </div>
		    </form>
		</div>

		<!-- 비밀번호 변경 섹션 -->
		<div id="passwordChange" class="form-container" style="display: none; max-width: 500px;">
		    <form id="changeForm" action="/user/change/password" method="post">
		    	<input type="hidden" name="loginId" value="${user.loginId}">
		        <h1 class="text-center mb-4">비밀번호 변경 <i class="fa-solid fa-unlock"></i></h1>
		        <hr>
		        <div class="form-group">
		            <label for="currentPassword">현재 비밀번호</label>
		            <input type="password" class="form-control" id="currentPassword" name="currentPassword" placeholder="현재 비밀번호 입력" autocomplete="off" required>
		        </div>
		        <div class="form-group">
		            <label for="newPassword">새 비밀번호</label>
		            <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="새 비밀번호 입력" autocomplete="off" required>
		        </div>
		        <div class="form-group">
		            <label for="confirmNewPassword">새 비밀번호 확인</label>
		            <input type="password" class="form-control" id="confirmNewPassword" name="confirmNewPassword" placeholder="새 비밀번호 확인" autocomplete="off" required>
		        </div>
		        <div class="form-group">
		        	<button type="button" class="changePasswordBtn">비밀번호 변경</button>
		        </div>
		    </form>
		</div>
		
        <!-- 찜한 상품 섹션 -->
        <div id="wishlist" style="display: none; width: 1400px; margin: 0 auto;">
            <h1 class="text-center">${user.name }님의 찜 목록 <i class="fa-solid fa-heart"></i></h1>
            <hr>
	        <div class="d-flex flex-wrap justify-content-start mt-3" style="gap: 25px;">
			    <c:forEach var="cloth" items="${likedList}">
			        <a href="/main/clothes-detail?id=${cloth.clothId}" class="text-dark">
			            <div>
			                <img src="${cloth.clothImagePath}" class="img-fluid" style="width: 260px; height: 325px;">
			                <div style="font-size: 18px; font-weight: bold;" class="my-1">${cloth.clothName}</div>
			                <del style="font-size: 15px;"> <i class="fa-solid fa-won-sign"></i> ${cloth.clothRegularPrice}</del>
			                <div style="font-size: 15px;"> <i class="fa-solid fa-won-sign"></i> ${cloth.clothPrice}</div>
			            </div>
			        </a>
			    </c:forEach>
			</div>
			
			<!-- 찜한 상품이 없을 경우 -->
			<c:if test="${empty likedList}">
			    <div class="text-center">
			        <h5>
			        	<i class="fa-solid fa-triangle-exclamation" style="font-size: 2rem; margin: 20px 0 10px;"></i>
			        	<br>
			        	찜 목록이 비어있습니다.
			        </h5>
			    </div>
			</c:if>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>

<script>
$(document).ready(function() {
    // 사이드바 링크 클릭 시 해당 섹션으로 스크롤 이동
    $('.sidebar a').on('click', function(e) {
        e.preventDefault();
        $('.content > div').hide(); // 모든 섹션 숨기기
        var target = $(this).attr('href');
        $(target).show(); // 선택된 섹션 보이기
    });
});
</script>

<script>
$(document).ready(function() {
    // 주문 취소 버튼 클릭 시
    $(".cancelOrderBtn").on("click", function() {
        let orderNumber = $(this).data("order-number");

        if (confirm("정말로 주문을 취소하시겠습니까?")) {
            $.ajax({
                type: "PUT",
                url: "/user/cancel/order",
                data: {
                    "orderNumber": orderNumber
                },
                success: function(data) {
                    if (data.result == "success") {
                        alert("주문 취소 완료");
                        location.reload();
                    } else {
                        alert("주문 취소 실패");
                    }
                },
                error: function() {
                    alert("주문 취소 에러");
                }
            });
        }
    });
    
    // 회원 정보 수정 버튼 클릭 시
    $(".updateUserInfoBtn").on("click", function() {
        const loginId = $("#loginId").val();
        const password = $("#password").val();
        const name = $("#name").val();
        const email = $("#email").val();
        const address = $("#address").val();
        const phoneNumber = $("#phoneNumber").val();

        // 유효성 검사
        if (!loginId || !password || !name || !email || !address || !phoneNumber) {
            alert("모든 필드를 입력해야 합니다.");
            return; // 유효성 검사 실패 시 함수 종료
        }

        // 이메일 형식 검사
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailPattern.test(email)) {
            alert("유효한 이메일 주소를 입력하세요.");
            return;
        }

        // 연락처 형식 검사 (예: 숫자만 허용)
        const phonePattern = /^[0-9]*$/;
        if (!phonePattern.test(phoneNumber)) {
            alert("연락처는 숫자만 입력할 수 있습니다.");
            return;
        }

        // AJAX PUT 요청
        $.ajax({
            url: '/user/update/userInfo', // 요청 URL
            type: 'PUT', // HTTP 메서드
            data: {
                "loginId": loginId,
                "password": password,
                "name": name,
                "email": email,
                "address": address,
                "phoneNumber": phoneNumber
            },
            success: function(response) {
                if (response.result === "success") {
                    alert("회원 정보가 성공적으로 수정되었습니다.");
                    location.reload();
                } else {
                    alert(response.error_message || "회원 정보 수정에 실패했습니다.");
                }
            },
            error: function(xhr) {
                alert("서버 오류: " + xhr.status);
            }
        });
    });
    
 	// 비밀번호 변경 버튼 클릭 시
    $(".changePasswordBtn").on("click", function() {
    	const loginId = $("#loginId").val();
        const currentPassword = $("#currentPassword").val();
        const newPassword = $("#newPassword").val();
        const confirmNewPassword = $("#confirmNewPassword").val();

        // 유효성 검사
        if (!currentPassword || !newPassword || !confirmNewPassword) {
            alert("모든 필드를 입력해야 합니다.");
            return; // 유효성 검사 실패 시 함수 종료
        }

        // 새 비밀번호와 새 비밀번호 확인 일치 여부 검사
        if (newPassword !== confirmNewPassword) {
            alert("새로운 비밀번호가 일치하지 않습니다.");
            return;
        }

        // AJAX 요청
        $.ajax({
            url: '/user/change/password', // 비밀번호 변경 URL
            type: 'PUT', // HTTP 메서드
            data: {
            	"loginId": loginId,
                "currentPassword": currentPassword,
                "newPassword": newPassword
            },
            success: function(response) {
                if (response.result === "success") {
                    alert("비밀번호가 성공적으로 변경되었습니다.");
                    location.reload(); // 페이지 새로고침
                } else {
                	alert(response.error_message || "비밀번호 변경에 실패했습니다.");
                }
            },
            error: function(xhr) {
                alert("서버 오류: " + xhr.status);
            }
        });
    });
});
</script>
</body>
</html>
