package com.healthdiary.servlet;

import com.healthdiary.util.OpenAIClient;
import com.healthdiary.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/gpt")
public class GPTServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        // Forward to GPT page
        request.getRequestDispatcher("gpt.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String question = request.getParameter("question");

        // Validate input
        if (question == null || question.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập câu hỏi của bạn.");
            request.getRequestDispatcher("gpt.jsp").forward(request, response);
            return;
        }

        // Limit question length to prevent abuse
        if (question.length() > 1000) {
            request.setAttribute("error", "Câu hỏi quá dài. Vui lòng giới hạn trong 1000 ký tự.");
            request.getRequestDispatcher("gpt.jsp").forward(request, response);
            return;
        }

        try {
            String result = OpenAIClient.askGPT(question);
            request.setAttribute("response", result);
            request.setAttribute("question", question); // Keep the question for display
            request.setAttribute("success", "Đã nhận được phản hồi từ AI Assistant!");

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
        } catch (RuntimeException e) {
            if (e.getMessage().contains("API key")) {
                request.setAttribute("error", "Chức năng AI Assistant hiện chưa được cấu hình. Vui lòng liên hệ quản trị viên.");
            } else {
                request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            }
        } catch (IOException e) {
            if (e.getMessage().contains("401")) {
                request.setAttribute("error", "API key không hợp lệ. Vui lòng liên hệ quản trị viên.");
            } else if (e.getMessage().contains("429")) {
                request.setAttribute("error", "Đã vượt quá giới hạn sử dụng API. Vui lòng thử lại sau.");
            } else if (e.getMessage().contains("500")) {
                request.setAttribute("error", "Dịch vụ AI tạm thời không khả dụng. Vui lòng thử lại sau.");
            } else {
                request.setAttribute("error", "Không thể kết nối đến dịch vụ AI. Vui lòng kiểm tra kết nối mạng và thử lại.");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Đã xảy ra lỗi không mong muốn: " + e.getMessage());
        }

        // Forward back to the GPT page
        request.getRequestDispatcher("gpt.jsp").forward(request, response);
    }
}
