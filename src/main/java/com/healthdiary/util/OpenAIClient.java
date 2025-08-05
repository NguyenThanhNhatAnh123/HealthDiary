package com.healthdiary.util;

import okhttp3.*;

import java.io.IOException;

public class OpenAIClient {
    private static final String API_KEY = "sk-..."; // Nhớ bảo mật!
    private static final String API_URL = "https://api.openai.com/v1/chat/completions";

    public static String askGPT(String prompt) throws IOException {
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
            return response.body().string(); // Trả JSON, nên dùng thêm `Gson` để trích xuất nếu cần
        }
    }

	
}
