<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.healthdiary.util.OpenAIClient" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    String result = null;
    String error = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String question = request.getParameter("question");

        try {
            result = OpenAIClient.askGPT(question);
        } catch (Exception e) {
            error = "Lỗi khi gọi OpenAI API: " + e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hỏi GPT</title>
    <style>
        body { font-family: Arial; padding: 20px; }
        input[type="text"] { width: 60%; padding: 8px; }
        button { padding: 8px 16px; }
        pre { background: #f4f4f4; padding: 10px; white-space: pre-wrap; }
    </style>
</head>
<body>

    <h2>GPT Assistant</h2>

    <form method="post">
        <label>Nhập câu hỏi của bạn:</label><br><br>
        <input type="text" name="question" required placeholder="VD: Gợi ý một bữa ăn lành mạnh" />
        <button type="submit">Gửi</button>
    </form>

    <br><br>

    <%
        if (result != null) {
    %>
        <h3>Phản hồi từ GPT:</h3>
        <pre><%= result %></pre>
    <%
        } else if (error != null) {
    %>
        <p style="color:red;"><%= error %></p>
    <%
        }
    %>

</body>
</html>
