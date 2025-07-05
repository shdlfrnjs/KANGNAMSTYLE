<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
	.main-nav {
        position: relative;
        z-index: 10; /* 배너보다 높은 z-index */
    }
    .main-nav .nav-link {
        border-radius: 0;
        text-align: center;
        padding: 10px 20px;
        background-color: #f8f9fa; /* 탭 버튼 배경 색상 */
        font-weight: bold;
    }
    .dropdown-menu {
        position: static;
        float: none;
        background-color: #f8f9fa; /* 서브메뉴도 같은 색상으로 */
        padding: 0;
        border: none;
        width: 100%; /* 전체 너비로 확장 */
    }
    .dropdown-menu .dropdown-item {
        padding: 10px 20px;
        color: #343a40;
        text-align: center;
        background-color: #f8f9fa; /* 서브메뉴 배경 동일하게 */
        font-weight: bold;
    }

    .dropdown-item:hover {
        background-color: #e9ecef;
    }

    .nav-item:hover .dropdown-menu {
        display: block;
    }

    .dropdown-menu {
        display: none;
    }
</style>

<div class="main-nav" style="margin-top: 50px;">
    <ul class="nav nav-fill">
        <!-- Outer -->
        <li class="nav-item dropdown">
            <a href="/main/clothes/classify?clothCategory=1" class="nav-link btn btn-light text-dark font-weight-bold" id="outerDropdown">Outer</a>
            <div class="dropdown-menu" aria-labelledby="outerDropdown">
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=1&clothSubCategory=hoodie_jacket">후드 집업</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=1&clothSubCategory=blouson_ma1">블루종/MA-1</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=1&clothSubCategory=leather_riders">레더/라이더스 재킷</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=1&clothSubCategory=mustang_fur">무스탕/퍼</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=1&clothSubCategory=trucker">트러커 재킷</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=1&clothSubCategory=blazer_suit">슈트/블레이저 재킷</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=1&clothSubCategory=cardigan">카디건</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=1&clothSubCategory=anorak">아노락 재킷</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=1&clothSubCategory=fleece">플리스/뽀글이</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=1&clothSubCategory=training">트레이닝 재킷</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=1&clothSubCategory=stadium">스타디움 재킷</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=1&clothSubCategory=transition_coat">환절기 코트</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=1&clothSubCategory=winter_single_coat">겨울 싱글 코트</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=1&clothSubCategory=winter_double_coat">겨울 더블 코트</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=1&clothSubCategory=winter_other_coat">겨울 기타 코트</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=1&clothSubCategory=long_padding">롱패딩/헤비 아우터</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=1&clothSubCategory=short_padding">숏패딩/헤비 아우터</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=1&clothSubCategory=padding_vest">패딩 베스트</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=1&clothSubCategory=vest">베스트</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=1&clothSubCategory=safari_hunting">사파리/헌팅 재킷</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=1&clothSubCategory=nylon_coach">나일론/코치 재킷</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=1&clothSubCategory=other_outer">기타 아우터</a>
            </div>
        </li>

        <!-- Top -->
        <li class="nav-item dropdown">
            <a href="/main/clothes/classify?clothCategory=2" class="nav-link btn btn-light text-dark font-weight-bold" id="topDropdown">Top</a>
            <div class="dropdown-menu" aria-labelledby="topDropdown">
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=2&clothSubCategory=sweatshirt">맨투맨/스웨트</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=2&clothSubCategory=shirt">셔츠/블라우스</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=2&clothSubCategory=hoodie">후드 티셔츠</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=2&clothSubCategory=knit">니트/스웨터</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=2&clothSubCategory=polo">피케/카라 티셔츠</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=2&clothSubCategory=longsleeve">긴소매 티셔츠</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=2&clothSubCategory=shortsleeve">반소매 티셔츠</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=2&clothSubCategory=sleeveless">민소매 티셔츠</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=2&clothSubCategory=sports_top">스포츠 상의</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=2&clothSubCategory=other_top">기타 상의</a>
            </div>
        </li>

		<!-- Bottom -->
        <li class="nav-item dropdown">
            <a href="/main/clothes/classify?clothCategory=3" class="nav-link btn btn-light text-dark font-weight-bold" id="bottomDropdown">Bottom</a>
            <div class="dropdown-menu" aria-labelledby="bottomDropdown">
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=3&clothSubCategory=denim_pants">데님 팬츠</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=3&clothSubCategory=cotton_pants">코튼 팬츠</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=3&clothSubCategory=suit_slacks">슈트 팬츠/슬랙스</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=3&clothSubCategory=jogger_pants">트레이닝/조거 팬츠</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=3&clothSubCategory=shorts">숏 팬츠</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=3&clothSubCategory=leggings">레깅스</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=3&clothSubCategory=jumpsuit_overalls">점프 슈트/오버올</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=3&clothSubCategory=sports_bottom">스포츠 하의</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=3&clothSubCategory=other_bottom">기타 바지</a>
            </div>
        </li>
        
        <!-- Shoes -->
        <li class="nav-item dropdown">
            <a href="/main/clothes/classify?clothCategory=4" class="nav-link btn btn-light text-dark font-weight-bold" id="shoesDropdown">Shoes</a>
            <div class="dropdown-menu" aria-labelledby="shoesDropdown">
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=4&clothSubCategory=sneakers">스니커즈</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=4&clothSubCategory=shoes">구두</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=4&clothSubCategory=sandals_slippers">샌들/슬리퍼</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=4&clothSubCategory=boots_walkers">부츠/워커</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=4&clothSubCategory=sports_shoes">운동화</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=4&clothSubCategory=other_shoes">기타 신발</a>
            </div>
        </li>
        
        <!-- Accessories -->
        <li class="nav-item dropdown">
            <a href="/main/clothes/classify?clothCategory=5" class="nav-link btn btn-light text-dark font-weight-bold" id="accessoriesDropdown">ACC</a>
            <div class="dropdown-menu" aria-labelledby="accessoriesDropdown">
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=5&clothSubCategory=hat">모자</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=5&clothSubCategory=bag">가방</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=5&clothSubCategory=watch">시계</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=5&clothSubCategory=jewelry">주얼리</a>
                <a class="dropdown-item" href="/main/clothes/classify?clothCategory=5&clothSubCategory=other_accessory">기타 액세서리</a>
            </div>
        </li>
    </ul>
</div>

<script>
    document.querySelectorAll('.nav-item').forEach(function(item) {
        item.addEventListener('mouseenter', function() {
            let dropdownMenu = this.querySelector('.dropdown-menu');
            if (dropdownMenu) {
                dropdownMenu.classList.add('show');
            }
        });
        item.addEventListener('mouseleave', function() {
            let dropdownMenu = this.querySelector('.dropdown-menu');
            if (dropdownMenu) {
                dropdownMenu.classList.remove('show');
            }
        });
    });
</script>
