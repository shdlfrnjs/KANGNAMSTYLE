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
@Table(name="sizes")
@Entity
public class SizeEntity {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	@Column(name = "clothId")
	private int clothId;
	
	@Column(name = "size_XS")
	private int size_XS;

	@Column(name = "size_S")
	private int size_S;

	@Column(name = "size_M")
	private int size_M;

	@Column(name = "size_L")
	private int size_L;

	@Column(name = "size_XL")
	private int size_XL;

	@Column(name = "size_2XL")
	private int size_2XL;

	@Column(name = "size_26")
	private int size_26;

	@Column(name = "size_28")
	private int size_28;

	@Column(name = "size_30")
	private int size_30;

	@Column(name = "size_32")
	private int size_32;

	@Column(name = "size_34")
	private int size_34;

	@Column(name = "size_36")
	private int size_36;

	@Column(name = "size_38")
	private int size_38;

	@Column(name = "size_40")
	private int size_40;

	@Column(name = "size_240")
	private int size_240;

	@Column(name = "size_245")
	private int size_245;

	@Column(name = "size_250")
	private int size_250;

	@Column(name = "size_255")
	private int size_255;

	@Column(name = "size_260")
	private int size_260;

	@Column(name = "size_265")
	private int size_265;

	@Column(name = "size_270")
	private int size_270;

	@Column(name = "size_275")
	private int size_275;

	@Column(name = "size_280")
	private int size_280;

	@Column(name = "size_285")
	private int size_285;

	@Column(name = "size_290")
	private int size_290;

	@Column(name = "size_295")
	private int size_295;

	@Column(name = "size_300")
	private int size_300;

	@Column(name = "size_free")
	private int size_free;
	
	@UpdateTimestamp
	@Column(name="createdAt", updatable=false)
	private Date createdAt;
	
	@UpdateTimestamp
	@Column(name="updatedAt")
	private Date updatedAt;
}
