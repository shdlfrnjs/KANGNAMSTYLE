package com.project.cloth.entity;

import lombok.Builder;
import lombok.Getter;

@Builder
@Getter
public class ClothDetail {
	private int id;
	private int clothId; // primary key
	private String clothName; // 상품명
	private String clothCategory;
	private int clothRegularPrice; // 상품 정가
	private int clothPrice; // 상품 가격
	private String clothImagePath;
}
