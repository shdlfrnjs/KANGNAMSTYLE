package com.project.weather.bo;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.project.weather.entity.WeatherEntity;
import com.project.weather.repository.WeatherRepository;

@Service
public class WeatherBO {

	@Autowired
	private WeatherRepository weatherRepository;
	
	@Value("${weather.api-key}")
    private String API_KEY;
	
    // OpenWeatherMap API 호출을 위한 URL 생성 및 응답 JSON 반환
    private String getWeatherString() {
        String apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=yongin&units=metric&appid=" + API_KEY;
        StringBuilder response = new StringBuilder();

        try {
            // URL 객체 생성
            URL url = new URL(apiUrl);

            // HttpURLConnection 객체 생성
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");  // GET 방식으로 요청
            connection.setRequestProperty("Content-Type", "application/json");  // Content-Type 설정

            // 응답 코드 확인
            int responseCode = connection.getResponseCode();
            System.out.println("Response Code: " + responseCode);

            // 응답이 성공적일 경우(200~299)
            if (responseCode >= 200 && responseCode < 300) {
                BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                String inputLine;
                
                // 응답 데이터를 한 줄씩 읽어와 StringBuilder에 저장
                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }
                in.close();  // BufferedReader 닫기
            } else {
                System.out.println("Error in API response");
            }

            // 연결 해제
            connection.disconnect();
            
        } catch (Exception e) {
            e.printStackTrace();  // 예외 처리
        }

        return response.toString();  // API로부터 받은 JSON 응답 반환
    }

    // temp(온도), main, icon을 Map 형태로 반환하는 메서드
    private Map<String, Object> parseWeather(String jsonString){

        // JSON 파서를 이용해 문자열을 파싱
        JsonObject jsonObject = JsonParser.parseString(jsonString).getAsJsonObject();

        Map<String, Object> resultMap = new HashMap<>();

        // "weather" 배열에서 첫 번째 요소의 "icon" 및 "main" 정보 가져오기
        JsonArray weatherArray = jsonObject.getAsJsonArray("weather");
        JsonObject weatherData = weatherArray.get(0).getAsJsonObject();

        // "main"에서 온도 정보 가져오기
        JsonObject mainData = jsonObject.getAsJsonObject("main");

        resultMap.put("icon", weatherData.get("icon").getAsString());
        resultMap.put("main", weatherData.get("main").getAsString());
        resultMap.put("temp", mainData.get("temp").getAsDouble());

        return resultMap;
    }

    // API에서 날씨 데이터를 가져와 WeatherEntity로 변환
    private WeatherEntity getWeatherFromApi(){
        // OpenWeatherMap에서 날씨 데이터 가져오기
        String weatherData = getWeatherString();

        // 받아온 JSON 데이터를 파싱
        Map<String, Object> parsedWeather = parseWeather(weatherData);

        // 파싱된 데이터를 WeatherEntity에 설정
        WeatherEntity weatherEntity = new WeatherEntity();
        weatherEntity.setDate(LocalDate.now());  // 현재 날짜 설정
        weatherEntity.setIcon(parsedWeather.get("icon").toString());
        weatherEntity.setWeather(parsedWeather.get("main").toString());
        weatherEntity.setTemperature((Double) parsedWeather.get("temp"));
        
        return weatherEntity;
    }
    
    // 오늘 날짜에 맞는 날씨 데이터를 리포지토리에서 조회
    public WeatherEntity getWeatherToday(LocalDate date) {
        // 날씨 데이터를 조회
        WeatherEntity weatherToday = weatherRepository.findByDate(date);

        // 데이터가 없다면 API에서 가져와 저장
        if (weatherToday == null) {
            WeatherEntity weatherEntity = getWeatherFromApi();  // API에서 날씨 가져오기
            weatherRepository.save(weatherEntity);  // DB에 저장
            return weatherEntity;
        }

        // 이미 데이터가 있다면 리포지토리에서 반환
        return weatherToday;
    }
    
    // 자동 스케줄링
    @Transactional
    @Scheduled(cron = "0 0/30 * * * *") // 매 30분마다 실행
    public void saveWeatherEntity(){
        weatherRepository.save(getWeatherFromApi());
    }
    
}
