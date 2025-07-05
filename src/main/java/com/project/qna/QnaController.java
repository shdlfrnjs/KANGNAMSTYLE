package com.project.qna;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.qna.bo.QnaBO;
import com.project.qna.entity.QnaEntity;
import com.project.qna.repository.QnaRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class QnaController {

	@Autowired
	private QnaBO qnaBO;
	
	@Autowired
	private QnaRepository qnaRepository;
	
	@GetMapping("/qna")
    public String getQnaList(
    		@RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "5") int size,
            Model model) {
		
        List<QnaEntity> qnaList = qnaBO.getQnaList();
        
        // 페이징 처리
        int totalItems = qnaList.size();
	    int fromIndex = Math.min((page - 1) * size, totalItems);
	    int toIndex = Math.min(fromIndex + size, totalItems);
	    List<QnaEntity> paginatedQnaList = qnaList.subList(fromIndex, toIndex);
	    
        model.addAttribute("qnaList", paginatedQnaList);
        model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", (int) Math.ceil((double) totalItems / size));
	    
        return "qna/qnaList";
    }
	
	@GetMapping("/qna/{id}")
    public String getQnaDetail(@PathVariable("id") int qnaId, HttpSession session, Model model) {
		
        QnaEntity qna = qnaRepository.findById(qnaId).orElse(null);
        Integer userId = (Integer) session.getAttribute("userId");
        Integer managerId = (Integer) session.getAttribute("managerId");
        
        model.addAttribute("qna", qna);
        model.addAttribute("userId", userId);
        model.addAttribute("managerId", managerId);
        
        return "qna/qnaDetail";
    }
	
	@GetMapping("/qna/search")
    public String searchQna(
    		@RequestParam("searchField") String searchField,
            @RequestParam("keyword") String keyword,
    		@RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "5") int size,
            Model model) {
		
        List<QnaEntity> qnaList = qnaBO.getSearchedQnaList(searchField, keyword);
        
        // 페이징 처리
        int totalItems = qnaList.size();
	    int fromIndex = Math.min((page - 1) * size, totalItems);
	    int toIndex = Math.min(fromIndex + size, totalItems);
	    List<QnaEntity> paginatedQnaList = qnaList.subList(fromIndex, toIndex);
	    
        model.addAttribute("qnaList", paginatedQnaList);
        model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", (int) Math.ceil((double) totalItems / size));
	    model.addAttribute("searchField", searchField);
	    model.addAttribute("keyword", keyword);
	    
        return "qna/qnaList";
    }
	
	@GetMapping("/qna/addform")
    public String addForm(HttpSession session, Model model) {
		
		Integer userId = (Integer) session.getAttribute("userId");
		String userName = (String) session.getAttribute("userName");

		if (userId == null) {
			return "redirect:/user/sign-in-view";
		}
		
		model.addAttribute("userName", userName);
		
        return "qna/qnaAddForm";
    }

	@PostMapping("/qna/add")
    public String addQna(@ModelAttribute QnaEntity qna) {
        qnaBO.saveQna(qna);
        return "redirect:/qna";
    }
	
	@GetMapping("/qna/updateform/{id}")
    public String updateForm(@PathVariable("id") int id, Model model) {

        QnaEntity qna = qnaRepository.findById(id).orElse(null);

        model.addAttribute("qna", qna);
        
        return "qna/qnaUpdateForm";
    }

    @PostMapping("/qna/update/{id}")
    public String updateQna(@PathVariable("id") int id, @ModelAttribute QnaEntity qna) {
    	
        qnaBO.updateQna(id, qna);
        
        return "redirect:/qna/" + id;
    }
    
    @PostMapping("/qna/delete/{id}")
    public String deleteQna(@PathVariable("id") int id) {
        
        qnaBO.deleteQna(id);
        
        return "redirect:/qna"; 
    }
    
    @GetMapping("/qna/answerform/{id}")
    public String answerForm(@PathVariable("id") int id, Model model) {

        QnaEntity qna = qnaRepository.findById(id).orElse(null);

        model.addAttribute("qna", qna);
        
        return "qna/qnaAnswerForm";
    }
    
    @PostMapping("/qna/answer/{id}")
    public String answerQna(@PathVariable("id") int id, @ModelAttribute QnaEntity qna) {
    	
        qnaBO.answerQna(id, qna);
        
        return "redirect:/qna/" + id;
    }
}