package com.project.qna.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project.qna.entity.QnaEntity;

public interface QnaRepository extends JpaRepository<QnaEntity, Integer> {
	
	// 제목으로 검색
    List<QnaEntity> findByTitleContaining(String keyword);

    // 작성자로 검색
    List<QnaEntity> findByWriterContaining(String keyword);

    // 내용으로 검색
    List<QnaEntity> findByContentContaining(String keyword);
    
}