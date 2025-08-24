package com.healthdiary.servlet;

import com.healthdiary.dao.WeightDAO;
import com.healthdiary.model.Weight_logs;
import com.healthdiary.model.User;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/api/weight-data")
public class WeightDataApiServlet extends HttpServlet {
    private WeightDAO weightDAO;

    @Override
    public void init() throws ServletException {
        weightDAO = new WeightDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            User user = (User) request.getSession().getAttribute("user");
            
            if (user == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("{\"error\": \"Người dùng chưa đăng nhập\"}");
                return;
            }

            List<Weight_logs> weightLogs = weightDAO.getWeightHistory(user.getId(), 30); // Last 30 days

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            Gson gson = new Gson();
            response.getWriter().write(gson.toJson(weightLogs));
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Có lỗi xảy ra khi tải dữ liệu cân nặng\"}");
        }
    }
}