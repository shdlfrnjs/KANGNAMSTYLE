package com.project.cloth.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project.cloth.entity.SizeEntity;

public interface SizeRepository extends JpaRepository<SizeEntity,Integer> {
	
	public Optional<SizeEntity> findByClothId(int clothId);
	
}
