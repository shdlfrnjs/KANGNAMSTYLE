package com.project.user.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project.user.entity.LikesEntity;

public interface LikesRepository extends JpaRepository<LikesEntity, Integer> {

	List<LikesEntity> findByUserId(int userId);
	
	Optional<LikesEntity> findByUserIdAndClothId(int userId, int clothId);
	
}
