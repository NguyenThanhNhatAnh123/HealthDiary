package com.healthdiary.servlet;

import com.healthdiary.util.OpenAIClient;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ask-gpt")
public class GPTServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String question = request.getParameter("question");

        try {
            String result = OpenAIClient.askGPT(question);
            request.setAttribute("response", result);
            request.getRequestDispatcher("/WEB-INF/views/gpt.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Gọi API thất bại: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/gpt.jsp").forward(request, response);
        }
    }
}
