package com.project.manager.bo;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.basket.entity.BasketEntity;
import com.project.basket.repository.BasketRepository;
import com.project.cloth.entity.ClothEntity;
import com.project.cloth.entity.SizeEntity;
import com.project.cloth.repository.ClothRepository;
import com.project.cloth.repository.SizeRepository;
import com.project.manager.entity.ManagerEntity;
import com.project.manager.entity.Order;
import com.project.manager.repository.ManagerRepository;
import com.project.order.entity.OrderEntity;
import com.project.order.repository.OrderRepository;
import com.project.user.entity.UserEntity;
import com.project.user.repository.UserRepository;

@Service
public class ManagerBO {
	
	@Autowired
	private BasketRepository basketRepository;
	
	@Autowired
	private ClothRepository clothRepository;
	
	@Autowired
	private SizeRepository sizeRepository;
	
	@Autowired
	private OrderRepository orderRepository;
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private ManagerRepository managerRepository;
	
	//매니저 회원가입
	public ManagerEntity addManager(String loginId
								, String password
								, String name) {
		ManagerEntity manager = ManagerEntity.builder()
									.loginId(loginId)
									.password(password)
									.managerName(name)
									.build();
		
		return managerRepository.save(manager);
	}
	
	// 로그인 기능
	public ManagerEntity getManager(String loginId, String loginPw) {
		return managerRepository.findByLoginIdAndPassword(loginId, loginPw);
	}
	
	// 아이디 중복 확인
	public boolean isDuplicateId(String loginId) {
		int count = managerRepository.countByLoginId(loginId);
		
		if(count != 0) { // 아이디 중복 아님
			return true;
		} else {
			return false;
		}
	}

	// 상품 리스트 만들기 
	public List<Map<String, Object>> getProductList() {
		
		// 상품 리스트 생성
	    List<Map<String, Object>> productList = new ArrayList<>();
	    
	    // 데이터베이스에서 모든 의류 목록을 가져옴
	    List<ClothEntity> clothEntities = clothRepository.findAll();
	    
	    for (ClothEntity cloth : clothEntities) {
	        Optional<SizeEntity> optionalSize = sizeRepository.findByClothId(cloth.getId());
	        SizeEntity size = optionalSize.orElse(null);
	        
	        int clothCount = 0; // 상품 재고 초기화
	        
	        // cloth의 updatedAt을 Date로 초기화
	        Date latestUpdatedAt = cloth.getUpdatedAt();
	        
	        if (size != null) {
	        	// 모든 사이즈 값을 더해서 clothCount 계산
	            clothCount = size.getSize_XS() + size.getSize_S() + size.getSize_M() + size.getSize_L() + 
	                         size.getSize_XL() + size.getSize_2XL() + size.getSize_26() + size.getSize_28() + 
	                         size.getSize_30() + size.getSize_32() + size.getSize_34() + size.getSize_36() + 
	                         size.getSize_38() + size.getSize_40() + size.getSize_240() + size.getSize_245() + 
	                         size.getSize_250() + size.getSize_255() + size.getSize_260() + size.getSize_265() + 
	                         size.getSize_270() + size.getSize_275() + size.getSize_280() + size.getSize_285() + 
	                         size.getSize_290() + size.getSize_295() + size.getSize_300() + size.getSize_free();
	            
	            // 사이즈의 updatedAt이 있을 경우 최신 날짜 비교
	            if (size.getUpdatedAt() != null) {
	                // size의 updatedAt과 비교
	                if (size.getUpdatedAt().after(latestUpdatedAt)) {
	                    latestUpdatedAt = size.getUpdatedAt(); // size의 updatedAt이 더 최신이면 업데이트
	                }
	            }
	            
	            // 주문 상세 정보를 담을 map 생성
	            Map<String, Object> productMap = new HashMap<>();
	            productMap.put("clothId", cloth.getId());
	            productMap.put("createdAt", cloth.getCreatedAt());
	            productMap.put("clothName", cloth.getClothName());
	            productMap.put("clothPrice", cloth.getClothPrice());
	            productMap.put("clothCategory", cloth.getClothCategory());
	            productMap.put("clothCount", clothCount);
	            productMap.put("updatedAt", latestUpdatedAt); // 최신 업데이트 날짜 저장
	            
	            // 상품 정보를 리스트에 추가
	            productList.add(productMap);
	        }
	    }
	    
	    // 상품 리스트를 역순으로 정렬
	    Collections.reverse(productList);
	    
	    // 최종적으로 상품 리스트 반환
	    return productList;
	}
	    
	// 주문 리스트 만들기 
	public List<Map<String, Object>> getOrderList() {
	    // 데이터베이스에서 모든 주문을 가져옴
	    List<OrderEntity> orderEntities = orderRepository.findAll();

	    // 인덱스를 부여할 변수 초기화
	    int orderIndex = 1;

	    // 주문번호로 그룹화
	    Map<String, Map<String, Object>> groupedOrders = new LinkedHashMap<>();

	    for (OrderEntity order : orderEntities) {
	        Optional<UserEntity> optionalUser = userRepository.findById(order.getUserId());
	        UserEntity user = optionalUser.orElse(null);

	        Optional<BasketEntity> optionalBasket = basketRepository.findById(order.getBasketId());
	        BasketEntity basket = optionalBasket.orElse(null);

	        if (user != null && basket != null) {
	            // 주문 상세 정보를 담을 map 생성
	            Map<String, Object> orderMap = new HashMap<>();
	            orderMap.put("imp_uid", order.getImp_uid());
	            orderMap.put("orderNumber", order.getOrderNumber());
	            orderMap.put("createdAt", order.getCreatedAt());
	            orderMap.put("userLoginId", user.getLoginId());
	            orderMap.put("recipientName", order.getRecipientName());
	            orderMap.put("recipientPhone", order.getRecipientPhone());
	            orderMap.put("recipientAddress", order.getRecipientAddress());
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
	public List<Order> getOrderDetail(List<Integer> ids) {
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
		
	// 주문 배송 상태 업데이트 및 취소 처리
	public BasketEntity updateOrderStatus(int id, String status) throws NoSuchFieldException, IllegalAccessException {
	    Optional<BasketEntity> optionalBasket = basketRepository.findById(id);
	    BasketEntity basket = optionalBasket.orElse(null);

	    if (basket != null) {
	        // 주문 취소인 경우 재고와 판매량 복구
	        if ("주문 취소 완료".equals(status)) {
	            // 1. BasketEntity의 clothName으로 clothId 조회
	            ClothEntity cloth = clothRepository.findByClothName(basket.getClothName());
	            if (cloth != null) {
	                // 2. clothId로 SizeEntity 조회
	                Optional<SizeEntity> optionalSize = sizeRepository.findByClothId(cloth.getId());
	                SizeEntity sizeEntity = optionalSize.orElse(null);

	                if (sizeEntity != null) {
	                    // 3. basket.clothSize에 맞는 SizeEntity의 필드 이름 동적 생성
	                    String sizeFieldName = "size_" + basket.getClothSize(); // 예: "size_XS"

	                    // 4. 리플렉션을 통해 해당 필드 값 조회
	                    Field sizeField = SizeEntity.class.getDeclaredField(sizeFieldName);
	                    sizeField.setAccessible(true);  // private 필드 접근 허용

	                    // 5. sizeField의 값 복구 (주문된 수량만큼 재고 증가)
	                    int availableSizeCount = (int) sizeField.get(sizeEntity);
	                    sizeField.set(sizeEntity, availableSizeCount + basket.getClothCount());
	                    sizeRepository.save(sizeEntity);  // 변경된 재고 저장

	                    // 6. clothTotalSales 감소
	                    cloth.setClothTotalSales(cloth.getClothTotalSales() - basket.getClothCount());
	                    clothRepository.save(cloth);  // 변경된 누적 판매량 저장
	                }
	            }
	        }

	        // 주문 상태 업데이트
	        basket = basket.toBuilder()
	                    .clothStatus(status)
	                    .build();
	        basket = basketRepository.save(basket);
	    }
	    return basket;
	}
	
}