package com.project.qna.entity;

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

@Builder(toBuilder = true)
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Table(name = "qna")
@Entity
public class QnaEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name = "userId")
	private int userId;

	@Column(name = "title")
	private String title;
	
	@Column(name = "writer")
	private String writer;

	@Column(name = "content")
	private String content;

	@Column(name = "status")
	private String status;

	@Column(name = "answer")
	private String answer;

	@Column(name = "answeredAt")
	private Date answeredAt;

	@UpdateTimestamp
	@Column(name = "createdAt", updatable = false)
	private Date createdAt;

	@UpdateTimestamp
	@Column(name = "updatedAt")
	private Date updatedAt;
	
}
