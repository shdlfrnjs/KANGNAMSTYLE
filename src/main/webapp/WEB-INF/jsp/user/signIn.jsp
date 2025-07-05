<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>
    body {
        background-color: #f8f9fa;
        font-family: Arial, sans-serif;
    }
    .login-box {
        max-width: 400px;
        margin: 80px auto;
        padding: 20px;
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
        text-align: center;
    }
    .login-box h1 {
        margin-bottom: 20px;
        font-size: 28px;
        color: #333;
    }
    .btn-custom {
        width: 48%;
        padding: 10px;
        font-size: 16px;
        border-radius: 5px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    .btn-white {
        background-color: #000;
        border: 1px solid #000;
        color: #fff;
    }
    .btn-dark {
        background-color: #fff;
        border: 1px solid #000;
        color: #000;
    }
    .btn-white:hover, .btn-dark:hover {
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
    }
    .btn-white:hover {
        background-color: #fff;
        color: #000;
    }
    .btn-dark:hover {
        background-color: #000;
        color: #fff;
    }
    .input-group-text {
        background-color: #000;
        color: #fff;
    }
    .input-group-prepend span {
        width: 50px;
        text-align: center;
    }
    .btn-group-custom {
        display: flex;
        justify-content: space-between;
        margin-bottom: 20px;
    }
    a {
        text-decoration: none;
    }
    a:hover {
        text-decoration: underline;
    }
    /* 인풋창 클릭 시 테두리 색상 제거 */
    .form-control:focus {
        border-color: #000; /* 원하는 색상으로 변경 가능 */
        box-shadow: none; /* 그림자 제거 */
    }
</style>

<div class="login-box">
    <h1><i class="fa-solid fa-user"></i> 로그인</h1>
    <hr>
    <form id="loginForm" action="/user/sign-in" method="post">
        <div class="input-group mb-3">
            <div class="input-group-prepend">
                <span class="input-group-text">ID</span>
            </div>
            <input type="text" class="form-control" id="loginId" name="loginId" autocomplete="off">
        </div>

        <div class="input-group mb-3">
            <div class="input-group-prepend">
                <span class="input-group-text">PW</span>
            </div>
            <input type="password" class="form-control" id="password" name="password" autocomplete="off">
        </div>
        
        <div class="btn-group-custom">
            <input type="submit" id="loginBtn" class="btn btn-custom btn-white" value="로그인">
            <a class="btn btn-custom btn-dark" href="/user/sign-up-view">회원가입</a>
        </div>
        <div>
            <a href="/admin/login">관리자 로그인</a>
        </div>
    </form>
</div>

<script>
    $(document).ready(function() {
        // 로그인
        $("form").on('submit', function(e) {
            e.preventDefault(); // 폼 중단. 화면 이동 X
            
            let loginId = $("input[name=loginId]").val().trim();
            let password = $("#password").val();
            
            if (!loginId) {
                alert("아이디를 입력하세요");
                return false;
            }
            
            if (!password) {
                alert("비밀번호를 입력하세요");
                return false;
            }
            
            let url = $(this).attr('action');
            console.log(url);
            let params = $(this).serialize(); // name 속성 정의가 반드시 필요
            console.log(params);
            
            $.post(url, params) // request
            .done(function(data) { // response callback
                if (data.result == "성공") {
                    // 로그인 성공 시 글 목록 화면으로 이동
                    location.href = "/main-view";
                } else {
                    alert(data.error_message);
                }
            });
        });
    });
</script>
