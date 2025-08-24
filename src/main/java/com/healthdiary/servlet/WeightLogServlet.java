package com.healthdiary.servlet;

import com.healthdiary.dao.WeightDAO;
import com.healthdiary.model.Weight_logs;
import com.healthdiary.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/weight-log")
public class WeightLogServlet extends HttpServlet {
    private WeightDAO weightDAO;

    @Override
    public void init() throws ServletException {
        weightDAO = new WeightDAO();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("weight-form.jsp").forward(request, response);
    } 	
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            User user = (User) request.getSession().getAttribute("user");
            
            if (user == null) {
                response.sendRedirect("login");
                return;
            }
            
            String dateStr = request.getParameter("date");
            String weightStr = request.getParameter("weight");
            
            if (dateStr == null || dateStr.trim().isEmpty() || weightStr == null || weightStr.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin");
                request.getRequestDispatcher("weight-form.jsp").forward(request, response);
                return;
            }
            
            double weight = Double.parseDouble(weightStr);
            
            if (weight <= 0 || weight > 1000) {
                request.setAttribute("error", "Cân nặng không hợp lệ");
                request.getRequestDispatcher("weight-form.jsp").forward(request, response);
                return;
            }

            // Parse date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date logDate = sdf.parse(dateStr);

            // Check if weight already logged for this date
            if (weightDAO.hasWeightForDate(user.getId(), dateStr)) {
                request.setAttribute("error", "Đã có dữ liệu cân nặng cho ngày này!");
                request.getRequestDispatcher("weight-form.jsp").forward(request, response);
                return;
            }

            Weight_logs weightLog = new Weight_logs();
            weightLog.setUserId(user.getId());
            weightLog.setLogDate(logDate);
            weightLog.setWeightKg((float) weight);

            weightDAO.addWeightLog(weightLog);
            response.sendRedirect("weight-chart");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi lưu cân nặng");
            request.getRequestDispatcher("weight-form.jsp").forward(request, response);
        }
    }
}