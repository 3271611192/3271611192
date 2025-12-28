<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户列表 - 智慧物业管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .search-form {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .form-row {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            align-items: end;
        }

        .form-group {
            margin-bottom: 0;
            flex: 1;
            min-width: 150px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: 500;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 8px 12px;
            border: 2px solid #e0e6ed;
            border-radius: 8px;
            font-size: 14px;
        }

        .form-group .btn {
            padding: 8px 15px;
            width: auto;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- 顶部导航栏 -->
    <nav class="navbar">
        <div class="navbar-brand">智慧物业管理系统</div>
        <div class="navbar-menu">
            <span style="color: #667eea;">欢迎您, ${sessionScope.loginUser.realName}!</span>
            <!-- 一键返回首页按钮 -->
            <a href="${pageContext.request.contextPath}/index" class="nav-link">返回首页</a>
            <a href="${pageContext.request.contextPath}/logout" class="nav-link">退出登录</a>
        </div>
    </nav>

    <!-- 用户列表卡片 -->
    <div class="card">
        <div class="card-header">
            用户管理
            <!-- 新增按钮 -->
            <button class="btn btn-success" style="float: right;"
                    onclick="location.href='${pageContext.request.contextPath}/user/add'">
                新增用户
            </button>
        </div>

        <!-- 搜索表单 -->
        <div class="search-form">
            <form id="searchForm" action="${pageContext.request.contextPath}/user/list" method="get">
                <input type="hidden" name="currentPage" value="${empty param.currentPage ? 1 : param.currentPage}">
                <div class="form-row">
                    <div class="form-group">
                        <label>用户名:</label>
                        <input type="text" name="username" value="${param.username}" placeholder="请输入用户名">
                    </div>
                    <div class="form-group">
                        <label>真实姓名:</label>
                        <input type="text" name="realName" value="${param.realName}" placeholder="请输入真实姓名">
                    </div>
                    <div class="form-group">
                        <label>联系电话:</label>
                        <input type="text" name="phone" value="${param.phone}" placeholder="请输入联系电话">
                    </div>
                    <div class="form-group">
                        <label>角色:</label>
                        <select name="role">
                            <option value="">全部</option>
                            <option value="admin" ${param.role eq 'admin' ? 'selected' : ''}>管理员</option>
                            <option value="user" ${param.role eq 'user' ? 'selected' : ''}>普通用户</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">搜索</button>
                        <button type="button" class="btn btn-secondary" onclick="clearSearch()">清空</button>
                    </div>
                </div>
            </form>
        </div>

        <!-- 用户列表表格 -->
        <table class="table">
            <thead>
            <tr>
                <th>ID</th>
                <th>用户名</th>
                <th>真实姓名</th>
                <th>联系电话</th>
                <th>角色</th>
                <th>状态</th>
                <th>创建时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <!-- 遍历用户列表数据 -->
            <c:forEach items="${pageResult.data}" var="user">
                <tr>
                    <td>${user.id}</td>
                    <td>${user.username}</td>
                    <td>${user.realName}</td>
                    <td>${user.phone}</td>
                    <td>
                        <c:choose>
                            <c:when test="${user.role == 'admin'}">管理员</c:when>
                            <c:otherwise>普通用户</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${user.status == 1}">
                                <span style="color: #00b894;">启用</span>
                            </c:when>
                            <c:otherwise>
                                <span style="color: #d63031;">禁用</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                    </td>
                    <td>
                        <!-- 操作按钮组 -->
                        <div class="action-btns">
                            <!-- 编辑按钮 -->
                            <button class="btn btn-primary" style="padding: 5px 12px; font-size: 12px;"
                                    onclick="location.href='${pageContext.request.contextPath}/user/edit/${user.id}'">
                                编辑
                            </button>
                            <!-- 删除按钮 -->
                            <button class="btn btn-danger" style="padding: 5px 12px; font-size: 12px;"
                                    onclick="deleteUser(${user.id})">
                                删除
                            </button>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            <!-- 无数据提示 -->
            <c:if test="${empty pageResult.data}">
                <tr>
                    <td colspan="8" style="text-align: center; color: #999;">暂无数据</td>
                </tr>
            </c:if>
            </tbody>
        </table>

        <!-- 分页组件 -->
        <div class="pagination">
            <!-- 上一页按钮 -->
            <button class="pagination-btn"
                    onclick="goToPage(${pageResult.currentPage - 1})"
            ${!pageResult.hasPrevious ? 'disabled' : ''}>
                上一页
            </button>

            <!-- 分页信息显示 -->
            <span class="pagination-info">
                    第 ${pageResult.currentPage} / ${pageResult.totalPages} 页，
                    共 ${pageResult.total} 条数据
                </span>

            <button class="pagination-btn"
                    onclick="goToPage(${pageResult.currentPage + 1})"
            ${!pageResult.hasNext ? 'disabled' : ''}>
                下一页
            </button>


            <button class="pagination-btn"
                    onclick="location.href='${pageContext.request.contextPath}/index'">
                首页
            </button>

        </div>
    </div>
</div>

<script>
    /**
     * 删除用户函数
     * 弹出确认对话框，确认后发送删除请求
     * @param id 用户ID
     */
    function deleteUser(id) {
        if (confirm('确认要删除该用户吗？')) {
            // 发送删除请求
            fetch('${pageContext.request.contextPath}/user/delete/' + id, {
                method: 'POST'
            })
                .then(response => response.json())
                .then(data => {
                    if (data.code === 200) {
                        alert('删除成功');
                        // 刷新页面
                        location.reload();
                    } else {
                        alert('删除失败：' + data.message);
                    }
                })
                .catch(error => {
                    alert('删除失败：' + error);
                });
        }
    }

    /**
     * 跳转到指定页码
     * @param page 页码
     */
    function goToPage(page) {
        if (page < 1 || page > ${pageResult.totalPages}) {
            return;
        }

        // 获取搜索表单中的参数
        const form = document.getElementById('searchForm');
        const params = new URLSearchParams(new FormData(form));
        params.set('currentPage', page);

        window.location.href = '${pageContext.request.contextPath}/user/list?' + params.toString();
    }

    /**
     * 清空搜索条件
     */
    function clearSearch() {
        document.querySelector('input[name="username"]').value = '';
        document.querySelector('input[name="realName"]').value = '';
        document.querySelector('input[name="phone"]').value = '';
        document.querySelector('select[name="role"]').value = '';
        document.querySelector('input[name="currentPage"]').value = '1';
        document.getElementById('searchForm').submit();
    }
</script>
</body>
</html>
