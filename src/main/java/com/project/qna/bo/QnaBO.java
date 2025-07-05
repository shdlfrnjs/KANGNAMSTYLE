package com.project.qna.bo;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.project.qna.entity.QnaEntity;
import com.project.qna.repository.QnaRepository;

@Service
public class QnaBO {

	@Autowired
	private QnaRepository qnaRepository;
	
	public List<QnaEntity> getQnaList() {
	    // id를 기준으로 내림차순 정렬 (역순)
	    return qnaRepository.findAll(Sort.by(Sort.Order.desc("id")));
	}

	public List<QnaEntity> getSearchedQnaList(String searchField, String keyword) {
	    List<QnaEntity> qnaList;

	    // 검색 필드에 따라 QnaRepository에서 검색 처리
	    switch (searchField) {
	        case "title":
	            qnaList = qnaRepository.findByTitleContaining(keyword);  // 제목에서 검색
	            break;
	        case "writer":
	            qnaList = qnaRepository.findByWriterContaining(keyword);  // 작성자에서 검색
	            break;
	        case "content":
	            qnaList = qnaRepository.findByContentContaining(keyword);  // 내용에서 검색
	            break;
	        default:
	            qnaList = new ArrayList<>();  // 기본적으로 빈 리스트 반환
	    }

	    // ID를 기준으로 내림차순 정렬
	    return qnaList.stream()
	                  .sorted(Comparator.comparing(QnaEntity::getId).reversed())
	                  .collect(Collectors.toList());
	}

	public void saveQna(QnaEntity qna) {
        qnaRepository.save(qna);
    }
	
	public void updateQna(int id, QnaEntity qna) {
	    // id로 기존 QnaEntity를 찾기
	    QnaEntity existingQna = qnaRepository.findById(id).orElse(null);

	    // 만약 해당 QnaEntity가 존재하면 수정
	    if (existingQna != null) {
	        // 기존의 데이터를 새로운 값으로 수정 (setter 사용)
	        existingQna.setTitle(qna.getTitle());  // 제목 수정
	        existingQna.setWriter(qna.getWriter());  // 작성자 수정
	        existingQna.setContent(qna.getContent());  // 내용 수정
	        existingQna.setStatus(qna.getStatus());  // 상태 수정
	        
	        // 수정된 QnaEntity 저장
	        qnaRepository.save(existingQna);
	    }
	}
	
	public void answerQna(int id, QnaEntity qna) {
	    // id로 기존 QnaEntity를 찾기
	    QnaEntity existingQna = qnaRepository.findById(id).orElse(null);

	    // 만약 해당 QnaEntity가 존재하면 수정
	    if (existingQna != null) {
	        // 기존의 데이터를 새로운 값으로 수정 (setter 사용)
	        existingQna.setAnswer(qna.getAnswer());  // 답변 수정
	        existingQna.setStatus(qna.getStatus());  // 상태 수정

	        // 수정된 QnaEntity 저장
	        qnaRepository.save(existingQna);
	    }
	}
	
	public void deleteQna(int id) {
	    // 해당 ID의 QNA를 삭제
	    qnaRepository.deleteById(id);
	}
	
}