<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>首页 - 智慧物业管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
    <div class="container">
        <!-- 顶部导航栏 -->
        <nav class="navbar">
            <div class="navbar-brand">智慧物业管理系统</div>
            <div class="navbar-menu">
                <!-- 显示当前登录用户信息 -->
                <span style="color: #667eea;">欢迎您, ${sessionScope.loginUser.realName}!</span>
                <!-- 返回首页按钮 -->
                <a href="${pageContext.request.contextPath}/index" class="nav-link">首页</a>
                <!-- 退出登录按钮 -->
                <a href="${pageContext.request.contextPath}/logout" class="nav-link">退出登录</a>
            </div>
        </nav>
        
        <!-- 主要内容区域 -->
        <div class="card">
            <div class="card-header">系统功能导航</div>
            
            <!-- 功能模块列表 -->
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-top: 20px;">
                <!-- 用户管理模块 -->
                <div class="card" style="text-align: center; cursor: pointer;" 
                     onclick="location.href='${pageContext.request.contextPath}/user/list'">
                    <h3 style="color: #667eea; margin-bottom: 10px;">用户管理</h3>
                    <p style="color: #777;">管理系统用户账号</p>
                </div>
                
                <!-- 业主管理模块 -->
                <div class="card" style="text-align: center; cursor: pointer;" 
                     onclick="location.href='${pageContext.request.contextPath}/owner/list'">
                    <h3 style="color: #667eea; margin-bottom: 10px;">业主管理</h3>
                    <p style="color: #777;">管理小区业主信息</p>
                </div>
                
                <!-- 房屋管理模块 -->
                <div class="card" style="text-align: center; cursor: pointer;" 
                     onclick="location.href='${pageContext.request.contextPath}/house/list'">
                    <h3 style="color: #667eea; margin-bottom: 10px;">房屋管理</h3>
                    <p style="color: #777;">管理小区房屋信息</p>
                </div>
                


                <!-- 缴费管理模块 -->
                <div class="card" style="text-align: center; cursor: pointer;"
                     onclick="location.href='${pageContext.request.contextPath}/payment/list'">
                    <h3 style="color: #667eea; margin-bottom: 10px;">缴费管理</h3>
                    <p style="color: #777;">管理业主缴费记录</p>
                </div>

                <!-- 设备维修管理模块 -->
                <div class="card" style="text-align: center; cursor: pointer;"
                     onclick="location.href='${pageContext.request.contextPath}/maintenance/list'">
                    <h3 style="color: #667eea; margin-bottom: 10px;">设备维修</h3>
                    <p style="color: #777;">管理小区设备维修记录</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
