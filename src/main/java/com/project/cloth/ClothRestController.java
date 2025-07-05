package com.project.cloth;

import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.project.cloth.bo.ClothBO;
import com.project.cloth.entity.ClothEntity;
import com.project.cloth.repository.ClothRepository;

@RestController
public class ClothRestController {
	
	@Autowired
	private ClothBO clothBO;
	
	@Autowired
	private ClothRepository clothRepository;
	
	// 신규 상품 등록
	@PostMapping("/admin/addProduct")
	public Map<String, String> addProduct(
	    @RequestParam("clothImagePath") String clothImagePath,
	    @RequestParam("clothName") String clothName,
	    @RequestParam("clothRegularPrice") int clothRegularPrice,
	    @RequestParam("clothPrice") int clothPrice,
	    @RequestParam("clothCategory") String clothCategory,
	    @RequestParam("clothSubCategory") String clothSubCategory,
	    @RequestParam("clothStyle") String clothStyle,
	    @RequestParam("clothSeason") String clothSeason,
	    @RequestParam("clothWeather") String clothWeather,
	    @RequestParam("clothColor") String clothColor,
	    @RequestParam("clothLightness") String clothLightness,
	    @RequestParam("clothInfo") String clothInfo,
	    @RequestParam("size_XS") int size_XS,
	    @RequestParam("size_S") int size_S,
	    @RequestParam("size_M") int size_M,
	    @RequestParam("size_L") int size_L,
	    @RequestParam("size_XL") int size_XL,
	    @RequestParam("size_2XL") int size_2XL,
	    @RequestParam("size_26") int size_26,
	    @RequestParam("size_28") int size_28,
	    @RequestParam("size_30") int size_30,
	    @RequestParam("size_32") int size_32,
	    @RequestParam("size_34") int size_34,
	    @RequestParam("size_36") int size_36,
	    @RequestParam("size_38") int size_38,
	    @RequestParam("size_40") int size_40,
	    @RequestParam("size_240") int size_240,
	    @RequestParam("size_245") int size_245,
	    @RequestParam("size_250") int size_250,
	    @RequestParam("size_255") int size_255,
	    @RequestParam("size_260") int size_260,
	    @RequestParam("size_265") int size_265,
	    @RequestParam("size_270") int size_270,
	    @RequestParam("size_275") int size_275,
	    @RequestParam("size_280") int size_280,
	    @RequestParam("size_285") int size_285,
	    @RequestParam("size_290") int size_290,
	    @RequestParam("size_295") int size_295,
	    @RequestParam("size_300") int size_300,
	    @RequestParam("size_free") int size_free
	) {
		
		// ClothEntity 생성 및 사이즈 수량 설정
	    ClothEntity cloth = clothBO.addNewProduct(
	    	clothImagePath,
    		clothName,
            clothRegularPrice,
            clothPrice,
            clothCategory,
            clothSubCategory,
            clothStyle,
            clothSeason,
            clothWeather,
            clothColor,
            clothLightness,
            clothInfo,
            size_XS,
            size_S,
            size_M,
            size_L,
            size_XL,
            size_2XL,
            size_26,
            size_28,
            size_30,
            size_32,
            size_34,
            size_36,
            size_38,
            size_40,
            size_240,
            size_245,
            size_250,
            size_255,
            size_260,
            size_265,
            size_270,
            size_275,
            size_280,
            size_285,
            size_290,
            size_295,
            size_300,
            size_free
        );
		
		Map<String, String> resultMap = new HashMap<>();
		
		if(cloth!=null) {
			resultMap.put("result","success");
		} else {
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	// 기존 상품 수정
	@PutMapping("/admin/modifyProduct")
	public Map<String, String> modifyProduct(
		@RequestParam("clothId") int clothId,
	    @RequestParam("clothImagePath") String clothImagePath,
	    @RequestParam("clothName") String clothName,
	    @RequestParam("clothRegularPrice") int clothRegularPrice,
	    @RequestParam("clothPrice") int clothPrice,
	    @RequestParam("clothCategory") String clothCategory,
	    @RequestParam("clothSubCategory") String clothSubCategory,
	    @RequestParam("clothStyle") String clothStyle,
	    @RequestParam("clothSeason") String clothSeason,
	    @RequestParam("clothWeather") String clothWeather,
	    @RequestParam("clothColor") String clothColor,
	    @RequestParam("clothLightness") String clothLightness,
	    @RequestParam("clothInfo") String clothInfo,
	    @RequestParam("size_XS") int size_XS,
	    @RequestParam("size_S") int size_S,
	    @RequestParam("size_M") int size_M,
	    @RequestParam("size_L") int size_L,
	    @RequestParam("size_XL") int size_XL,
	    @RequestParam("size_2XL") int size_2XL,
	    @RequestParam("size_26") int size_26,
	    @RequestParam("size_28") int size_28,
	    @RequestParam("size_30") int size_30,
	    @RequestParam("size_32") int size_32,
	    @RequestParam("size_34") int size_34,
	    @RequestParam("size_36") int size_36,
	    @RequestParam("size_38") int size_38,
	    @RequestParam("size_40") int size_40,
	    @RequestParam("size_240") int size_240,
	    @RequestParam("size_245") int size_245,
	    @RequestParam("size_250") int size_250,
	    @RequestParam("size_255") int size_255,
	    @RequestParam("size_260") int size_260,
	    @RequestParam("size_265") int size_265,
	    @RequestParam("size_270") int size_270,
	    @RequestParam("size_275") int size_275,
	    @RequestParam("size_280") int size_280,
	    @RequestParam("size_285") int size_285,
	    @RequestParam("size_290") int size_290,
	    @RequestParam("size_295") int size_295,
	    @RequestParam("size_300") int size_300,
	    @RequestParam("size_free") int size_free
	) {
		
		// ClothEntity 생성 및 사이즈 수량 설정
	    ClothEntity cloth = clothBO.modifyProduct(
	    	clothId,
	    	clothImagePath,
    		clothName,
            clothRegularPrice,
            clothPrice,
            clothCategory,
            clothSubCategory,
            clothStyle,
            clothSeason,
            clothWeather,
            clothColor,
            clothLightness,
            clothInfo,
            size_XS,
            size_S,
            size_M,
            size_L,
            size_XL,
            size_2XL,
            size_26,
            size_28,
            size_30,
            size_32,
            size_34,
            size_36,
            size_38,
            size_40,
            size_240,
            size_245,
            size_250,
            size_255,
            size_260,
            size_265,
            size_270,
            size_275,
            size_280,
            size_285,
            size_290,
            size_295,
            size_300,
            size_free
        );
		
		Map<String, String> resultMap = new HashMap<>();
		
		if(cloth!=null) {
			resultMap.put("result","success");
		} else {
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	// 자동완성 제안
	@GetMapping("/getSearchSuggestions")
	@ResponseBody
	public List<String> getSearchSuggestions(@RequestParam("term") String term) {
	    // clothEntity의 모든 clothName을 가져오기
	    List<String> clothNames = clothRepository.findAll().stream()
	            .filter(cloth -> cloth.getClothName().toLowerCase().contains(term.toLowerCase())) // 입력된 텍스트 포함 여부
	            .sorted(Comparator
	                    .comparing(ClothEntity::getClothTotalSales).reversed() // clothTotalSales 내림차순 정렬
	                    .thenComparing(ClothEntity::getCreatedAt, Comparator.reverseOrder())) // 동일한 clothTotalSales이면 createdAt 내림차순
	            .map(ClothEntity::getClothName)
	            .collect(Collectors.toList());

	    return clothNames;
	}

}