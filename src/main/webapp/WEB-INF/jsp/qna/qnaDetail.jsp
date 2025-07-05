<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Q&A 상세보기</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/style.css" type="text/css">
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
            width: 300px;
        }
        .container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin: 0 auto;
            max-width: 900px;
        }
        .content-section {
            margin-bottom: 30px;
        }
        h1 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 20px;
        }
        h3 {
            color: #555;
            font-size: 1.5rem;
            margin-top: 20px;
            border-bottom: 2px solid #f1f1f1;
            padding-bottom: 10px;
        }
        .details {
            color: #777;
            font-size: 1rem;
            margin-top: 10px;
        }
        .qna-content {
            background-color: #f8f8f8;
            padding: 20px;
            border-radius: 6px;
            margin-top: 20px;
        }
        .answer-section {
            background-color: #f2f9f5;
            padding: 20px;
            border-radius: 6px;
            margin-top: 20px;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }
    </style>
</head>
<body>

    <div class="header">
        <a href="/main-view">
            <img src="/static/img/logo.png" alt="Logo">
        </a>
    </div>

    <div class="container">
        <h1>${qna.title}</h1>
        <div class="details">
            <p><strong>작성자:</strong> ${qna.writer}</p>
            <p><strong>작성일:</strong> <fmt:formatDate value="${qna.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" /></p>
            <p><strong>수정일:</strong> <fmt:formatDate value="${qna.updatedAt}" pattern="yyyy-MM-dd HH:mm:ss" /></p>
        </div>
        <hr>
        
        <div class="content-section qna-content">
            <h3>내용</h3>
            <p>${qna.content}</p>
        </div>

        <div class="content-section answer-section">
            <h3>답변</h3>
            <p>
                <c:choose>
                    <c:when test="${not empty qna.answer}">
                        ${qna.answer}
                    </c:when>
                    <c:otherwise>
                        <em>아직 답변이 없습니다.</em>
                    </c:otherwise>
                </c:choose>
            </p>
        </div>

		<!-- 수정 및 삭제 버튼, userId가 일치할 경우에만 표시 -->
		<div class="text-center">
			<c:if test="${qna.userId == userId}">
	        	<a href="/qna/updateform/${qna.id}" class="btn btn-dark">수정하기</a>
	        	<form action="/qna/delete/${qna.id}" method="post" style="display:inline;">
				    <button type="submit" class="btn btn-danger">삭제하기</button>
				</form>
	        </c:if>
	        <c:if test="${not empty managerId}">
			    <a href="/qna/answerform/${qna.id}" class="btn btn-dark">답변하기</a>
			</c:if>
	        <a href="/qna" class="btn btn-primary">돌아가기</a>
		</div>
    </div>

</body>
</html>
