package com.project.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.cloth.entity.ClothDetail;
import com.project.order.repository.OrderRepository;
import com.project.user.bo.UserBO;
import com.project.user.entity.Order;
import com.project.user.entity.UserEntity;
import com.project.user.repository.UserRepository;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/user")
@Controller
public class UserController {

	@Autowired
	private UserBO userBO;

	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private OrderRepository orderRepository;
	
	/**
	 * 회원가입 화면
	 * @param model
	 * @return
	 */
	@GetMapping("/sign-up-view")
	public String signUpView(Model model) {
		model.addAttribute("viewName", "user/signUp");
		return "template/layout";
	}
	
	/**
	 * 로그인 API
	 * @param model
	 * @return
	 */
	@GetMapping("/sign-in-view")
	public String signInView(Model model) {
		model.addAttribute("viewName", "user/signIn");
		return "template/layout";
	}
	
	/**
	 * 로그아웃
	 * @param session
	 * @return
	 */
	@RequestMapping("/sign-out")
	public String signOut(HttpSession session) {
		// 세션 내용을 모두 비운다.
		session.removeAttribute("userId");
		session.removeAttribute("userLoginId");
		session.removeAttribute("userName");
		session.removeAttribute("userEmail");
		session.removeAttribute("userPhone");
		session.removeAttribute("userAddress");
		
		// 메인 화면으로 이동
		return "redirect:/main-view";
	}
	
	@GetMapping("/myPage-view")
	public String myPageView(
			@RequestParam(value = "page", defaultValue = "1") int page,
	        @RequestParam(value = "size", defaultValue = "10") int size,
	        Model model, HttpSession session) {
		
	    // 세션에서 현재 로그인한 사용자의 ID 가져오기
	    Integer userId = (Integer) session.getAttribute("userId");
	    
	    // 로그인 안 되어 있으면 로그인 페이지로 리다이렉트
 		if (userId == null) {
 			return "redirect:/user/sign-in-view";
 		}
 		
 		// 사용자의 UserEntity를 가져옴
 	    UserEntity user = userRepository.findById(userId)
 	                        .orElseThrow(() -> new RuntimeException("User not found"));
 	    
	    if (userId != null) {
	        // 사용자의 주문 목록을 가져옴
	        List<Map<String, Object>> orderList = userBO.getUserOrderList(userId);

		    // 주문번호 별로 주문 내역을 추가하기 위해 주문번호와 주문내역 맵 생성
		    Map<String, List<Order>> orderDetailsMap = new HashMap<>();
		    
	        for (Map<String, Object> orderMap : orderList) {
		        String orderNumber = (String) orderMap.get("orderNumber");
		        List<Integer> basketIds = orderRepository.findBasketIdsByOrderNumber(orderNumber);
		        
		        List<Order> orderDetails = userBO.getUserOrderDetail(basketIds);
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
		    
		    // 사용자가 찜한 상품 목록을 가져옴
		    List<ClothDetail> likedList = userBO.getLikedClothes(userId);

		    model.addAttribute("orderList", paginatedOrderList);
		    model.addAttribute("likedList", likedList);
		    model.addAttribute("user", user);
		    model.addAttribute("currentPage", page);
		    model.addAttribute("totalPages", (int) Math.ceil((double) totalItems / size));
	    }

	    return "user/myPage";
	}
	
}