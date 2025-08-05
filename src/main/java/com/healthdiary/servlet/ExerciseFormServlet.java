//package com.healthdiary.servlet;
//
//import com.healthdiary.dao.ExerciseDAO;
//import com.healthdiary.model.Exercise_samples;
//import com.healthdiary.model.User;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//import java.io.IOException;
//import java.util.List;
//
//@WebServlet("/exercise-form")
//public class ExerciseFormServlet extends HttpServlet {
//	    private ExerciseDAO exerciseDAO;
//
//	    @Override
//	    public void init() throws ServletException {
//	        exerciseDAO = new ExerciseDAO();
//	    }
//	    
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
////
////        try {
////            // Load exercise samples for dropdown (if needed)
////            List<Exercise_samples> exerciseSamples = exerciseDAO.getAllExercises();
////            request.setAttribute("exerciseSamples", exerciseSamples);
////        } catch (Exception e) {
////            e.printStackTrace();
////            request.setAttribute("error", "Không thể tải danh sách bài tập");
////        }
//
//        request.getRequestDispatcher("/exercise-form.jsp").forward(request, response);
//    }
//    protected void doPost(HttpServletRequest request,HttpServletResponse reponse) throws Exception{
//    	try {
//    		
//			
//		} catch (Exception e) {
//			// TODO: handle exception
//		}
//    }
//}