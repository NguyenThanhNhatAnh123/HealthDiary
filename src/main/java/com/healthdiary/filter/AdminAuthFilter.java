package com.healthdiary.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/admin/*")
public class AdminAuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Không cần khởi tạo gì đặc biệt
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        // Kiểm tra xem có phải request đến trang login admin không
        String requestURI = httpRequest.getRequestURI();
        if (requestURI.contains("/admin/login") || requestURI.contains("/admin/logout")) {
            // Cho phép truy cập trang login/logout admin
            chain.doFilter(request, response);
            return;
        }

        // Kiểm tra session admin
        if (session != null && session.getAttribute("adminUser") != null) {
            // Admin đã đăng nhập, cho phép truy cập
            chain.doFilter(request, response);
        } else {
            // Admin chưa đăng nhập, chuyển về trang login admin
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/admin/login");
        }
    }

    @Override
    public void destroy() {
        // Không cần cleanup gì đặc biệt
    }
}
