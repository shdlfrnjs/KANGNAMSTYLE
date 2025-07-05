package com.project.manager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.cloth.entity.ClothEntity;
import com.project.cloth.entity.SizeEntity;
import com.project.cloth.repository.ClothRepository;
import com.project.cloth.repository.SizeRepository;
import com.project.manager.bo.ManagerBO;
import com.project.manager.entity.Order;
import com.project.order.repository.OrderRepository;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ManagerController {

	@Autowired
	private ManagerBO managerBO;
	
	@Autowired
	private ClothRepository clothRepository;
	
	@Autowired
	private SizeRepository sizeRepository;
	
	@Autowired
	private OrderRepository orderRepository;
	
	// 매니저 회원가입
	@GetMapping("/admin/join")
	public String managerJoin() {
		return "manager/managerJoin";
	}

	@GetMapping("/admin/login")
	public String managerLogin() {
		return "manager/managerLogin";
	}
	
	@GetMapping("/admin-main-view")
	public String AdminMainPage(Model model) {
		model.addAttribute("viewName", "manager/main");
		
		return "template/mainLayout";
	}

	// 관리자 로그아웃
	@GetMapping("/admin/logout")
	public String logout(HttpServletRequest request) {
		// 세션에 저장된 관리자 정보 제거

		HttpSession session = request.getSession();

		session.removeAttribute("managerId");
		session.removeAttribute("managerName");

		return "redirect:/main-view";
	}

	// 전체 상품 목록 보여주기
	@GetMapping("/admin/show/productList")
	public String showProductList(
	        @RequestParam(value = "page", defaultValue = "1") int page,
	        @RequestParam(value = "size", defaultValue = "10") int size,
	        Model model) {

	    // 전체 상품 리스트 가져오기
	    List<Map<String, Object>> productList = managerBO.getProductList();

	    // 총 페이지 수 계산
	    int totalItems = productList.size();
	    int totalPages = (int) Math.ceil((double) totalItems / size);

	    // 페이지 인덱스 설정
	    int fromIndex = Math.min((page - 1) * size, totalItems);
	    int toIndex = Math.min(fromIndex + size, totalItems);

	    // 해당 페이지의 상품 리스트만 서브리스트로 추출
	    List<Map<String, Object>> paginatedList = productList.subList(fromIndex, toIndex);

	    // 모델에 페이징된 리스트와 페이지 정보를 추가
	    model.addAttribute("productList", paginatedList);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", totalPages);

	    return "manager/productList";
	}
    
	// 새로운 상품 추가하기
	@GetMapping("/admin/add/product")
	public String addProduct() {
		return "manager/addProduct";
	}
	
	// 상품 정보 수정 페이지 반환
	@GetMapping("/admin/modify/product")
	public String modifyProduct(@RequestParam("clothId") int clothId, Model model) {
	    // clothId로 ClothEntity 조회
	    ClothEntity clothEntity = clothRepository.findById(clothId).orElse(null);
	    
	    // clothId로 SizeEntity 조회
	    SizeEntity sizeEntity = sizeRepository.findByClothId(clothId).orElse(null);
	    
	    // 모델에 데이터 추가
	    model.addAttribute("cloth", clothEntity);
	    model.addAttribute("size", sizeEntity);
	    
	    // 수정 페이지로 반환
	    return "manager/modifyProduct";  // 수정할 상품 페이지의 뷰 이름
	}
	
	// 전체 주문 목록 보여주기
	@GetMapping("/admin/show/orderList")
	public String showOrderList(
			@RequestParam(value = "page", defaultValue = "1") int page,
	        @RequestParam(value = "size", defaultValue = "10") int size,
	        Model model) {
		
	    // 전체 주문 목록을 가져옴
	    List<Map<String, Object>> orderList = managerBO.getOrderList();

	    // 주문번호 별로 주문 내역을 추가하기 위해 주문번호와 주문내역 맵 생성
	    Map<String, List<Order>> orderDetailsMap = new HashMap<>();

	    for (Map<String, Object> orderMap : orderList) {
	        String orderNumber = (String) orderMap.get("orderNumber");
	        List<Integer> basketIds = orderRepository.findBasketIdsByOrderNumber(orderNumber);
	        
	        List<Order> orderDetails = managerBO.getOrderDetail(basketIds);
	        orderDetailsMap.put(orderNumber, orderDetails);
	    }

	    // 주문 내역을 문자열로 변환
	    for (Map<String, Object> orderMap : orderList) {
	        String orderNumber = (String) orderMap.get("orderNumber");
	        List<Order> orderDetails = orderDetailsMap.get(orderNumber);
	        
	        StringBuilder orderDetailsString = new StringBuilder();
	        if (orderDetails != null) {
				for (Order order : orderDetails) {
					orderDetailsString.append(String.format("%s (사이즈: %s, 수량: %s)<br/>",
							order.getClothName(), order.getClothSize(), order.getClothCount()));
				}
	        }
	        
	        orderMap.put("orderDetailsString", orderDetailsString.toString());
	    }

	    // 페이징 처리
	    int totalItems = orderList.size();
	    int fromIndex = Math.min((page - 1) * size, totalItems);
	    int toIndex = Math.min(fromIndex + size, totalItems);
	    List<Map<String, Object>> paginatedOrderList = orderList.subList(fromIndex, toIndex);

	    model.addAttribute("orderList", paginatedOrderList);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", (int) Math.ceil((double) totalItems / size));

	    return "manager/orderList";
	}

}