package com.project.user.entity;

import lombok.Builder;
import lombok.Getter;

@Builder
@Getter
public class Order {
	private String clothName;
	private String clothSize;
	private int clothCount;
}
