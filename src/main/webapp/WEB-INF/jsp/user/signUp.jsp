<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>
body {
    background-color: #f8f9fa; /* 부드러운 배경 색상 */
}

.card {
    border-radius: 15px; /* 카드 모서리 둥글게 */
    background-color: #ffffff; /* 카드 배경색 */
    border: 1px solid #dee2e6; /* 카드 경계 */
}

.form-group label {
    font-weight: bold; /* 레이블 텍스트 굵게 */
}

.btnSignUp {
    background-color: #fff; /* 기본 버튼 색상 */
    color: #000; /* 버튼 텍스트 색상 */
    border: 1px solid #000;
    border-radius: 5px; /* 버튼 모서리 둥글게 */
    padding: 10px 20px; /* 버튼 내부 여백 */
    transition: background-color 0.3s; /* 버튼 호버 효과 */
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.btnSignUp:hover {
    background-color: #000; /* 버튼 호버 색상 */
    color: #fff; /* 버튼 텍스트 색상 */
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
}
</style>

<div class="container mt-5">
    <form id="signUpForm" method="post" action="/user/sign-up">
        <div class="card p-4 shadow">
            <h2 class="text-center"><i class="fa-solid fa-user-plus"></i> 회원가입</h2>
            <hr>
            <div class="form-group">
                <label for="loginId">* 아이디 (4자 이상)</label>
                <div class="d-flex">
                    <input type="text" id="loginId" name="loginId"
                        class="form-control me-2" placeholder="아이디를 입력하세요." autocomplete="off" required>
                    <button type="button" id="loginIdCheckBtn" class="btn btn-outline-success flex-shrink-0">중복확인</button>
                </div>
                <small id="idCheckLength" class="text-danger d-none">ID를 4자 이상 입력해주세요.</small>
                <small id="idCheckDuplicated" class="text-danger d-none">이미 사용중인 ID입니다.</small>
                <small id="idCheckOk" class="text-success d-none">사용 가능한 ID입니다.</small>
            </div>
            <div class="form-group">
                <label for="password">* 비밀번호</label>
                <input type="password" id="password" name="password"
                    class="form-control" placeholder="비밀번호를 입력하세요." autocomplete="off" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">* 비밀번호 확인</label>
                <input type="password" id="confirmPassword" name="confirmPassword"
                    class="form-control" placeholder="비밀번호를 입력하세요." autocomplete="off" required>
            </div>
            <div class="form-group">
                <label for="name">* 이름</label>
                <input type="text" id="name" name="name"
                    class="form-control" placeholder="이름을 입력하세요." autocomplete="off" required>
            </div>
            <div class="form-group">
                <label for="email">* 이메일</label>
                <input type="email" id="email" name="email"
                    class="form-control" placeholder="이메일 주소를 입력하세요." autocomplete="off" required>
            </div>
            <div class="form-group">
                <label for="address">* 주소</label>
                <input type="text" id="address" name="address"
                    class="form-control" placeholder="주소를 입력하세요." autocomplete="off" required>
            </div>
            <div class="form-group">
                <label for="phoneNumber">* 연락처</label>
                <input type="tel" id="phoneNumber" name="phoneNumber"
                    class="form-control" placeholder="번호를 입력하세요. ex) 01012341234" autocomplete="off" required>
            </div>
            <div class="text-center mt-3">
                <button type="submit" id="signUpBtn" class="btnSignUp">가입하기</button>
            </div>
        </div>
    </form>
</div>

<script>
	$(document).ready(function() {
		
		// 아이디 중복확인
		$("#loginIdCheckBtn").on('click', function() {
			// alert("중복");
			
			// 경고 문구 초기화
			$("#idCheckLength").addClass("d-none");
			$("#idCheckDuplicated").addClass("d-none");
			$("#idCheckOk").addClass("d-none");
			
			let loginId = $("input[name=loginId]").val().trim();
			if (loginId.length < 4) {
				$("#idCheckLength").removeClass("d-none");
				return;
			}
			
			// AJAX - 중복확인
			$.get("/user/is-duplicated-id", {"loginId":loginId})    // request
			.done(function(data) {  // response
				// {"code":200, "is_duplicated_id":true}  true:중복
				if (data.code == 200) {
					if (data.is_duplicated_id) { // 중복
						$("#idCheckDuplicated").removeClass("d-none");
					} else { // 사용 가능
						$("#idCheckOk").removeClass("d-none");
					}
				} else {
					alert(data.error_message);
				}
			});
		});
		
		// 회원가입
		$("#signUpForm").on('submit', function(e) {
			e.preventDefault(); // submit 기능 멈춤
			
			//alert("회원가입");
			
			// validation
			let loginId = $("input[name=loginId]").val().trim();
			let password = $("#password").val();
			let confirmPassword = $("#confirmPassword").val();
			let name = $("#name").val().trim();
			let email = $("#email").val().trim();
			let address = $("#address").val().trim();
			let phoneNumber = $("#phoneNumber").val().trim();
			
			if (!loginId) {
				alert("아이디를 입력하세요");
				return false;
			}
			
			if (!password || !confirmPassword) {
				alert("비밀번호를 입력하세요");
				return false;
			}
			
			if (password != confirmPassword) {
				alert("비밀번호가 일치하지 않습니다.");
				return false;
			}
			
			if (!name) {
				alert("이름을 입력하세요.");
				return false;
			}
			
			if (!email) {
				alert("이메일을 입력하세요.");
				return false;
			}
			
			if (!address) {
				alert("주소를 입력하세요.");
				return false;
			}
			
			if (!phoneNumber) {
				alert("핸드폰 번호를 입력하세요.");
				return false;
			}
			
			// 중복확인 후 사용 가능한 아이디인지 
			// 잘못: idCheckOk에 d-none이 있을 때
			if ($("#idCheckOk").hasClass("d-none")) {
				alert("아이디 중복확인을 해주세요.");
				return false;
			}
			
			//alert("완료");
			
			// 1) 서버 전송: submit 
			//$(this)[0].submit(); // 화면 이동이 된다.
			
			// 2) AJAX 통신: 화면 이동되지 않음, 콜백에서 이동 => 응답값 JSON
			let url = $(this).attr("action");
			console.log(url);
			let params = $(this).serialize(); // 폼태그에 있는 name 속성값으로 파라미터 구성
			console.log(params);
			
			$.post(url, params)   // request
			.done(function(data) { // response callback
				if (data.code == 200) {
					alert("가입을 환영합니다. 로그인 해주세요.");
					location.href = "/user/sign-in-view"; // 로그인 화면 이동
				} else {
					// 로직 실패
					alert(data.error_message);
				}
			});
		});
	});
</script>