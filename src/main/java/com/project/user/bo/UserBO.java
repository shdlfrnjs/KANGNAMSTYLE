package com.project.user.bo;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.basket.entity.BasketEntity;
import com.project.basket.repository.BasketRepository;
import com.project.cloth.entity.ClothDetail;
import com.project.cloth.entity.ClothEntity;
import com.project.cloth.repository.ClothRepository;
import com.project.common.EncryptUtils;
import com.project.order.entity.OrderEntity;
import com.project.order.repository.OrderRepository;
import com.project.user.entity.LikesEntity;
import com.project.user.entity.Order;
import com.project.user.entity.UserEntity;
import com.project.user.repository.LikesRepository;
import com.project.user.repository.UserRepository;

@Service
public class UserBO {
	
	@Autowired
	private BasketRepository basketRepository;

	@Autowired
	private ClothRepository clothRepository;
	
	@Autowired
	private OrderRepository orderRepository;
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
    private LikesRepository likesRepository;
	
	// input: loginId
	// output: UserEntity or null
	public UserEntity getUserEntityByLoginId(String loginId) {
		return userRepository.findByLoginId(loginId);
	}
	
	// input: loginId, password
	// output: UserEntity or null
	public UserEntity getUserEntityByLoginIdPassword(String loginId, String password) {
		return userRepository.findByLoginIdAndPassword(loginId, password);
	}
	
	// input: 파라미터 6개
	// output: Integer(user pk)
	public Integer addUser(String loginId, String password, String name, String email, String address, String phoneNumber) {
		UserEntity user = userRepository.save(UserEntity.builder()
								.loginId(loginId)
								.password(password)
								.name(name)
								.email(email)
								.address(address)
								.phoneNumber(phoneNumber)
								.build());
		
		return user == null ? null : user.getId();
	}
	
	public UserEntity updateUserInfo(String loginId, String password, String name, String email, String address, String phoneNumber) {
	    // 비밀번호 해싱
	    String hashedPassword = EncryptUtils.md5(password);

	    // 데이터베이스에서 사용자 정보 가져오기
	    UserEntity user = userRepository.findByLoginId(loginId);
	    
	    // 비밀번호 확인
	    if (user == null || !user.getPassword().equals(hashedPassword)) {
	        // 비밀번호가 일치하지 않거나 사용자가 존재하지 않음
	        return null;
	    }

	    // 사용자 정보 수정
	    user.setName(name);
	    user.setEmail(email);
	    user.setAddress(address);
	    user.setPhoneNumber(phoneNumber);
	    
	    user = userRepository.save(user);
	    
	    // 변경 사항 저장
	    return user;
	}
	
	public UserEntity changePassword(String loginId, String currentPassword, String newPassword) {
	    // 현재 비밀번호 해싱
	    String hashedCurrentPassword = EncryptUtils.md5(currentPassword);

	    // 데이터베이스에서 사용자 정보 가져오기
	    UserEntity user = userRepository.findByLoginId(loginId);
	    
	    // 비밀번호 확인
	    if (user == null || !user.getPassword().equals(hashedCurrentPassword)) {
	        // 비밀번호가 일치하지 않거나 사용자가 존재하지 않음
	        return null;
	    }

	    // 새로운 비밀번호 해싱
	    String hashedNewPassword = EncryptUtils.md5(newPassword);
	    
	    // 비밀번호 변경
	    user.setPassword(hashedNewPassword);
	    
	    user = userRepository.save(user);

	    return user;
	}
	
	public List<Map<String, Object>> getUserOrderList(int userId) {
	    // 데이터베이스에서 해당 사용자 ID의 주문을 가져옴
	    List<OrderEntity> orderEntities = orderRepository.findByUserId(userId);

	    // 인덱스를 부여할 변수 초기화
	    int orderIndex = 1;

	    // 주문번호로 그룹화
	    Map<String, Map<String, Object>> groupedOrders = new LinkedHashMap<>();

	    for (OrderEntity order : orderEntities) {
	        Optional<BasketEntity> optionalBasket = basketRepository.findById(order.getBasketId());
	        BasketEntity basket = optionalBasket.orElse(null);

	        if (basket != null) {
	            // 주문 상세 정보를 담을 map 생성
	            Map<String, Object> orderMap = new HashMap<>();
	            orderMap.put("orderNumber", order.getOrderNumber());
	            orderMap.put("createdAt", order.getCreatedAt());
	            orderMap.put("clothStatus", basket.getClothStatus());

	            // 그룹화된 주문 목록에서 인덱스 부여
	            if (!groupedOrders.containsKey(order.getOrderNumber())) {
	                orderMap.put("orderIndex", orderIndex++); // 인덱스 부여
	                groupedOrders.put(order.getOrderNumber(), orderMap);
	            }
	        }
	    }

	    // 인덱스를 기준으로 역순으로 정렬된 리스트 생성
	    List<Map<String, Object>> formattedOrderList = new ArrayList<>(groupedOrders.values());
	    formattedOrderList.sort((o1, o2) -> Integer.compare((Integer) o2.get("orderIndex"), (Integer) o1.get("orderIndex")));

	    return formattedOrderList;
	}
	
	// 장바구니 ID로 주문내역 조회
	public List<Order> getUserOrderDetail(List<Integer> ids) {
	    List<Order> orderDetailList = new ArrayList<>();

	    for (int basketId : ids) {
	        // 장바구니 아이템 조회
	        BasketEntity order = basketRepository.findById(basketId).orElse(null);

	        if (order != null) {
	            Order orderDetail = Order.builder()
	                    .clothName(order.getClothName())
	                    .clothSize(order.getClothSize())
	                    .clothCount(order.getClothCount())
	                    .build();

	            orderDetailList.add(orderDetail);
	        }
	    }

	    return orderDetailList;
	}
	
	// 찜한 상품 저장
	public LikesEntity addLike(int userId, int clothId) {
		
		// 기존에 같은 데이터가 있는지 확인
        Optional<LikesEntity> existingLike = likesRepository.findByUserIdAndClothId(userId, clothId);
        
        // 이미 존재하는 경우 null 반환
        if (existingLike.isPresent()) {
            return null; // 데이터가 이미 존재함
        }
        
		// 새로운 LikesEntity 생성
        LikesEntity like = new LikesEntity();
        like.setUserId(userId);
        like.setClothId(clothId);
        
        // 엔티티 저장
        return likesRepository.save(like);
        
	}
	
	// 찜한 상품 삭제
	public boolean deleteLike(int userId, int clothId) {
	    // 기존에 데이터가 있는지 확인
	    Optional<LikesEntity> existingLike = likesRepository.findByUserIdAndClothId(userId, clothId);

	    // 데이터가 존재하는 경우 삭제
	    if (existingLike.isPresent()) {
	        likesRepository.delete(existingLike.get());
	        return true;
	    }

	    return false; // 데이터가 존재하지 않음
	}
	
	// 사용자가 찜한 상품 목록 가져오기
    public List<ClothDetail> getLikedClothes(int userId) {
        // LikesEntity에서 사용자가 찜한 clothId 목록 조회
        List<LikesEntity> likesList = likesRepository.findByUserId(userId);
        
        // 역순으로 정렬
        Collections.reverse(likesList);
        
        List<ClothDetail> clothDetailList = new ArrayList<>();
        
        // clothId로 ClothEntity를 조회하여 ClothDetail로 변환
        for (LikesEntity like : likesList) {
            ClothEntity cloth = clothRepository.findById(like.getClothId())
                               .orElseThrow(() -> new RuntimeException("Cloth not found"));

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
    
	// 주문 취소
	public BasketEntity cancelOrder(int id) {
	    Optional<BasketEntity> optionalBasket = basketRepository.findById(id);
	    BasketEntity basket = optionalBasket.orElse(null);
	    
	    if (basket != null) {
	        basket = basket.toBuilder()
	                       .clothStatus("주문 취소") // 상태를 주문 취소로 변경
	                       .build();
	        basket = basketRepository.save(basket);
	    }
	    return basket;
	}
	
}