<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录 - 智慧物业管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<!-- 登录容器 -->
<div class="login-container">
    <div class="login-box">
        <!-- 系统标题 -->
        <h2 class="login-title">智慧物业管理系统</h2>

        <!-- 错误提示信息：显示登录失败等错误信息 -->
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <!-- 成功提示信息：显示注册成功等信息 -->
        <c:if test="${not empty success}">
            <div class="success-message">${success}</div>
        </c:if>

        <!-- 登录表单 -->
        <form action="${pageContext.request.contextPath}/doLogin" method="post">
            <!-- 用户名输入框 -->
            <div class="form-group">
                <label class="form-label" for="username">用户名</label>
                <input type="text" id="username" name="username"
                       class="form-control" placeholder="请输入用户名" required>
            </div>

            <!-- 密码输入框 -->
            <div class="form-group">
                <label class="form-label" for="password">密码</label>
                <input type="password" id="password" name="password"
                       class="form-control" placeholder="请输入密码" required>
            </div>

            <!-- 登录按钮 -->
            <button type="submit" class="btn btn-primary">登录</button>
        </form>

        <!-- 注册链接 -->
        <div style="margin-top: 15px; text-align: center;">
            <a href="${pageContext.request.contextPath}/register" style="color: #667eea; text-decoration: none; font-weight: bold;">没有账号？立即注册</a>
        </div>

        <!-- 提示信息 -->
        <div style="margin-top: 20px; text-align: center; color: #888; font-size: 12px;">
            默认账号: admin / 123456
        </div>
    </div>
</div>
</body>
</html>
