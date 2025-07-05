<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
/* 검색 인풋 및 버튼 스타일 */
.search-group {
    width: 250px; /* 전체 너비 조정 */
    transition: width 0.3s ease-in-out; /* 너비 변경 시 애니메이션 효과 */
    border-radius: 25px; /* 둥근 사각형 모서리 */
    overflow: hidden; /* 내부 요소가 밖으로 나가지 않도록 */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
}

.search-input {
    border: none; /* 테두리 제거 */
    padding: 10px 15px; /* 인풋 내부 여백 */
    border-radius: 0; /* 인풋 자체의 둥근 모서리는 제거 */
    outline: none; /* 포커스 시 외곽선 제거 */
    flex-grow: 1; /* 인풋이 가능한 공간을 채우도록 */
    box-shadow: none; /* 클릭 시 파란 테두리 제거 */
    font-size: 18px; /* 글자 크기 조정 */
    font-weight: 500; /* 글씨 두께 조정 */
    width: 100%; /* 검색창이 부모 요소의 너비를 채우도록 */
}

/* 검색 인풋 포커스 시 파란 테두리 제거 */
.search-input:focus {
    outline: none; /* 기본 포커스 아웃라인 제거 */
    box-shadow: none; /* 포커스 시 박스 그림자 제거 */
    border-color: transparent; /* 테두리 색상 제거 */
}

.search-btn {
    border: none; /* 버튼 테두리 제거 */
    background-color: transparent; /* 버튼 배경색 없음 */
    color: black; /* 아이콘 색상 */
    padding: 10px; /* 버튼 여백 */
    display: flex; /* 아이콘 중앙 정렬을 위한 플렉스박스 */
    align-items: center; /* 수직 중앙 정렬 */
    justify-content: center; /* 수평 중앙 정렬 */
    cursor: pointer; /* 포인터 모양 변경 */
    transition: none; /* 호버 전환 효과 제거 */
}

.search-btn .fas {
    font-size: 1.2rem; /* 아이콘 크기 */
}

/* 버튼 호버 시 효과 제거 */
.search-btn:hover {
}

.nav-divider {
    display: flex;
    align-items: center; /* 세로선 가운데 정렬 */
    color: #ccc; /* 세로선 색상 */
    font-size: 1.2rem; /* 세로선 크기 조정 */
}

/* jQuery UI 기본 스타일 초기화 */
.ui-autocomplete {
    border: 1px solid #ccc;
    border-radius: 5px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    font-size: 16px;
    background-color: #fff;
    z-index: 1000;
}

.ui-menu-item {
    padding: 8px 12px;
    cursor: pointer;
    background-color: transparent; /* 기본 배경색을 투명으로 설정 */
    color: inherit; /* 기본 글자 색상을 상속받음 */
}

/* 추가적으로 기본 링크 스타일을 제거 */
.ui-menu-item a {
    color: inherit !important; /* 링크 색상 상속 */
    text-decoration: none; /* 링크의 기본 밑줄 제거 */
}
</style>

<div class="container-fluid">
    <!-- 내비게이션 메뉴 -->
    <div class="top-menu" style="position: absolute; top: 0; right: 0; z-index: 1000;">
        <ul class="nav" style="display: flex; list-style-type: none; margin: 0; padding: 0;">
            <c:if test="${empty userId && empty managerId}">
                <li class="nav-item"><a href="/user/sign-in-view" class="nav-link text-dark">로그인</a></li>
                <span class="nav-divider">|</span>
                <li class="nav-item"><a href="/user/sign-up-view" class="nav-link text-dark">회원가입</a></li>
                <span class="nav-divider">|</span>
                <li class="nav-item"><a href="/user/myPage-view" class="nav-link text-dark">마이페이지</a></li>
                <span class="nav-divider">|</span>
                <li class="nav-item"><a href="/basket/list-view" class="nav-link text-dark">장바구니</a></li>
                <span class="nav-divider">|</span>
                <li class="nav-item"><a href="/qna" class="nav-link text-dark">고객센터</a></li>
            </c:if>

            <c:if test="${not empty userId}">
                <li class="nav-item"><span class="nav-link text-dark">${userName} 님</span></li>
                <span class="nav-divider">|</span>                
                <li class="nav-item"><a href="/user/sign-out" class="nav-link text-dark">로그아웃</a></li>
                <span class="nav-divider">|</span>
                <li class="nav-item"><a href="/user/myPage-view" class="nav-link text-dark">마이페이지</a></li>
                <span class="nav-divider">|</span>
                <li class="nav-item"><a href="/basket/list-view" class="nav-link text-dark">장바구니</a></li>
                <span class="nav-divider">|</span>
                <li class="nav-item"><a href="/qna" class="nav-link text-dark">고객센터</a></li>
            </c:if>

            <c:if test="${not empty managerId}">
                <li class="nav-item"><span class="nav-link text-dark">${managerName} 님</span></li>
                <span class="nav-divider">|</span>
                <li class="nav-item"><a href="/admin/logout" class="nav-link text-dark">로그아웃</a></li>
                <span class="nav-divider">|</span>
                <li class="nav-item"><a href="/admin/show/productList" class="nav-link text-dark">상품관리</a></li>
                <span class="nav-divider">|</span>
                <li class="nav-item"><a href="/admin/show/orderList" class="nav-link text-dark">주문관리</a></li>
                <span class="nav-divider">|</span>
                <li class="nav-item"><a href="/qna" class="nav-link text-dark">고객센터</a></li>
            </c:if>
        </ul>
    </div>

    <!-- 로고 영역 -->
    <div class="container-fluid">
        <div class="row align-items-end" style="max-width: 1400px; margin: 0 auto;">
            <!-- 검색 -->
			<div class="col-4 d-flex justify-content-start">
			    <form class="input-group mb-2 search-group" action="/main/clothes/search" method="GET">
			        <input type="text" name="keyword" class="form-control search-input" placeholder="검색어 입력" aria-label="검색어 입력" autocomplete="off">
			        <button class="btn search-btn" type="submit">
			            <i class="fas fa-search"></i>
			        </button>
			    </form>
			</div>

            <!-- 로고 -->
            <div class="col-4 d-flex justify-content-center" style="margin-top: 30px; margin-bottom: 30px;">
                <div>
                    <div class="display-4 text-center">
                        <a href="/main-view">
                        	<img src="/static/img/mainlogo.png" width="500px">
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-4"></div>
        </div>
    </div>
</div>

<script>
var $jQ = jQuery.noConflict();
$jQ(document).ready(function() {
    var $searchGroup = $jQ(".search-group");

    // 포커스 시 검색창 확장
    $jQ(".search-input").on("focus", function() {
        $searchGroup.css("width", "350px"); // 확장된 너비 설정
    });

    // 포커스 해제 시 원래 크기로 복귀
    $jQ(".search-input").on("blur", function() {
        setTimeout(function() { // 자동 완성 선택 후에도 복귀되도록 시간차 적용
            if (!$jQ(".ui-autocomplete").is(":visible")) {
                $searchGroup.css("width", "250px"); // 기본 너비 설정
            }
        }, 100);
    });

    // jQuery UI 자동 완성 설정
    $jQ(".search-input").autocomplete({
        source: function(request, response) {
            $jQ.ajax({
                url: "/getSearchSuggestions",
                type: "GET",
                data: {
                    term: request.term
                },
                success: function(data) {
                    response(data);
                },
                error: function() {
                    console.error("자동완성 데이터 로드 실패");
                }
            });
        },
        minLength: 1,
        autoFocus: true,
        focus: function(event, ui) {
            // 방향키로 항목을 선택할 때, 텍스트 필드의 내용이 변경되지 않도록 함
            return false;  // 기본 동작을 막음
        }
    });
});
</script>