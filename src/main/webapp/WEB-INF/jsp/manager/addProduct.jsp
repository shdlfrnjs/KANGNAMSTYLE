<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/static/css/style.css" type="text/css">
<head>
<meta charset="utf-8">
<title>Add Product</title>
<style>
/* Body 스타일 */
body {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh; /* 전체 화면 높이 */
	background-color: #f8f9fa; /* 밝은 배경 */
	margin: 0;
}

.header {
	position: absolute;
	top: 20px;
	left: 20px;
}

/* Form 컨테이너 스타일 */
.form-container {
	width: 1200px; /* 고정 너비 */
	height: 900px; /* 고정 높이 */
	background: white;
	padding: 30px; /* 패딩 증가 */
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	overflow: auto; /* 내용이 넘칠 경우 스크롤 추가 */
}

/* Form 제목 스타일 */
.form-title {
    font-family: 'Arial', sans-serif; /* 고급스러운 폰트로 변경 */
    font-size: 2.5rem; /* 큰 텍스트 크기 */
    color: #000; /* 하얀 글씨 */
    text-align: center; /* 중앙 정렬 */
    background-color: #fff; /* 검은 배경 */
    padding: 20px; /* 텍스트 상하좌우 여백 추가 */
    border-radius: 10px; /* 둥근 모서리 */
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1); /* 부드러운 그림자 */
    letter-spacing: 1px; /* 글자 간격을 넓혀 고급스럽게 */
    text-transform: uppercase; /* 텍스트를 대문자로 변경 */
    margin-top: 30px; /* 상단 간격 */
    margin-bottom: 50px; /* 하단 간격 */
}

/* 탭 스타일 */
.tabs {
	margin-bottom: 20px;
}

.tabs a {
	padding: 10px 20px;
	margin-right: 10px;
	border: 1px solid #fff; /* 테두리를 하얀색으로 설정 */
	border-radius: 4px;
	background-color: #000; /* 검은 배경 */
	color: #000; /* 검은 글씨 */
	text-decoration: none;
	transition: background-color 0.3s ease, color 0.3s ease;
}

/* 활성화된 탭 스타일 */
.tabs a.active {
	background-color: #fff; /* 활성화된 탭은 하얀색 배경 */
	color: #000; /* 검은 글씨 */
	border-color: #000; /* 검은 테두리 */
}

/* 탭 마우스 오버 스타일 */
.tabs a:hover {
	background-color: #444; /* 마우스 오버 시 다크 그레이 배경 */
	color: #fff; /* 하얀 글씨 유지 */
}

table.table {
	border-collapse: collapse; /* 테두리 합치기 */
	width: 100%;
}

table.table td {
	vertical-align: middle;
	padding: 10px 15px;
	border: none; /* 테이블 경계 제거 */
}

table.table input[type="text"], table.table select {
	width: 100%;
	padding: 8px;
	border-radius: 4px;
	border: 1px solid #ced4da;
}

/* 파일 선택 버튼 커스터마이징 */
input[type=file]::file-selector-button {
	width: 150px;
	height: 30px;
	background: #fff;
	border: 1px solid #000;
	border-radius: 10px;
	cursor: pointer;
	transition: background-color 0.3s ease, color 0.3s ease;
}

input[type=file]::file-selector-button:hover {
	background-color: #000;
	color: #fff;
}

.button-container {
	position: absolute;
	bottom: 100px; /* 버튼을 폼 하단에 위치 */
	left: 50%;
	transform: translateX(-50%); /* 버튼 중앙 정렬 */
}

/* 버튼 스타일 */
.button-container input[type="button"] {
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
.button-container input[type="button"]:hover {
	background-color: #fff; /* 하얀색 배경 */
	color: #000; /* 검은색 텍스트 */
	border: 1px solid #000; /* 검은색 테두리 */
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3); /* 호버 시 그림자 깊이 증가 */
}
</style>
</head>

<body>
    <div class="header">
	    <a href="/main-view">
	   		<img src="/static/img/logo.png" width="350px">
	    </a>
    </div>
    <div class="form-container">
        <form id="addProductForm" action="/admin/addProduct" method="post" enctype="multipart/form-data">
            <h1 class="form-title">상품 등록하기 <i class="fa-solid fa-square-plus"></i></h1>
            <div class="tab_container">
                <ul class="tabs nav nav-tabs">
                    <li class="nav-item"><a href="#tab1" class="nav-link active">상품 기본정보</a></li>
                    <li class="nav-item"><a href="#tab2" class="nav-link">상품 상세정보</a></li>
                    <li class="nav-item"><a href="#tab3" class="nav-link">상품 재고</a></li>
                    <li class="nav-item"><a href="#tab4" class="nav-link">상품 이미지</a></li>
                    <li class="nav-item"><a href="#tab5" class="nav-link">상품 메모</a></li>
                </ul>
                <div class="tab_content" id="tab1">
                    <table class="table">
                        <tr>
                            <td style="width: 200px;">카테고리 (상)</td>
                            <td>
                                <select name="clothCategory"  id="categorySelect" required>
                                    <option value="">(선택)</option>
                                    <option value="1">아우터</option>
                                    <option value="2">상의</option>
                                    <option value="3">하의</option>
                                    <option value="4">신발</option>
                                    <option value="5">악세서리</option>
                                </select>
                            </td>
                        </tr>
						<tr>
							<td>카테고리 (하)</td>
							<td>
								<select name="clothSubCategory" id="subCategorySelect" required>
									<option>-</option>
								</select>
							</td>
						</tr>
						<tr>
                            <td>상품명</td>
                            <td><input name="clothName" type="text" placeholder="상품명 입력" value="${cloth.name}" autocomplete="off" required /></td>
                        </tr>
                        <tr>
                            <td>상품 정가</td>
                            <td><input name="clothRegularPrice" type="text" placeholder="(원)" autocomplete="off" required /></td>
                        </tr>
                        <tr>
                            <td>상품 판매가격</td>
                            <td><input name="clothPrice" type="text" placeholder="(원)" autocomplete="off" required /></td>
                        </tr>
                    </table>
                </div>
                <div class="tab_content" id="tab2">
                    <table class="table">
                        <tr>
                            <td style="width: 200px;">코디 정보</td>
                            <td>
                                <select name="clothStyle" required>
                                    <option value="">(선택)</option>
                                    <option value="casual">캐주얼</option>
                                    <option value="street">스트릿</option>
                                    <option value="minimal">미니멀</option>
                                    <option value="classic">클래식</option>
                                    <option value="sportswear">스포츠웨어</option>
                                    <option value="other">기타</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>계절 정보</td>
                            <td>
                                <select name="clothSeason" required>
                                	<option value="">(선택)</option>
                                    <option value="summer">여름 (23도 이상)</option>
								    <option value="spring_fall">봄/가을 (22~16도)</option>
								    <option value="fall_winter">가을/겨울 (15~9도)</option>
								    <option value="winter">겨울 (8도 이하)</option>
								    <option value="all_season">사계절</option>
				   				    <option value="other">기타</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>날씨 정보</td>
                            <td>
                                <select name="clothWeather" required>
                                    <option value="">(선택)</option>
								    <option value="sunny">맑음, 청정</option>
								    <option value="rainy">흐림, 비</option>
								    <option value="all_weather">무관</option>
				   				    <option value="other">기타</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>색상 정보</td>
							<td>
								<select name="clothColor" required>
								    <option value="">(선택)</option>
								    <option value="red">빨강</option>
								    <option value="blue">파랑</option>
								    <option value="green">초록</option>
								    <option value="yellow">노랑</option>
								    <option value="black">검정</option>
								    <option value="white">흰색</option>
								    <option value="gray">회색</option>
								    <option value="pink">핑크</option>
								    <option value="purple">보라</option>
								    <option value="orange">주황</option>
								    <option value="brown">갈색</option>
								    <option value="beige">베이지</option>
								    <option value="teal">청록</option>
								    <option value="navy">남색</option>
								    <option value="lavender">라벤더</option>
								    <option value="khaki">카키</option>
								    <option value="maroon">와인/버건디</option>
								    <option value="mint">민트</option>
								    <option value="olive">올리브</option>
								    <option value="mustard">머스타드</option>
								    <option value="denim">데님</option>
								    <option value="lightBlue">연청</option>
    								<option value="darkGray">흑청</option>
								    <option value="cream">크림색</option>
								    <option value="ivory">아이보리</option>
								    <option value="charcoal">차콜</option>
								    <option value="gold">금색</option>
								    <option value="silver">은색</option>
								    <option value="other">기타</option>
								</select>
							</td>
                        </tr>
                        <tr>
                            <td>색상 계열</td>
                            <td>
                                <select name="clothLightness" required>
                                	<option value="">(선택)</option>
                                    <option value="light">밝은 계열</option>
				    				<option value="dark">어두운 계열</option>
   				    				<option value="other">기타</option>
                                </select>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="tab_content" id="tab3">
                    <table class="table" id="sizeTable">
                    	<tr>
                            <td>SIZE</td>
                            <td>COUNT</td>
                        </tr>
                    </table>
                </div>
                <div class="tab_content" id="tab4">
				    <table class="table">
				        <tr>
					        <td style="width: 500px; height: 500px; vertical-align: middle; text-align: center;">
					            <input type="file" id="imageUpload" accept="image/*" onchange="previewImage(event)" />
					        	<input type="hidden" id="clothImagePath" name="clothImagePath" required />
					        </td>
					        <td style="width: 500px; height: 500px; vertical-align: middle; text-align: center;">
					        	<img id="imagePreview" src="" alt="미리보기" style="display:none; width: 400px; height: 400px; object-fit: contain; margin-left: 10px;" />
				            </td>
 				        </tr>
				    </table>
				</div>
	            <div class="tab_content" id="tab5">
				    <table class="table">
				        <tr>
				            <td style="text-align: center;">MEMO:</td>
				            <td>
				                <textarea name="clothInfo" rows="5" cols="50" placeholder="상품 기록사항을 이곳에 입력하세요." autocomplete="off" required></textarea>
				            </td>
				        </tr>
				    </table>
				</div>
	        	<div class="button-container text-center">
					<input type="button" value="돌아가기" onclick="window.location.href='/admin/show/productList';" class="mr-3">
	                <input type="button" value="등록하기" onClick="submitForm()">
	            </div>
	      	</div>           
       	</form>
    </div>
    
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>
	
	<script>
		$(document).ready(function() {
	        // 탭 기능 초기화
	        $('.tab_content').hide(); // 모든 탭 콘텐츠 숨기기
	        $('#tab1').show(); // 첫 번째 탭 기본으로 보여주기
	
	        $('.tabs a').click(function(event) {
	            event.preventDefault();
	            $('.tab_content').hide(); // 모든 탭 콘텐츠 숨기기
	            $($(this).attr('href')).show(); // 클릭된 탭 콘텐츠 보여주기
	            $('.tabs a').removeClass('active'); // 모든 탭에서 active 클래스 제거
	            $(this).addClass('active'); // 클릭된 탭에 active 클래스 추가
	        });
		});
	</script>
	
	<script>
		//상품 이미지 함수
		function previewImage(event) {
		    const file = event.target.files[0];
		    const imagePreview = document.getElementById('imagePreview');
		    const clothImagePath = document.getElementById('clothImagePath');
		
		    if (file) {
		        const reader = new FileReader();
		        reader.onload = function(e) {
		            imagePreview.src = e.target.result;
		            imagePreview.style.display = 'block'; // 이미지 표시
		        };
		        reader.readAsDataURL(file);
		        
		     	// 파일 경로명 표시 (앞에 /static/img/ 붙이기)
		        clothImagePath.value = '/static/img/' + file.name; // '/static/img/'를 파일 이름 앞에 붙임
		    } else {
		    	// 파일 선택을 취소한 경우, 초기 이미지로 복원
		        imagePreview.src = document.getElementById('clothImagePath').value;
		        imagePreview.style.display = document.getElementById('clothImagePath').value ? 'block' : 'none';
		    }
		}
	</script>
		
	<script>
	    // 카테고리별 소분류 데이터 (value는 영어, 텍스트는 한글)
	    const subCategories = {
    		1: [
    		    { value: 'hoodie_jacket', text: '후드 집업' },
    		    { value: 'blouson_ma1', text: '블루종/MA-1' },
    		    { value: 'leather_riders', text: '레더/라이더스 재킷' },
    		    { value: 'mustang_fur', text: '무스탕/퍼' },
    		    { value: 'trucker', text: '트러커 재킷' },
    		    { value: 'blazer_suit', text: '슈트/블레이저 재킷' },
    		    { value: 'cardigan', text: '카디건' },
    		    { value: 'anorak', text: '아노락 재킷' },
    		    { value: 'fleece', text: '플리스/뽀글이' },
    		    { value: 'training', text: '트레이닝 재킷' },
    		    { value: 'stadium', text: '스타디움 재킷' },
    		    { value: 'transition_coat', text: '환절기 코트' },
    		    { value: 'winter_single_coat', text: '겨울 싱글 코트' },
    		    { value: 'winter_double_coat', text: '겨울 더블 코트' },
    		    { value: 'winter_other_coat', text: '겨울 기타 코트' },
    		    { value: 'long_padding', text: '롱패딩/헤비 아우터' },
    		    { value: 'short_padding', text: '숏패딩/헤비 아우터' },
    		    { value: 'padding_vest', text: '패딩 베스트' },
    		    { value: 'vest', text: '베스트' },
    		    { value: 'safari_hunting', text: '사파리/헌팅 재킷' },
    		    { value: 'nylon_coach', text: '나일론/코치 재킷' },
    		    { value: 'other_outer', text: '기타 아우터' }
    		],
    		2: [
    		    { value: 'sweatshirt', text: '맨투맨/스웨트' },
    		    { value: 'shirt', text: '셔츠/블라우스' },
    		    { value: 'hoodie', text: '후드 티셔츠' },
    		    { value: 'knit', text: '니트/스웨터' },
    		    { value: 'polo', text: '피케/카라 티셔츠' },
    		    { value: 'longsleeve', text: '긴소매 티셔츠' },
    		    { value: 'shortsleeve', text: '반소매 티셔츠' },
    		    { value: 'sleeveless', text: '민소매 티셔츠' },
    		    { value: 'sports_top', text: '스포츠 상의' },
    		    { value: 'other_top', text: '기타 상의' }
    		],
    		3: [
    		    { value: 'denim_pants', text: '데님 팬츠' },
    		    { value: 'cotton_pants', text: '코튼 팬츠' },
    		    { value: 'suit_slacks', text: '슈트 팬츠/슬랙스' },
    		    { value: 'jogger_pants', text: '트레이닝/조거 팬츠' },
    		    { value: 'shorts', text: '숏 팬츠' },
    		    { value: 'leggings', text: '레깅스' },
    		    { value: 'jumpsuit_overalls', text: '점프 슈트/오버올' },
    		    { value: 'sports_bottom', text: '스포츠 하의' },
    		    { value: 'other_bottom', text: '기타 바지' }
    		],
    		4: [
    		    { value: 'sneakers', text: '스니커즈' },
    		    { value: 'shoes', text: '구두' },
    		    { value: 'sandals_slippers', text: '샌들/슬리퍼' },
    		    { value: 'boots_walkers', text: '부츠/워커' },
    		    { value: 'sports_shoes', text: '운동화' },
    		    { value: 'other_shoes', text: '기타 신발' }
    		],
	        5: [
	            { value: 'hat', text: '모자' },
	            { value: 'bag', text: '가방' },
	            { value: 'watch', text: '시계' },
	            { value: 'jewelry', text: '주얼리' },
	            { value: 'other_accessory', text: '기타 액세서리' }
	        ]
	    };
	    
	    const sizes = {
	   	    1: ['XS', 'S', 'M', 'L', 'XL', '2XL'],
	   	    2: ['26', '28', '30', '32', '34', '36', '38', '40'],
	   	    3: ['240', '245', '250', '255', '260', '265', '270', '275', '280', '285', '290', '295', '300'],
	   	    4: ['free']
	    };
	    $(document).ready(function() {
	        // 카테고리 변경 이벤트 처리
	        $('#categorySelect').on('change', function() {
	            const selectedCategory = $(this).val();  // 선택된 카테고리의 값
	            const subCategorySelect = $('#subCategorySelect');  // 소분류 셀렉트 박스
	
	            // 소분류 초기화
	            subCategorySelect.empty();
	
	            // 소분류 선택하기 기본 옵션 추가
	            subCategorySelect.append('<option value="">(선택)</option>');
	
	            // 선택된 카테고리에 맞는 소분류 옵션 추가
	            if (subCategories[selectedCategory]) {
	                subCategories[selectedCategory].forEach(function(subCategory) {
	                    subCategorySelect.append(new Option(subCategory.text, subCategory.value));
	                });
	            }
	
	         	// 사이즈 테이블 초기화
	            $('#sizeTable').find("tr:gt(0)").remove(); // 기존 사이즈 행 제거

	            // 모든 사이즈 추가
	            Object.values(sizes).forEach(function(sizeArray, index) {
	                sizeArray.forEach(function(size) {
	                    $('#sizeTable').append('<tr class="size-row size-' + (index + 1) + '"><td>' + size + '</td><td><input type="number" name="size_' + size + '" min="0" value="0" autocomplete="off" required /></td></tr>');
	                });
	            });

	            // 모든 사이즈 행 숨김 처리
	            $('.size-row').hide(); // 처음에는 모든 행을 숨김
	
	            // 선택된 카테고리에 따라 사이즈 행 보이기
	            if (selectedCategory == '1' || selectedCategory == '2') { // 아우터, 상의
	                $('.size-1').show(); // 아우터, 상의 사이즈
	            } else if (selectedCategory == '3') { // 하의
	                $('.size-1').show(); // 하의 사이즈
	                $('.size-2').show(); // 하의 사이즈
	            } else if (selectedCategory == '4') { // 신발
	                $('.size-3').show(); // 신발 사이즈
	            } else if (selectedCategory == '5') { // 악세서리
	                $('.size-4').show(); // 악세서리 사이즈
	            }
	        });
	    });
	</script>
	
	<script>
	    function submitForm() {
	        var form = document.getElementById('addProductForm');
	
	        // 폼 유효성 검사
	        if (form.checkValidity() === false) {
	            // 유효하지 않은 입력 필드 찾기
	            var invalidField = form.querySelector(':invalid');
	
	            // 유효하지 않은 필드가 속한 탭 찾기
	            var invalidTab = invalidField.closest('.tab_content');
	            if (invalidTab) {
	                // 해당 탭의 ID 가져오기
	                var tabId = invalidTab.id;
	
	                // 해당 탭을 활성화
	                $('.nav-link').removeClass('active');
	                $('a[href="#' + tabId + '"]').addClass('active');
	
	                // 해당 탭 내용 표시
	                $('.tab_content').hide();
	                $('#' + tabId).show();
	            }
	            
	            form.reportValidity(); // 브라우저의 기본 오류 메시지 표시
	            
	            return; // 유효하지 않으면 폼 제출 중단
	        
	        }
	
	     	// AJAX로 폼 제출
	        var formData = new FormData(form);
	
	        $.ajax({
	            url: '/admin/addProduct', // 폼 액션 URL
	            type: 'POST',
	            data: formData,
	            contentType: false, // 파일 업로드를 위해 필요
	            processData: false, // 파일 업로드를 위해 필요
	            success: function(response) {
	                // 서버로부터 결과를 받았을 때
	                if (response.result === 'success') {
	                    alert('상품이 성공적으로 추가되었습니다.');
	                    // 성공 처리, 페이지 리다이렉션이나 다른 작업 수행
	                    window.location.href = "/admin/show/productList";
	                } else {
	                    alert('상품 추가에 실패하였습니다.');
	                    // 실패 처리
	                }
	            },
	            error: function() {
	                alert('서버 오류가 발생했습니다.');
	            }
	        });
	    }
	</script>
	
</body>
</html>
