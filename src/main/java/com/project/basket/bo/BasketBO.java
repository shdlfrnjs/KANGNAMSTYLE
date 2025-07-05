package com.project.basket.bo;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.basket.entity.BasketEntity;
import com.project.basket.repository.BasketRepository;
import com.project.cloth.entity.ClothEntity;
import com.project.cloth.entity.SizeEntity;
import com.project.cloth.repository.ClothRepository;
import com.project.cloth.repository.SizeRepository;

@Service
public class BasketBO {
	@Autowired
	private BasketRepository basketRepository;

	@Autowired
	private ClothRepository clothRepository;
	
	@Autowired
	private SizeRepository sizeRepository;

	// 장바구니 담는 기능
	public BasketEntity addCart(int userId, String clothName, String clothSize, int clothCount) {

		Optional<BasketEntity> optionalBasket = basketRepository
				.findByUserIdAndClothNameAndClothSizeAndClothStatus(userId, clothName, clothSize, "장바구니");
		BasketEntity basket = optionalBasket.orElse(null);

		if (basket != null) {
			basket = basket.toBuilder().clothCount(clothCount + basket.getClothCount()).build();
			return basketRepository.save(basket);

		} else {

			basket = BasketEntity.builder().userId(userId).clothName(clothName).clothSize(clothSize)
					.clothCount(clothCount).clothStatus("장바구니").build();
			return basketRepository.save(basket);
		}
	}

	// 장바구니 상품수량 변경
	public BasketEntity updateBasket(int id, int clothCount) {
	    Optional<BasketEntity> optionalBasket = basketRepository.findById(id);
	    BasketEntity basket = optionalBasket.orElse(null);

	    // 수량이 1 미만인 경우 null 반환
	    if (clothCount < 1) {
	        return null;
	    }

	    if (basket != null) {
	        // 수량 업데이트
	        basket.setClothCount(clothCount);
	        basketRepository.save(basket);
	    }
	    return basket;
	}
	
	// 장바구니 삭제
	public BasketEntity deleteBasket(int id) {

		Optional<BasketEntity> optionalBasket = basketRepository.findById(id);
		BasketEntity basket = optionalBasket.orElse(null);

		if (basket != null) {
			basketRepository.delete(basket);
		}
		return basket;
	}

	// 사용자별 장바구니 조회 기능
	public List<BasketDetail> getBasketList(int userId) {

		List<BasketEntity> basketList = basketRepository.findByUserIdOrderByIdDesc(userId);

		List<BasketDetail> basketDetailList = new ArrayList<>();

		for (BasketEntity basket : basketList) {

			ClothEntity cloth = clothRepository.findByClothName(basket.getClothName());

			BasketDetail basketDetail = BasketDetail.builder()
	                .id(basket.getId())
	                .clothImagePath(cloth.getClothImagePath())
	                .clothName(basket.getClothName())
	                .clothColor(cloth.getClothColor())
	                .clothSize(basket.getClothSize())
	                .clothCount(basket.getClothCount())
	                .clothPrice(cloth.getClothPrice())
	                .clothStatus(basket.getClothStatus())
	                .build();
			
			basketDetailList.add(basketDetail);
		
		}
		
		return basketDetailList;
		
	}

	// 주문 완료 처리 메소드 (상품 재고 검사 및 수정 포함)
	public List<BasketEntity> orderProductsComplete(List<Integer> ids) throws NoSuchFieldException, IllegalAccessException {

	    List<BasketEntity> updatedBaskets = new ArrayList<>();

	    for (int basketId : ids) {
	        // 1. BasketEntity 조회
	        Optional<BasketEntity> optionalBasket = basketRepository.findById(basketId);
	        BasketEntity basket = optionalBasket.orElse(null);

	        if (basket != null) {
	            // 2. BasketEntity의 clothName으로 clothId 조회
	            ClothEntity cloth = clothRepository.findByClothName(basket.getClothName());
	            if (cloth == null) {
	                continue;  // clothId가 없을 경우 넘어감
	            }

	            // 3. clothId로 SizeEntity 조회
	            Optional<SizeEntity> optionalSize = sizeRepository.findByClothId(cloth.getId());
	            SizeEntity sizeEntity = optionalSize.orElse(null);

	            if (sizeEntity != null) {
	                // 4. basket.clothSize에 맞는 SizeEntity의 필드 이름 동적 생성
	                String sizeFieldName = "size_" + basket.getClothSize(); // 예: "size_XS"

	                // 5. 리플렉션을 통해 해당 필드 값 조회
	                Field sizeField = SizeEntity.class.getDeclaredField(sizeFieldName);
	                sizeField.setAccessible(true);  // private 필드 접근 허용

	                // 6. sizeField의 값이 basket의 clothCount보다 작으면 아무것도 반환하지 않음
	                int availableSizeCount = (int) sizeField.get(sizeEntity);
	                if (basket.getClothCount() > availableSizeCount) {
	                    return null;  // 조건이 맞지 않을 경우 메소드 종료
	                }

	                // 7. 조건을 만족하면 SizeEntity에서 수량 차감
	                sizeField.set(sizeEntity, availableSizeCount - basket.getClothCount());
	                sizeRepository.save(sizeEntity);  // 변경된 재고 저장

	                // 8. clothTotalSales 업데이트
	                cloth.setClothTotalSales(cloth.getClothTotalSales() + basket.getClothCount());
	                clothRepository.save(cloth);  // 변경된 누적 판매량 저장

	                // 9. clothStatus 업데이트 후 저장
	                basket = basket.toBuilder().clothStatus("주문 완료").build();
	                BasketEntity updatedBasket = basketRepository.save(basket);
	                updatedBaskets.add(updatedBasket);
	            }
	        }
	    }
	    return updatedBaskets;
	}

}