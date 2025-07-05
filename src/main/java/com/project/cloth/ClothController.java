package com.project.cloth;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.cloth.bo.ClothBO;
import com.project.cloth.entity.ClothDetail;
import com.project.cloth.entity.ClothEntity;
import com.project.cloth.entity.SizeEntity;

@Controller
public class ClothController {

	@Autowired
	private ClothBO clothBO;

	@GetMapping("/main/productDetail")
	public String clothDetail(Model model) {
		model.addAttribute("viewName", "main/productDetail");
		return "template/mainLayout";
	}

	@GetMapping("/main/clothes-detail")
	public String clothesDetail(@RequestParam("id") int id, Model model) {
		ClothEntity cloth = clothBO.getClothInfo(id);
		SizeEntity size = clothBO.getSizeInfo(id);
		
		model.addAttribute("clothInfo", cloth);
		model.addAttribute("sizeInfo", size);
		model.addAttribute("viewName", "main/productDetail");
		return "template/mainLayout";
	}
	
	@GetMapping("/main/clothes/classify")
	public String clothClassify(
	    @RequestParam("clothCategory") String clothCategory, 
	    @RequestParam(value = "clothSubCategory", required = false) String clothSubCategory, 
	    @RequestParam(value = "sort", required = false) String sort,
	    @RequestParam(value = "page", defaultValue = "1") int page,
        @RequestParam(value = "size", defaultValue = "10") int size,
	    Model model) {
	    
		// 기본 정렬 설정
	    if (sort == null) {
	        sort = "createdAt"; // 기본값을 신상품으로 설정
	    }
	    
	    // 분류된 옷 목록 가져오기
	    List<ClothDetail> clothList = clothBO.getClassifiedClothes(clothCategory, clothSubCategory, sort); // 정렬 기준 전달

	    // 페이징 처리
	    int totalItems = clothList.size();
	    int fromIndex = Math.min((page - 1) * size, totalItems);
	    int toIndex = Math.min(fromIndex + size, totalItems);
	    List<ClothDetail> paginatedClothList = clothList.subList(fromIndex, toIndex);

	    model.addAttribute("selectedCategory", clothCategory);
	    model.addAttribute("selectedSubCategory", clothSubCategory);
	    model.addAttribute("clothList", paginatedClothList);
	    model.addAttribute("selectedSort", sort); // 현재 선택된 정렬 기준 저장
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", (int) Math.ceil((double) totalItems / size));
	    model.addAttribute("viewName", "main/clothClassify");
	    return "template/mainLayout";
	}

	@GetMapping("/main/clothes/bestSeller")
	public String bestSeller(Model model) {
		
		List<ClothDetail> clothList = clothBO.getBestSeller();
		
		model.addAttribute("clothList", clothList);
		model.addAttribute("viewName", "main/bestSeller");
		return "template/mainLayout";
	}
	
	@GetMapping("/main/clothes/newCollection")
	public String newCollection(Model model) {
		
		List<ClothDetail> clothList = clothBO.getNewCollection();
		
		model.addAttribute("clothList", clothList);
		model.addAttribute("viewName", "main/newCollection");
		return "template/mainLayout";
	}
	
	@GetMapping("/main/clothes/winterCollection")
	public String winterCollection(Model model) {
		
		List<ClothDetail> clothList = clothBO.getWinterCollection();
		
		model.addAttribute("clothList", clothList);
		model.addAttribute("viewName", "main/winterCollection");
		return "template/mainLayout";
	}
	
	@GetMapping("/main/clothes/managerPickCloth")
	public String managerPickCloth(
			@RequestParam(value = "style", required = false) String style,
			Model model) {
		
		// 기본 코디 설정
	    if (style == null) {
	    	style = "casual"; // 기본값을 캐주얼로 설정
	    }
	    
		List<ClothDetail> clothList = clothBO.getManagerPickCloth(style);
		
		model.addAttribute("clothList", clothList);
		model.addAttribute("selectedStyle", style);
		model.addAttribute("viewName", "main/managerPickCloth");
		return "template/mainLayout";
	}
	
	// 상품 검색하기
	@GetMapping("/main/clothes/search")
    public String searchCloth(
    		@RequestParam("keyword") String keyword,
    		@RequestParam(value = "sort", required = false) String sort,
    	    @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
    		Model model) {
		
		// 검색어가 빈 문자열일 경우 "전체 상품"으로 설정
	    if (keyword.isEmpty()) {
	        keyword = "전체 상품";
	    }
	    
		// 기본 정렬 설정
	    if (sort == null) {
	        sort = "createdAt"; // 기본값을 신상품으로 설정
	    }
	    
        List<ClothDetail> clothList = clothBO.getSearchedCloth(keyword, sort);
        
        // 전체 아이템 수 모델에 추가
        int totalItems = clothList.size();
        model.addAttribute("totalItems", totalItems); // 전체 아이템 수를 모델에 추가
        
        // 페이징 처리
	    int fromIndex = Math.min((page - 1) * size, totalItems);
	    int toIndex = Math.min(fromIndex + size, totalItems);
	    List<ClothDetail> paginatedClothList = clothList.subList(fromIndex, toIndex);
	    
        model.addAttribute("clothList", paginatedClothList);
        model.addAttribute("keyword", keyword);
        model.addAttribute("selectedSort", sort); // 현재 선택된 정렬 기준 저장
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", (int) Math.ceil((double) totalItems / size));
        model.addAttribute("viewName", "main/searchCloth");
        return "template/mainLayout";
    }

}