package com.project.cloth.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project.cloth.entity.ClothEntity;

public interface ClothRepository extends JpaRepository<ClothEntity,Integer> {
	
	public List<ClothEntity> findAll();
	
	public Optional<ClothEntity> findById(int id);

	public ClothEntity findByClothName(String clothName);
	
	public List<ClothEntity> findByClothCategory(String clothCategory);
	
	public List<ClothEntity> findByClothSubCategory(String clothSubCategory);
	
    public List<ClothEntity> findByClothCategoryAndClothSubCategory(String clothCategory, String clothSubCategory);

    // 검색 메소드 추가
    public List<ClothEntity> findByClothNameContainingIgnoreCase(String keyword);
    
    public List<ClothEntity> findByClothInfoContainingIgnoreCase(String keyword);
}
