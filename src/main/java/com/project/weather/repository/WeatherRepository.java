package com.project.weather.repository;

import java.time.LocalDate;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project.weather.entity.WeatherEntity;

public interface WeatherRepository extends JpaRepository<WeatherEntity, LocalDate> {
	
	// 오늘 날짜에 맞는 날씨 데이터를 조회하는 메서드
    public WeatherEntity findByDate(LocalDate date);
    
}
