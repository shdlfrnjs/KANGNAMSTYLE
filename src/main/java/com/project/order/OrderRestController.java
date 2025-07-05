package com.project.order;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.project.order.bo.OrderBO;
import com.project.order.entity.OrderEntity;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.AccessToken;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpSession;

@RestController
public class OrderRestController {
	private IamportClient iamportClient;

	@Autowired
	private OrderBO orderBO;

    @Value("${iamport.api-key}")
    private String API_KEY;

    @Value("${iamport.api-secret}")
    private String API_SECRET;
    
    @PostConstruct
    public void init() {
        this.iamportClient = new IamportClient(API_KEY, API_SECRET);
    }

    // 토큰을 받아오는 메소드
    @ResponseBody
    @GetMapping("/order/getToken")
    public IamportResponse<AccessToken> getAuthToken() throws IamportResponseException, IOException {
        return iamportClient.getAuth();
    }
    
    // 결제 검증
	@ResponseBody
	@PostMapping("/order/{imp_uid}")
	public IamportResponse<Payment> paymentByImpUid(@PathVariable("imp_uid") String imp_uid)
			throws IamportResponseException, IOException {
		return iamportClient.paymentByImpUid(imp_uid);
	}
    
	// 결제 취소
	@PostMapping("/order/cancel")
	public Map<String, String> cancelOrder(@RequestBody Map<String, String> requestData) {
	    Map<String, String> resultMap = new HashMap<>();
	    String impUid = requestData.get("imp_uid"); // imp_uid를 요청 데이터에서 가져옵니다.

	    try {
	        // 1. 토큰 발급 요청
	        IamportResponse<AccessToken> authResponse = iamportClient.getAuth();
	        String token = authResponse.getResponse().getToken();

	        // 2. 요청할 URL 설정
	        URL url = new URL("https://api.iamport.kr/payments/cancel");
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        
	        // 3. 요청 방식 설정
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Authorization", "Bearer " + token);
	        conn.setRequestProperty("Content-Type", "application/json");
	        conn.setDoOutput(true); // POST 요청을 위해 OutputStream 사용

	        // 4. 취소 요청 데이터 생성 (JSON 형식)
	        JsonObject json = new JsonObject();
	        json.addProperty("imp_uid", impUid);

	        // 5. 요청 본문에 JSON 데이터 쓰기
	        try (OutputStream os = conn.getOutputStream()) {
	            byte[] input = json.toString().getBytes("utf-8");
	            os.write(input, 0, input.length);
	        }

	        // 6. 응답 코드 확인
	        int responseCode = conn.getResponseCode();
	        if (responseCode == HttpURLConnection.HTTP_OK) {
	            // 7. 응답 데이터 읽기
	            try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"))) {
	                StringBuilder response = new StringBuilder();
	                String responseLine;
	                while ((responseLine = br.readLine()) != null) {
	                    response.append(responseLine.trim());
	                }
	                
	                // 8. 응답 처리
	                JsonObject responseBody = JsonParser.parseString(response.toString()).getAsJsonObject();
	                if (responseBody != null && responseBody.get("code").getAsInt() == 0) {
	                    resultMap.put("result", "success");
	                    resultMap.put("message", "결제가 성공적으로 취소되었습니다.");
	                } else {
	                    resultMap.put("result", "fail");
	                    resultMap.put("message", "결제 취소 실패: " + responseBody.get("message").getAsString());
	                }
	            }
	        } else {
	            resultMap.put("result", "fail");
	            resultMap.put("message", "결제 취소 요청 실패: 응답 코드 " + responseCode);
	        }

	    } catch (IOException e) {
	        resultMap.put("result", "fail");
	        resultMap.put("message", "결제 취소 중 IO 오류 발생: " + e.getMessage());
	    } catch (Exception e) {
	        resultMap.put("result", "fail");
	        resultMap.put("message", "결제 취소 중 오류 발생: " + e.getMessage());
	    }

	    return resultMap;
	}

	@PostMapping("/order/orderCreate")
	public Map<String, String> orderCreate(
	        @RequestParam("ids") List<Integer> ids,
	        @RequestParam("imp_uid") String imp_uid, // imp_uid 추가
	        @RequestParam("buyerName") String buyerName,
	        @RequestParam("recipientName") String recipientName,
	        @RequestParam("recipientPhone") String recipientPhone,
	        @RequestParam("recipientAddress") String recipientAddress,
	        @RequestParam("paymentMethod") String paymentMethod,
	        HttpSession session) {

	    // userId는 세션에 저장되어있으므로 파라미터로 전달받지 않고 세션에 저장된 값 불러오기
	    int userId = (Integer) session.getAttribute("userId");

	    List<OrderEntity> order = orderBO.createOrderInfo(
	            ids, 
	            userId,
	            imp_uid,
	            buyerName, 
	            recipientName, 
	            recipientPhone, 
	            recipientAddress, 
	            paymentMethod
	    );

	    Map<String, String> resultMap = new HashMap<>();

	    if (order != null) {
	        resultMap.put("result", "success");
	    } else {
	        resultMap.put("result", "fail");
	    }

	    return resultMap;
	}

}