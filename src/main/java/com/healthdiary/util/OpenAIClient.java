package com.healthdiary.util;

import okhttp3.*;

import java.io.IOException;

public class OpenAIClient {
    private static final String API_KEY = System.getenv("OPENAI_API_KEY"); // Get from environment variable
    private static final String API_URL = "https://api.openai.com/v1/chat/completions";

    public static String askGPT(String prompt) throws IOException {
        if (prompt == null || prompt.trim().isEmpty()) {
            throw new IOException("Prompt cannot be null or empty.");
        }
        
        if (API_KEY == null || API_KEY.trim().isEmpty()) {
            throw new IOException("OpenAI API key not configured. Please set OPENAI_API_KEY environment variable.");
        }
        
        OkHttpClient client = new OkHttpClient();

        String json = "{\n" +
                "  \"model\": \"gpt-3.5-turbo\",\n" +
                "  \"messages\": [\n" +
                "    {\"role\": \"user\", \"content\": \"" + prompt + "\"}\n" +
                "  ]\n" +
                "}";

        RequestBody body = RequestBody.create(json, MediaType.get("application/json"));
        Request request = new Request.Builder()
                .url(API_URL)
                .header("Authorization", "Bearer " + API_KEY)
                .post(body)
                .build();

        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) throw new IOException("Lỗi: " + response.code());
            
            ResponseBody responseBody = response.body();
            if (responseBody == null) {
                throw new IOException("Empty response from OpenAI API");
            }
            
            return responseBody.string(); // Trả JSON, nên dùng thêm `Gson` để trích xuất nếu cần
        }
    }

	
}
