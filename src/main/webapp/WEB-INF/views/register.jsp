<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册 - 智慧物业管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<!-- 注册容器 -->
<div class="login-container">
    <div class="login-box">
        <!-- 系统标题 -->
        <h2 class="login-title">用户注册</h2>

        <!-- 错误提示信息 -->
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <!-- 注册表单 -->
        <form action="${pageContext.request.contextPath}/doRegister" method="post">
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

            <!-- 确认密码输入框 -->
            <div class="form-group">
                <label class="form-label" for="confirmPassword">确认密码</label>
                <input type="password" id="confirmPassword" name="confirmPassword"
                       class="form-control" placeholder="请再次输入密码" required>
            </div>

            <!-- 真实姓名输入框 -->
            <div class="form-group">
                <label class="form-label" for="realName">真实姓名</label>
                <input type="text" id="realName" name="realName"
                       class="form-control" placeholder="请输入真实姓名" required>
            </div>

            <!-- 联系电话输入框 -->
            <div class="form-group">
                <label class="form-label" for="phone">联系电话</label>
                <input type="text" id="phone" name="phone"
                       class="form-control" placeholder="请输入联系电话">
            </div>

            <!-- 注册按钮 -->
            <button type="submit" class="btn btn-primary">注册</button>
        </form>

        <!-- 登录链接 -->
        <div style="margin-top: 15px; text-align: center;">
            <a href="${pageContext.request.contextPath}/login" style="color: #667eea; text-decoration: none;">已有账号？立即登录</a>
        </div>
    </div>
</div>
</body>
</html>
