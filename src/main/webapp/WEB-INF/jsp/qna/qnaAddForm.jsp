<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Q&A 작성하기</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script>
        // 체크박스 클릭 시 작성자명을 회원명으로 설정하는 스크립트
        function toggleWriterName(checkbox) {
            const writerInput = document.getElementById('writer');
            if (checkbox.checked) {
                writerInput.value = checkbox.dataset.username; // 로그인된 회원명으로 설정
                writerInput.readOnly = true; // 수정 불가
            } else {
                writerInput.value = ''; // 빈 값으로 초기화
                writerInput.readOnly = false; // 수정 가능
            }
        }
    </script>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f9;
            padding-top: 50px;
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header img {
            width: 300px; /* 로고 크기 조정 */
        }

        .container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin: 0 auto;
            max-width: 900px;
        }

        h1 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 20px;
        }

        .form-group label {
            font-weight: bold;
            color: #555;
        }

        .form-control {
            border-radius: 6px;
            box-shadow: none;
            border: 1px solid #ccc;
        }

        .form-control:focus {
            border-color: #007bff;
        }

        .form-check-input {
            margin-top: 3px;
        }

        .btn-dark {
            background-color: #343a40;
            border-color: #343a40;
        }

        .btn-dark:hover {
            background-color: #23272b;
            border-color: #1d2124;
        }

        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
        }

        .btn-danger:hover {
            background-color: #c82333;
            border-color: #bd2130;
        }

        .form-check-label {
            font-size: 1rem;
        }

        .back-button {
            text-decoration: none;
            margin-left: 10px;
        }
    </style>
</head>
<body>

    <!-- 로고 추가 -->
    <div class="header">
        <a href="/main-view">
            <img src="/static/img/logo.png" alt="Logo">
        </a>
    </div>

    <div class="container">
        <h1>Q&A 글쓰기</h1>

        <!-- Q&A 작성 폼 -->
        <form action="/qna/add" method="post">
            <!-- 숨겨진 필드로 userId 전달 -->
            <input type="hidden" name="userId" value="${userId}">

            <div class="form-group">
                <label for="writer">작성자명</label>
                <input type="text" class="form-control" id="writer" name="writer" autocomplete="off" required>
                <div class="form-check mt-2">
                    <input type="checkbox" class="form-check-input" id="useUsername" data-username="${userName}" onclick="toggleWriterName(this)">
                    <label class="form-check-label" for="useUsername">회원명과 동일</label>
                </div>
            </div>

            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" class="form-control" id="title" name="title" autocomplete="off" required>
            </div>
            
            <div class="form-group">
                <label for="content">내용</label>
                <textarea class="form-control" id="content" name="content" rows="5" autocomplete="off" required></textarea>
            </div>
            
            <!-- 히든 필드로 status 값을 '대기중'으로 설정 -->
            <input type="hidden" name="status" value="대기중">
            
            <!-- 버튼들을 가운데로 정렬 -->
		    <div class="d-flex justify-content-center mt-4">
		        <button type="submit" class="btn btn-dark">작성하기</button>
		        <a href="/qna" class="btn btn-danger back-button ml-3">돌아가기</a>
		    </div>
        </form>
    </div>

</body>
</html>
