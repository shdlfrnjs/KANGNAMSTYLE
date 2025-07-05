package com.project.weather.entity;

import java.time.LocalDate;
import java.util.Date;

import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Builder(toBuilder = true)
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Table(name = "weather")
@Entity
public class WeatherEntity {

		@Id
		@Column(name = "date")
		private LocalDate date;
	
		@Column(name = "icon")
		private String icon;
	
		@Column(name = "weather")
		private String weather;
	
		@Column(name = "temperature")
		private Double temperature;
	
		@UpdateTimestamp
		@Column(name = "createdAt", updatable = false)
		private Date createdAt;
	
		@UpdateTimestamp
		@Column(name = "updatedAt")
		private Date updatedAt;

}