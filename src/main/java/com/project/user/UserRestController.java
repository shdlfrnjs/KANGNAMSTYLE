package com.project.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.basket.entity.BasketEntity;
import com.project.common.EncryptUtils;
import com.project.order.entity.OrderEntity;
import com.project.order.repository.OrderRepository;
import com.project.user.bo.UserBO;
import com.project.user.entity.LikesEntity;
import com.project.user.entity.UserEntity;
import com.project.user.repository.UserRepository;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RequestMapping("/user")
@RestController
public class UserRestController {

	@Autowired
	private UserBO userBO;
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private OrderRepository orderRepository;
	
	/**
	 * 아이디 중복확인 API
	 * @param loginId
	 * @return
	 */
	
	@RequestMapping("/is-duplicated-id")
	public Map<String, Object> isDuplicatedId(
			@RequestParam("loginId") String loginId) {
		
		// 중복 체크 - db select
		UserEntity user = userBO.getUserEntityByLoginId(loginId);
		
		Map<String, Object> result = new HashMap<>();
		if (user != null) { // 중복
			result.put("code", 200);
			result.put("is_duplicated_id", true);
		} else { // 사용 가능
			result.put("code", 200);
			result.put("is_duplicated_id", false);
		}
		return result;
	}
	
	/**
	 * 회원가입 API
	 * @param loginId
	 * @param password
	 * @param name
	 * @param email
	 * @param address
	 * @param phoneNumber
	 * @return
	 */
	
	@PostMapping("/sign-up")
	public Map<String, Object> signUp(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			@RequestParam("name") String name,
			@RequestParam("email") String email,
			@RequestParam("address") String address,
			@RequestParam("phoneNumber") String phoneNumber) {
		
		// md5 알고리즘
		// 암호 hashing(복호화 X)
		// aaaa => 74b8733745420d4d33f80c4663dc5e5
		// aaaa => 74b8733745420d4d33f80c4663dc5e5
		String hashedPassword = EncryptUtils.md5(password);
		
		// insert db
		Integer userId = userBO.addUser(loginId, hashedPassword, name, email, address, phoneNumber);
		
		// 응답값
		Map<String, Object> result = new HashMap<>();
		if (userId != null) {
			result.put("code", 200);
			result.put("result", "성공");
		} else {
			result.put("code", 500);
			result.put("error_message", "회원가입에 실패했습니다.");
		}
		return result;
	}
	
	@PostMapping("/sign-in")
	public Map<String, Object> signIn(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			HttpServletRequest request) {
		
		// 비밀번호 md5 hashing
		String hashedPassword = EncryptUtils.md5(password);
		
		// db 조회(loginId, hashing 비번)
		UserEntity user = userBO.getUserEntityByLoginIdPassword(loginId, hashedPassword);
		
		// 응답값
		Map<String, Object> result = new HashMap<>();
		if (user != null) { // 성공
			// 로그인 처리 => 로그인 정보를 세션에 담는다.(사용자 마다)
			HttpSession session = request.getSession();
			session.setAttribute("userId", user.getId());
			session.setAttribute("userLoginId", user.getLoginId());
			session.setAttribute("userName", user.getName());
			session.setAttribute("userEmail", user.getEmail());  // 이메일 저장
	        session.setAttribute("userPhone", user.getPhoneNumber());  // 전화번호 저장
	        session.setAttribute("userAddress", user.getAddress());  // 주소 저장
			
			result.put("code", 200);
			result.put("result", "성공");
		} else { // 로그인 불가
			result.put("code", 300);
			result.put("error_message", "존재하지 않는 사용자입니다.");
		}
		return result;
	}
	
	@PutMapping("/update/userInfo")
	public Map<String, String> updateUserInfo(
	        @RequestParam("loginId") String loginId,
	        @RequestParam("password") String password,
	        @RequestParam("name") String name,
	        @RequestParam("email") String email,
	        @RequestParam("address") String address,
	        @RequestParam("phoneNumber") String phoneNumber) {
	    
	    // 사용자 프로필 업데이트를 위한 서비스 메소드 호출
	    UserEntity user = userBO.updateUserInfo(loginId, password, name, email, address, phoneNumber);
	    
	    Map<String, String> resultMap = new HashMap<>();

		if (user != null) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
			resultMap.put("error_message", "비밀번호가 일치하지 않습니다."); // 에러 메시지 추가
		}

		return resultMap;
	}
	
	@PutMapping("/change/password")
	public Map<String, String> changePassword(
			@RequestParam("loginId") String loginId,
	        @RequestParam("currentPassword") String currentPassword,
	        @RequestParam("newPassword") String newPassword) {

		// 사용자 정보를 업데이트하기 위한 서비스 메소드 호출
	    UserEntity user = userBO.changePassword(loginId, currentPassword, newPassword);
	    
	    Map<String, String> resultMap = new HashMap<>();
	    
	    if (user != null) {
	        resultMap.put("result", "success");
	    } else {
	        resultMap.put("result", "fail");
	        resultMap.put("error_message", "비밀번호가 일치하지 않습니다."); // 추가적인 에러 메시지
	    }

	    return resultMap;
	}
	
	@PostMapping("/add/like")
	public Map<String, String> addLike(@RequestParam("clothId") int clothId, HttpSession session) {
		
		// 세션에서 현재 로그인한 사용자의 ID 가져오기
	    int userId = (Integer) session.getAttribute("userId");

        // Like 추가하기
 		LikesEntity like = userBO.addLike(userId, clothId);
 		
        Map<String, String> resultMap = new HashMap<>();

        if (like != null) {
            resultMap.put("result", "success");
        } else {
            resultMap.put("result", "already_exists"); // 이미 존재하는 경우
        }

		return resultMap;
    }
	
	@PostMapping("/delete/like")
	public Map<String, String> removeLike(@RequestParam("clothId") int clothId, HttpSession session) {
	    // 세션에서 현재 로그인한 사용자의 ID 가져오기
	    int userId = (Integer) session.getAttribute("userId");

	    // Like 삭제하기
	    boolean isDeleted = userBO.deleteLike(userId, clothId);

	    Map<String, String> resultMap = new HashMap<>();

	    if (isDeleted) {
	        resultMap.put("result", "success");
	    } else {
	        resultMap.put("result", "not_found"); // 해당 항목이 존재하지 않는 경우
	    }

	    return resultMap;
	}
	
	@PutMapping("/cancel/order")
	public Map<String, String> cancelOrder(@RequestParam("orderNumber") String orderNumber) {
	    // OrderEntity에서 주어진 orderNumber로 주문을 찾기
	    List<OrderEntity> orders = orderRepository.findByOrderNumber(orderNumber);
	    
	    boolean success = true; // 성공 여부를 기록할 변수

	    // 각 주문의 basketId를 이용해 BasketEntity를 업데이트
	    for (OrderEntity order : orders) {
	        BasketEntity basket = userBO.cancelOrder(order.getBasketId());
	        if (basket == null) {
	            success = false; // 업데이트 실패 시 실패로 설정
	        }
	    }
	    
	    Map<String, String> resultMap = new HashMap<>();
	    resultMap.put("result", success ? "success" : "fail");
	    return resultMap;
	}
	
}