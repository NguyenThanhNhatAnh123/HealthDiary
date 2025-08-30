package com.healthdiary.util;

import okhttp3.*;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonArray;

import java.io.IOException;

public class OpenAIClient {
    private static final String API_URL = "https://api.openai.com/v1/chat/completions";
    
    // Get API key from environment variable or system property
    private static String getApiKey() {
        String apiKey = System.getenv("OPENAI_API_KEY");
        if (apiKey == null || apiKey.trim().isEmpty()) {
            apiKey = System.getProperty("openai.api.key");
        }
        if (apiKey == null || apiKey.trim().isEmpty()) {
            throw new RuntimeException("OpenAI API key not found. Please set OPENAI_API_KEY environment variable or openai.api.key system property.");
        }
        return apiKey;
    }

    public static String askGPT(String prompt) throws IOException {
        if (prompt == null || prompt.trim().isEmpty()) {
            throw new IllegalArgumentException("Prompt không được để trống");
        }
        
        // Mock mode for testing when API quota exceeded
        boolean mockMode = true; // Temporarily enabled for testing
        if (mockMode) {
            return getMockResponse(prompt);
        }
        
        OkHttpClient client = new OkHttpClient();
        
        // Escape quotes in prompt to prevent JSON syntax errors
        String escapedPrompt = prompt.replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
        
        String json = "{\n" +
                "  \"model\": \"gpt-3.5-turbo\",\n" +
                "  \"messages\": [\n" +
                "    {\n" +
                "      \"role\": \"system\",\n" +
                "      \"content\": \"Bạn là một trợ lý AI chuyên về sức khỏe và dinh dưỡng. Hãy trả lời bằng tiếng Việt một cách chi tiết và hữu ích.\"\n" +
                "    },\n" +
                "    {\n" +
                "      \"role\": \"user\",\n" +
                "      \"content\": \"" + escapedPrompt + "\"\n" +
                "    }\n" +
                "  ],\n" +
                "  \"max_tokens\": 1000,\n" +
                "  \"temperature\": 0.7\n" +
                "}";

        RequestBody body = RequestBody.create(json, MediaType.get("application/json"));
        Request request = new Request.Builder()
                .url(API_URL)
                .header("Authorization", "Bearer " + getApiKey())
                .header("Content-Type", "application/json")
                .post(body)
                .build();

        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) {
                String errorBody = response.body() != null ? response.body().string() : "Unknown error";
                throw new IOException("OpenAI API Error " + response.code() + ": " + errorBody);
            }
            
            String responseBody = response.body().string();
            
            try {
                // Parse JSON response to extract the actual message content
                JsonObject jsonResponse = JsonParser.parseString(responseBody).getAsJsonObject();
                JsonArray choices = jsonResponse.getAsJsonArray("choices");
                
                if (choices != null && choices.size() > 0) {
                    JsonObject firstChoice = choices.get(0).getAsJsonObject();
                    JsonObject message = firstChoice.getAsJsonObject("message");
                    if (message != null && message.has("content")) {
                        return message.get("content").getAsString().trim();
                    }
                }
                
                // Fallback if parsing fails
                return "Không thể phân tích phản hồi từ OpenAI API";
                
            } catch (Exception e) {
                // If JSON parsing fails, return raw response (for debugging)
                return "Lỗi phân tích JSON: " + e.getMessage() + "\nRaw response: " + responseBody;
            }
        }
    }
    
    // Mock responses for testing
    private static String getMockResponse(String prompt) {
        String lowerPrompt = prompt.toLowerCase();
        
        if (lowerPrompt.contains("giảm cân") || lowerPrompt.contains("ăn")) {
            return "Để giảm cân hiệu quả, bạn nên:\n\n" +
                   "1. Ăn nhiều rau xanh và trái cây\n" +
                   "2. Giảm tinh bột và đường\n" +
                   "3. Uống đủ nước (2-3 lít/ngày)\n" +
                   "4. Ăn 5-6 bữa nhỏ thay vì 3 bữa lớn\n" +
                   "5. Tập thể dục đều đặn 30 phút/ngày\n\n" +
                   "Lưu ý: Giảm cân từ từ 0.5-1kg/tuần là an toàn nhất.";
        } else if (lowerPrompt.contains("tập") || lowerPrompt.contains("luyện")) {
            return "Kế hoạch tập luyện cho người mới bắt đầu:\n\n" +
                   "**Tuần 1-2:** Làm quen\n" +
                   "- Đi bộ nhanh 20-30 phút\n" +
                   "- Squat, push-up cơ bản\n" +
                   "- Nghỉ 1 ngày giữa các buổi tập\n\n" +
                   "**Tuần 3-4:** Tăng cường độ\n" +
                   "- Thêm plank, lunges\n" +
                   "- Tăng thời gian lên 40 phút\n" +
                   "- Tập 4-5 ngày/tuần\n\n" +
                   "Nhớ khởi động và giãn cơ sau tập!";
        } else if (lowerPrompt.contains("ngủ") || lowerPrompt.contains("giấc")) {
            return "Để cải thiện chất lượng giấc ngủ:\n\n" +
                   "1. **Thời gian:** Ngủ đúng giờ (22h-23h), dậy đúng giờ\n" +
                   "2. **Môi trường:** Phòng tối, mát, yên tĩnh\n" +
                   "3. **Tránh:** Caffeine sau 14h, màn hình trước khi ngủ 1h\n" +
                   "4. **Thói quen:** Đọc sách, nghe nhạc nhẹ, thiền\n" +
                   "5. **Tập thể dục:** Nhưng không tập quá muộn\n\n" +
                   "Giấc ngủ chất lượng giúp phục hồi cơ thể và tăng cường miễn dịch.";
        } else if (lowerPrompt.contains("bmi") || lowerPrompt.contains("cân nặng")) {
            return "Chỉ số BMI (Body Mass Index):\n\n" +
                   "**Công thức:** BMI = Cân nặng (kg) / Chiều cao² (m²)\n\n" +
                   "**Phân loại:**\n" +
                   "- Dưới 18.5: Thiếu cân\n" +
                   "- 18.5-24.9: Bình thường\n" +
                   "- 25-29.9: Thừa cân\n" +
                   "- Trên 30: Béo phì\n\n" +
                   "**Lưu ý:** BMI chỉ là tham khảo, không tính đến tỷ lệ cơ/mỡ. " +
                   "Nên kết hợp với các chỉ số khác để đánh giá sức khỏe tổng thể.";
        } else {
            return "Cảm ơn bạn đã sử dụng AI Assistant!\n\n" +
                   "Tôi là trợ lý AI chuyên về sức khỏe và dinh dưỡng. " +
                   "Bạn có thể hỏi tôi về:\n\n" +
                   "• Chế độ ăn uống lành mạnh\n" +
                   "• Kế hoạch tập luyện\n" +
                   "• Cách tính BMI và calo\n" +
                   "• Cải thiện giấc ngủ\n" +
                   "• Quản lý cân nặng\n" +
                   "• Lối sống khỏe mạnh\n\n" +
                   "Hãy đặt câu hỏi cụ thể để tôi có thể hỗ trợ bạn tốt nhất!";
        }
    }
}
