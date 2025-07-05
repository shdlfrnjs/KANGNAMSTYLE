package com.project.cloth.bo;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.Random;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.basket.entity.BasketEntity;
import com.project.basket.repository.BasketRepository;
import com.project.cloth.entity.ClothDetail;
import com.project.cloth.entity.ClothEntity;
import com.project.cloth.entity.SizeEntity;
import com.project.cloth.repository.ClothRepository;
import com.project.cloth.repository.SizeRepository;
import com.project.user.entity.LikesEntity;
import com.project.user.repository.LikesRepository;
import com.project.weather.entity.WeatherEntity;

@Service
public class ClothBO {
	
	@Autowired
	private BasketRepository basketRepository;
	
	@Autowired
	private ClothRepository clothRepository;
	
	@Autowired
	private SizeRepository sizeRepository;
	
	@Autowired
	private LikesRepository likesRepository;
	
	public ClothEntity addNewProduct(
			String clothImagePath,
		    String clothName,
		    int clothRegularPrice,
		    int clothPrice,
		    String clothCategory,
		    String clothSubCategory,
		    String clothStyle,
		    String clothSeason,
		    String clothWeather,
		    String clothColor,
		    String clothLightness,
		    String clothInfo,
		    int size_XS,
		    int size_S,
		    int size_M,
		    int size_L,
		    int size_XL,
		    int size_2XL,
		    int size_26,
		    int size_28,
		    int size_30,
		    int size_32,
		    int size_34,
		    int size_36,
		    int size_38,
		    int size_40,
		    int size_240,
		    int size_245,
		    int size_250,
		    int size_255,
		    int size_260,
		    int size_265,
		    int size_270,
		    int size_275,
		    int size_280,
		    int size_285,
		    int size_290,
		    int size_295,
		    int size_300,
		    int size_free
	) {
		
	    // ClothEntity 생성 및 저장
	    ClothEntity cloth = ClothEntity.builder()
	    		.clothImagePath(clothImagePath)
	            .clothName(clothName)
	            .clothRegularPrice(clothRegularPrice)
	            .clothPrice(clothPrice)
	            .clothCategory(clothCategory)
	            .clothSubCategory(clothSubCategory)
	            .clothStyle(clothStyle)
	            .clothSeason(clothSeason)
	            .clothWeather(clothWeather)
	            .clothColor(clothColor)
	            .clothLightness(clothLightness)
	            .clothInfo(clothInfo)
	            .build();
	    clothRepository.save(cloth);
	
	    // SizeEntity에 모든 사이즈 정보 저장
	    SizeEntity size = SizeEntity.builder()
	            .clothId(cloth.getId())
	            .size_XS(size_XS)
	            .size_S(size_S)
	            .size_M(size_M)
	            .size_L(size_L)
	            .size_XL(size_XL)
	            .size_2XL(size_2XL)
	            .size_26(size_26)
	            .size_28(size_28)
	            .size_30(size_30)
	            .size_32(size_32)
	            .size_34(size_34)
	            .size_36(size_36)
	            .size_38(size_38)
	            .size_40(size_40)
	            .size_240(size_240)
	            .size_245(size_245)
	            .size_250(size_250)
	            .size_255(size_255)
	            .size_260(size_260)
	            .size_265(size_265)
	            .size_270(size_270)
	            .size_275(size_275)
	            .size_280(size_280)
	            .size_285(size_285)
	            .size_290(size_290)
	            .size_295(size_295)
	            .size_300(size_300)
	            .size_free(size_free)
	            .build();
	    try {
	        sizeRepository.save(size);
	        return cloth; // 저장이 성공한 경우 cloth 반환
	    } catch (Exception e) {
	        // 사이즈 저장 실패 시 예외 처리
	        throw new RuntimeException("사이즈 저장 실패: " + e.getMessage());
	    }
	}

	public ClothEntity modifyProduct(
		    int clothId,
		    String clothImagePath,
		    String clothName,
		    int clothRegularPrice,
		    int clothPrice,
		    String clothCategory,
		    String clothSubCategory,
		    String clothStyle,
		    String clothSeason,
		    String clothWeather,
		    String clothColor,
		    String clothLightness,
		    String clothInfo,
		    int size_XS,
		    int size_S,
		    int size_M,
		    int size_L,
		    int size_XL,
		    int size_2XL,
		    int size_26,
		    int size_28,
		    int size_30,
		    int size_32,
		    int size_34,
		    int size_36,
		    int size_38,
		    int size_40,
		    int size_240,
		    int size_245,
		    int size_250,
		    int size_255,
		    int size_260,
		    int size_265,
		    int size_270,
		    int size_275,
		    int size_280,
		    int size_285,
		    int size_290,
		    int size_295,
		    int size_300,
		    int size_free
	) {
	    // ClothEntity 수정
	    Optional<ClothEntity> optionalCloth = clothRepository.findById(clothId);

	    if (optionalCloth.isPresent()) {
	        ClothEntity cloth = optionalCloth.get();
	        
	        cloth.setClothImagePath(clothImagePath);
	        cloth.setClothName(clothName);
	        cloth.setClothRegularPrice(clothRegularPrice);
	        cloth.setClothPrice(clothPrice);
	        cloth.setClothCategory(clothCategory);
	        cloth.setClothSubCategory(clothSubCategory);
	        cloth.setClothStyle(clothStyle);
	        cloth.setClothSeason(clothSeason);
	        cloth.setClothWeather(clothWeather);
	        cloth.setClothColor(clothColor);
	        cloth.setClothLightness(clothLightness);
	        cloth.setClothInfo(clothInfo);
	        
	        clothRepository.save(cloth);
	        
	        // SizeEntity 수정
	        Optional<SizeEntity> optionalSize = sizeRepository.findByClothId(clothId);
	        
	        if (optionalSize.isPresent()) {
	            SizeEntity size = optionalSize.get();
	            size.setSize_XS(size_XS);
	            size.setSize_S(size_S);
	            size.setSize_M(size_M);
	            size.setSize_L(size_L);
	            size.setSize_XL(size_XL);
	            size.setSize_2XL(size_2XL);
	            size.setSize_26(size_26);
	            size.setSize_28(size_28);
	            size.setSize_30(size_30);
	            size.setSize_32(size_32);
	            size.setSize_34(size_34);
	            size.setSize_36(size_36);
	            size.setSize_38(size_38);
	            size.setSize_40(size_40);
	            size.setSize_240(size_240);
	            size.setSize_245(size_245);
	            size.setSize_250(size_250);
	            size.setSize_255(size_255);
	            size.setSize_260(size_260);
	            size.setSize_265(size_265);
	            size.setSize_270(size_270);
	            size.setSize_275(size_275);
	            size.setSize_280(size_280);
	            size.setSize_285(size_285);
	            size.setSize_290(size_290);
	            size.setSize_295(size_295);
	            size.setSize_300(size_300);
	            size.setSize_free(size_free);
	            
	            sizeRepository.save(size);
	        } else {
	            throw new RuntimeException("사이즈 정보를 찾을 수 없습니다.");
	        }
	        
	        return cloth;  // 성공적으로 업데이트된 ClothEntity 반환
	    } else {
	        throw new RuntimeException("상품을 찾을 수 없습니다.");
	    }
	}
	
	// 옷 하나 클릭했을 때 상세정보 보여주기
	public ClothEntity getClothInfo(int id) {
		
		Optional<ClothEntity> optionalCloth = clothRepository.findById(id);
		
		ClothEntity cloth = optionalCloth.orElse(null);
		
		return cloth;
		
	}
	
	// 선택한 옷의 사이즈 재고 
    public SizeEntity getSizeInfo(int clothId) {
        
        SizeEntity size = sizeRepository.findByClothId(clothId).orElse(null);
        
        return size;
    }
    
    // 옷 카테고리 분류해서 보여주는
 	public List<ClothDetail> getClassifiedClothes(String clothCategory, String clothSubCategory, String sort) {
 	    List<ClothEntity> clothList;

 	    // 필터링 로직
 	    if (clothSubCategory != null && !clothSubCategory.isEmpty()) {
 	        clothList = clothRepository.findByClothCategoryAndClothSubCategory(clothCategory, clothSubCategory);
 	    } else {
 	        clothList = clothRepository.findByClothCategory(clothCategory);
 	    }

 	    // 정렬 로직
 	    if ("clothPriceAsc".equals(sort)) {
 	        clothList.sort(Comparator.comparing(ClothEntity::getClothPrice));
 	    } else if ("clothPriceDesc".equals(sort)) {
 	        clothList.sort(Comparator.comparing(ClothEntity::getClothPrice).reversed());
 	    } else if ("clothTotalSales".equals(sort)) {
 	        clothList.sort(Comparator.comparing(ClothEntity::getClothTotalSales).reversed());
 	    } else if ("clothName".equals(sort)) {
 	        clothList.sort(Comparator.comparing(ClothEntity::getClothName));
 	    } else if ("createdAt".equals(sort)) {
 	        clothList.sort(Comparator.comparing(ClothEntity::getCreatedAt).reversed());
 	    }

 	    // ClothDetail 변환
 	    List<ClothDetail> clothDetailList = new ArrayList<>();
 	    for (ClothEntity cloth : clothList) {
 	        ClothDetail clothDetail = ClothDetail.builder()
							            .clothId(cloth.getId())
							            .clothName(cloth.getClothName())
							            .clothCategory(cloth.getClothCategory())
							            .clothRegularPrice(cloth.getClothRegularPrice())
							            .clothPrice(cloth.getClothPrice())
							            .clothImagePath(cloth.getClothImagePath())
							            .build();
 	        
 	        clothDetailList.add(clothDetail);
 	    }
 	    
 	    return clothDetailList;
 	}
 	
 	// 메인 베스트셀러 추천
 	public List<ClothDetail> getMainBestSeller() {
 	    
 	    // 모든 ClothEntity 가져오기
 	    List<ClothEntity> clothList = clothRepository.findAll();
 	    
 	    // 1차적으로 판매량 기준 내림차순 정렬, 판매량 동일 시 2차적으로 신상품순 기준 내림차순 정렬
 	    clothList.sort(
 	        Comparator.comparing(ClothEntity::getClothTotalSales).reversed()
 	                  .thenComparing(Comparator.comparing(ClothEntity::getCreatedAt).reversed())
 	    );
 	    
 	    List<ClothDetail> clothDetailList = new ArrayList<>();
 	    
 	    // 최대 5개의 베스트셀러 상품을 ClothDetail 리스트로 변환
 	    for (int i = 0; i < Math.min(clothList.size(), 5); i++) {
 	        ClothEntity cloth = clothList.get(i);
 	        int clothId = cloth.getId(); // cloth의 primary key 가져오기

 	        ClothDetail clothDetail = ClothDetail.builder()
										.clothId(clothId)
										.clothName(cloth.getClothName())
										.clothCategory(cloth.getClothCategory())
										.clothRegularPrice(cloth.getClothRegularPrice())
										.clothPrice(cloth.getClothPrice())
										.clothImagePath(cloth.getClothImagePath())
										.build();
 	                                    
 	        clothDetailList.add(clothDetail);
 	    }
 	    return clothDetailList;
 	}
	
	// 메인 페이지 날씨 추천 기능
	public List<ClothDetail> getWeatherCloth(WeatherEntity weatherEntity) {
	    // 의류 목록을 DB에서 가져옴
	    List<ClothEntity> clothList = clothRepository.findAll();
	    List<ClothDetail> clothDetailList = new ArrayList<>();

	    // 날씨에 따른 분류 기준 설정
	    String todayWeather = weatherEntity.getWeather();  // "Clear" or other
	    double todayTemperature = weatherEntity.getTemperature();  // 현재 온도

	    // 온도에 따른 의류 분류
	    String clothSeason = getSeasonFromTemperature(todayTemperature);

	    // 날씨 조건에 맞는 의류 필터링
	    for (ClothEntity cloth : clothList) {
	        // 날씨에 따른 분류
	        String clothWeather = getClothWeather(todayWeather);

	        // 계절에 따른 분류
	        if (cloth.getClothSeason().equals(clothSeason)) {
	            if (cloth.getClothWeather().equals(clothWeather)) {
	                // 조건에 맞는 의류 추가
	                ClothDetail clothDetail = ClothDetail.builder()
						                        .clothId(cloth.getId())
						                        .clothName(cloth.getClothName())
						                        .clothCategory(cloth.getClothCategory())
						                        .clothRegularPrice(cloth.getClothRegularPrice())
						                        .clothPrice(cloth.getClothPrice())
						                        .clothImagePath(cloth.getClothImagePath())
						                        .build();

	                clothDetailList.add(clothDetail);
	            }
	        }
	    }

	    // 리스트를 무작위로 섞고 5개만 선택
	    Collections.shuffle(clothDetailList);  // 의류 목록을 무작위로 섞음
	    return clothDetailList.size() > 5 ? clothDetailList.subList(0, 5) : clothDetailList;  // 5개 이하라면 전체 반환, 아니면 상위 5개만 반환
	}

	// 날씨에 따라 의류의 날씨 속성(맑음, 비 등) 설정
	private String getClothWeather(String currentWeather) {
	    if ("Clear".equalsIgnoreCase(currentWeather)) {
	        return "sunny";  // 날씨가 Clear 경우 sunny
	    } else {
	        return "rainy";  // 그 외 날씨는 rainy
	    }
	}

	// 현재 온도에 따른 계절 분류
	private String getSeasonFromTemperature(double temperature) {
	    if (temperature >= 23) {
	        return "summer";  // 23도 이상 여름
	    } else if (temperature >= 16 && temperature < 23) {
	        return "spring_fall";  // 16도~22도 봄/가을
	    } else if (temperature >= 9 && temperature < 16) {
	        return "fall_winter";  // 9도~15도 가을/겨울
	    } else {
	        return "winter";  // 9도 이하 겨울
	    }
	}
	
	// 메인 할인상품 추천
	public List<ClothDetail> getOnSaleCloth() {

	    // 모든 ClothEntity 가져오기
	    List<ClothEntity> clothList = clothRepository.findAll();
	    
	    // 할인율이 50% 이상인 상품만 필터링
	    List<ClothEntity> filteredList = clothList.stream()
	        .filter(cloth -> {
	            double discountRate = ((double) (cloth.getClothRegularPrice() - cloth.getClothPrice())) / cloth.getClothRegularPrice();
	            return discountRate >= 0.5; // 할인율이 50% 이상인 경우만 필터링
	        })
	        .collect(Collectors.toList());
	    
	    // 필터링된 리스트를 무작위로 섞음
	    Collections.shuffle(filteredList);
	    
	    // 최대 5개까지 선택
	    List<ClothDetail> clothDetailList = new ArrayList<>();
	    for (int i = 0; i < Math.min(filteredList.size(), 5); i++) {
	        ClothEntity cloth = filteredList.get(i);
	        
	        ClothDetail clothDetail = ClothDetail.builder()
	                                    .clothId(cloth.getId())
	                                    .clothName(cloth.getClothName())
	                                    .clothCategory(cloth.getClothCategory())
	                                    .clothRegularPrice(cloth.getClothRegularPrice())
	                                    .clothPrice(cloth.getClothPrice())
	                                    .clothImagePath(cloth.getClothImagePath())
	                                    .build();
	                                    
	        clothDetailList.add(clothDetail);
	    }
	    
	    return clothDetailList;
	}
	 	
	// 메인페이지 사용자 기반 추천
    public List<ClothDetail> getRecommendedCloth(int userId) {

        // BasketEntity와 LikesEntity에서 userId로 데이터를 가져오기
        List<BasketEntity> basketEntities = basketRepository.findByUserId(userId);
        List<LikesEntity> likesEntities = likesRepository.findByUserId(userId);

        // 장바구니나 찜한 상품이 없는 경우 null 반환
        if (basketEntities.isEmpty() && likesEntities.isEmpty()) {
            return null;
        }

        // BasketEntity와 LikesEntity에서 clothSubCategory를 수집
        Set<String> subCategories = new HashSet<>();

        // 장바구니 항목에서 clothName으로 subCategory 수집
        subCategories.addAll(basketEntities.stream()
                .map(BasketEntity::getClothName)
                .map(clothName -> clothRepository.findByClothName(clothName))
                .filter(Objects::nonNull)
                .map(ClothEntity::getClothSubCategory)
                .collect(Collectors.toSet()));

        // 찜한 항목에서 clothId로 subCategory 수집
        subCategories.addAll(likesEntities.stream()
                .map(LikesEntity::getClothId)
                .map(clothId -> clothRepository.findById(clothId).orElse(null))
                .filter(Objects::nonNull)
                .map(ClothEntity::getClothSubCategory)
                .collect(Collectors.toSet()));

        // 수집된 subCategory가 없는 경우 null 반환
        if (subCategories.isEmpty()) {
            return null;
        }

        // 수집된 subCategory 중 하나를 무작위로 선택
        List<String> subCategoryList = new ArrayList<>(subCategories);
        Collections.shuffle(subCategoryList);
        String selectedSubCategory = subCategoryList.get(0);

        // 선택된 subCategory에 해당하는 ClothEntity 목록 가져오기
        List<ClothEntity> clothList = clothRepository.findByClothSubCategory(selectedSubCategory);

        // 상품 목록을 무작위로 섞기
        Collections.shuffle(clothList);

        List<ClothDetail> clothDetailList = new ArrayList<>();

        // 최대 5개의 무작위 상품을 ClothDetail 리스트로 변환
        for (int i = 0; i < Math.min(clothList.size(), 5); i++) {
            ClothEntity cloth = clothList.get(i);
            int clothId = cloth.getId(); // cloth의 primary key 가져오기

            ClothDetail clothDetail = ClothDetail.builder()
            							.clothId(clothId)
	                                    .clothName(cloth.getClothName())
	                                    .clothCategory(cloth.getClothCategory())
	                                    .clothRegularPrice(cloth.getClothRegularPrice())
	                                    .clothPrice(cloth.getClothPrice())
	                                    .clothImagePath(cloth.getClothImagePath())
	                                    .build();

            clothDetailList.add(clothDetail);
        }

        return clothDetailList;
    }
    
	// 베스트셀러 배너
	public List<ClothDetail> getBestSeller() {
	    
	    // 모든 ClothEntity 가져오기
	    List<ClothEntity> clothList = clothRepository.findAll();
	    
	    // 1차적으로 판매량 기준 내림차순 정렬, 판매량 동일 시 2차적으로 신상품순 기준 내림차순 정렬
	    clothList.sort(
	        Comparator.comparing(ClothEntity::getClothTotalSales).reversed()
	                  .thenComparing(Comparator.comparing(ClothEntity::getCreatedAt).reversed())
	    );
	    
	    List<ClothDetail> clothDetailList = new ArrayList<>();
	    
	    // 최대 15개의 베스트셀러 상품을 ClothDetail 리스트로 변환
	    for (int i = 0; i < Math.min(clothList.size(), 15); i++) {
	        ClothEntity cloth = clothList.get(i);
	        int clothId = cloth.getId(); // cloth의 primary key 가져오기

	        ClothDetail clothDetail = ClothDetail.builder()
						        		.clothId(clothId)
					                    .clothName(cloth.getClothName())
					                    .clothCategory(cloth.getClothCategory())
					                    .clothRegularPrice(cloth.getClothRegularPrice())
					                    .clothPrice(cloth.getClothPrice())
					                    .clothImagePath(cloth.getClothImagePath())
					                    .build();
	                                    
	        clothDetailList.add(clothDetail);
	    }
	    return clothDetailList;
	}

	// 신상품 배너
	public List<ClothDetail> getNewCollection() {
	    
	    // 모든 ClothEntity 가져오기
	    List<ClothEntity> clothList = clothRepository.findAll();
	    
	    // 신상품순 기준 내림차순 정렬
	    clothList.sort(Comparator.comparing(ClothEntity::getCreatedAt).reversed());
	    
	    List<ClothDetail> clothDetailList = new ArrayList<>();
	    
	    // 최대 15개의 신상품을 ClothDetail 리스트로 변환
	    for (int i = 0; i < Math.min(clothList.size(), 15); i++) {
	        ClothEntity cloth = clothList.get(i);
	        int clothId = cloth.getId(); // cloth의 primary key 가져오기

	        ClothDetail clothDetail = ClothDetail.builder()
					                    .clothId(clothId)
					                    .clothName(cloth.getClothName())
					                    .clothCategory(cloth.getClothCategory())
					                    .clothRegularPrice(cloth.getClothRegularPrice())
					                    .clothPrice(cloth.getClothPrice())
					                    .clothImagePath(cloth.getClothImagePath())
					                    .build();
	                                    
	        clothDetailList.add(clothDetail);
	    }
	    return clothDetailList;
	}
	
	// 겨울상품 배너
	public List<ClothDetail> getWinterCollection() {
	    
	    // "winter" 시즌의 ClothEntity만 필터링
	    List<ClothEntity> clothList = clothRepository.findAll().stream()
	        .filter(cloth -> "winter".equals(cloth.getClothSeason())) // clothSeason이 "winter"인 제품 필터링
	        .sorted(Comparator.comparing(ClothEntity::getCreatedAt).reversed()) // 신상품 순으로 정렬
	        .collect(Collectors.toList());
	    
	    List<ClothDetail> clothDetailList = new ArrayList<>();
	    
	    // 필터링된 모든 winter 시즌의 상품을 ClothDetail 리스트로 변환
	    for (ClothEntity cloth : clothList) {
	        int clothId = cloth.getId(); // cloth의 primary key 가져오기

	        ClothDetail clothDetail = ClothDetail.builder()
					                    .clothId(clothId)
					                    .clothName(cloth.getClothName())
					                    .clothCategory(cloth.getClothCategory())
					                    .clothRegularPrice(cloth.getClothRegularPrice())
					                    .clothPrice(cloth.getClothPrice())
					                    .clothImagePath(cloth.getClothImagePath())
					                    .build();
	                                    
	        clothDetailList.add(clothDetail);
	    }
	    return clothDetailList;
	}
	
	// 관리자 추천 픽 배너
	public List<ClothDetail> getManagerPickCloth(String style) {
	    // 스타일별로 미리 정의된 clothId 배열
	    Map<String, List<List<Integer>>> predefinedClothIdsMap = new HashMap<>();
	    
	    predefinedClothIdsMap.put("casual", Arrays.asList(
	        Arrays.asList(1, 2, 3, 4),
	        Arrays.asList(5, 6, 7, 8, 9, 10)
	    ));
	    predefinedClothIdsMap.put("street", Arrays.asList(
	        Arrays.asList(14, 11, 12, 13, 15, 16)
	    ));
	    predefinedClothIdsMap.put("minimal", Arrays.asList(
	        Arrays.asList(17, 18, 19, 20, 22, 21, 23, 24)
	    ));
	    predefinedClothIdsMap.put("classic", Arrays.asList(
	        Arrays.asList(30, 31, 32, 33, 36, 35, 34)
	    ));
	    predefinedClothIdsMap.put("sportswear", Arrays.asList(
	        Arrays.asList(25, 26, 28, 27, 29)
	    ));

	    // 스타일에 해당하는 배열 리스트 가져오기
	    List<List<Integer>> predefinedClothIds = predefinedClothIdsMap.get(style);
	    
	    // 스타일이 유효하지 않으면 빈 리스트 반환
	    if (predefinedClothIds == null) {
	        return Collections.emptyList();
	    }

	    // 무작위로 배열 선택
	    Random random = new Random();
	    List<Integer> randomClothIds = predefinedClothIds.get(random.nextInt(predefinedClothIds.size()));

	    // clothIds에 해당하는 ClothEntity 가져오기
	    List<ClothEntity> clothList = clothRepository.findAllById(randomClothIds);
	    
	    // ClothEntity를 Map으로 변환 (ID 기준으로 빠르게 조회하기 위해)
	    Map<Integer, ClothEntity> clothMap = clothList.stream()
	                                                  .collect(Collectors.toMap(ClothEntity::getId, cloth -> cloth));
	    
	    List<ClothDetail> clothDetailList = new ArrayList<>();
	    
	    // 미리 정해놓은 순서대로 ClothDetail 리스트 생성
	    for (Integer clothId : randomClothIds) {
	        ClothEntity cloth = clothMap.get(clothId);
	        if (cloth != null) {
	            ClothDetail clothDetail = ClothDetail.builder()
	                                                 .clothId(cloth.getId())
	                                                 .clothName(cloth.getClothName())
	                                                 .clothCategory(cloth.getClothCategory())
	                                                 .clothRegularPrice(cloth.getClothRegularPrice())
	                                                 .clothPrice(cloth.getClothPrice())
	                                                 .clothImagePath(cloth.getClothImagePath())
	                                                 .build();
	            clothDetailList.add(clothDetail);
	        }
	    }
	    return clothDetailList;
	}
	
	// 상품 검색
	public List<ClothDetail> getSearchedCloth(String keyword, String sort) {
		List<ClothEntity> clothEntities;

	    // 키워드가 "전체 상품"일 경우 전체 목록 가져오기
	    if ("전체 상품".equalsIgnoreCase(keyword)) {
	        clothEntities = clothRepository.findAll();
	    } else {
	        clothEntities = new ArrayList<>();

	        // keyword로 clothName과 clothInfo를 모두 검색
	        clothEntities.addAll(clothRepository.findByClothNameContainingIgnoreCase(keyword));
	        clothEntities.addAll(clothRepository.findByClothInfoContainingIgnoreCase(keyword));

	        // 중복 제거를 위해 Set으로 변환 후 다시 List로 변환
	        clothEntities = new ArrayList<>(new HashSet<>(clothEntities));
	    }

        // 정렬 로직
 	    if ("clothPriceAsc".equals(sort)) {
 	    	clothEntities.sort(Comparator.comparing(ClothEntity::getClothPrice));
 	    } else if ("clothPriceDesc".equals(sort)) {
 	    	clothEntities.sort(Comparator.comparing(ClothEntity::getClothPrice).reversed());
 	    } else if ("clothTotalSales".equals(sort)) {
 	    	clothEntities.sort(Comparator.comparing(ClothEntity::getClothTotalSales).reversed());
 	    } else if ("clothName".equals(sort)) {
 	    	clothEntities.sort(Comparator.comparing(ClothEntity::getClothName));
 	    } else if ("createdAt".equals(sort)) {
 	    	clothEntities.sort(Comparator.comparing(ClothEntity::getCreatedAt).reversed());
 	    }
 	    
 	    List<ClothDetail> clothDetailList = new ArrayList<>();
 	    
        for (ClothEntity cloth : clothEntities) {
            int clothId = cloth.getId(); // cloth의 primary key 가져오기

            ClothDetail clothDetail = ClothDetail.builder()
                    .clothId(clothId)
                    .clothName(cloth.getClothName())
                    .clothCategory(cloth.getClothCategory())
                    .clothRegularPrice(cloth.getClothRegularPrice())
                    .clothPrice(cloth.getClothPrice())
                    .clothImagePath(cloth.getClothImagePath())
                    .build();
                    
            clothDetailList.add(clothDetail);
        }
        return clothDetailList;
    }	
	
}