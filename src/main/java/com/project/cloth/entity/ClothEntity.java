package com.project.cloth.entity;

import java.util.Date;

import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Builder(toBuilder=true)
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Table(name="clothes")
@Entity
public class ClothEntity {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	@Column(name="clothImagePath")
	private String clothImagePath;
	
	@Column(name="clothName")
	private String clothName;
	
	@Column(name="clothRegularPrice")
	private int clothRegularPrice;
	
	@Column(name="clothPrice")
	private int clothPrice;
	
	@Column(name="clothCategory")
	private String clothCategory;
	
	@Column(name="clothSubCategory")
	private String clothSubCategory;
	
	@Column(name="clothStyle")
	private String clothStyle;
	
	@Column(name="clothSeason")
	private String clothSeason;
	
	@Column(name="clothWeather")
	private String clothWeather;
	
	@Column(name="clothColor")
	private String clothColor;
	
	@Column(name="clothLightness")
	private String clothLightness;
	
	@Column(name="clothInfo")
	private String clothInfo;
	
	@Column(name="clothTotalSales")
	private int clothTotalSales;
	
	@UpdateTimestamp
	@Column(name="createdAt", updatable=false)
	private Date createdAt;
	
	@UpdateTimestamp
	@Column(name="updatedAt")
	private Date updatedAt;
}
