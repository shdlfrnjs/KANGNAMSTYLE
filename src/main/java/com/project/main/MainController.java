package com.project.main;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.cloth.bo.ClothBO;
import com.project.cloth.entity.ClothDetail;
import com.project.weather.bo.WeatherBO;
import com.project.weather.entity.WeatherEntity;

import jakarta.servlet.http.HttpSession;

@Controller
public class MainController {

    @Autowired
    private ClothBO clothBO;
    
    @Autowired
    private WeatherBO weatherBO;

    @GetMapping("/main-view")
    public String mainPage(Model model, HttpSession session) {
    	// 세션에서 user 정보를 가져옵니다.
        Integer userId = (Integer) session.getAttribute("userId");
        String userName = (String) session.getAttribute("userName");
        
    	// 메인 베스트셀러 상품 추천
        List<ClothDetail> bestSellerClothes = clothBO.getMainBestSeller();
        model.addAttribute("bestSellerClothes", bestSellerClothes);
        
    	// 오늘 날짜
    	LocalDate today = LocalDate.now();
    	
        // 날씨 데이터를 가져와서 모델에 추가
        WeatherEntity weather = weatherBO.getWeatherToday(today);  // WeatherBO에서 날씨 정보 가져오기
        model.addAttribute("weather", weather);

        // 날씨에 맞는 상품 추천
        List<ClothDetail> weatherClothes = clothBO.getWeatherCloth(weather);
        model.addAttribute("weatherClothes", weatherClothes);
        
        // 할인 상품 추천
        List<ClothDetail> onSaleClothes = clothBO.getOnSaleCloth();
        model.addAttribute("onSaleClothes", onSaleClothes);

        // 개인 맞춤 상품 추천
        List<ClothDetail> recommendedClothes = null;
        if (userId != null) {
            recommendedClothes = clothBO.getRecommendedCloth(userId);
        }
        model.addAttribute("userName", userName);
        model.addAttribute("recommendedClothes", recommendedClothes);

        model.addAttribute("viewName", "main/main");
        return "template/mainLayout";
    }
    
}

