<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>编辑用户 - 智慧物业管理系统</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="container">
  <!-- 顶部导航栏 -->
  <nav class="navbar">
    <div class="navbar-brand">智慧物业管理系统</div>
    <div class="navbar-menu">
      <a href="${pageContext.request.contextPath}/index" class="nav-link">首页</a>
      <a href="${pageContext.request.contextPath}/user/list" class="nav-link">用户管理</a>
      <a href="${pageContext.request.contextPath}/owner/list" class="nav-link">业主管理</a>
      <a href="${pageContext.request.contextPath}/house/list" class="nav-link">房屋管理</a>
      <a href="${pageContext.request.contextPath}/payment/list" class="nav-link">缴费管理</a>
      <a href="${pageContext.request.contextPath}/logout" class="nav-link">退出登录</a>
    </div>
  </nav>

  <div class="card">
    <div class="card-header">
      <h3>编辑用户</h3>
    </div>

    <div class="card-body">
      <form id="userForm">
        <input type="hidden" id="id" name="id" value="${user.id}">

        <div class="form-group">
          <label for="username">用户名:</label>
          <input type="text" id="username" name="username" class="form-control" value="${user.username}" required>
        </div>

        <div class="form-group">
          <label for="password">密码 (留空表示不修改):</label>
          <input type="password" id="password" name="password" class="form-control">
        </div>

        <div class="form-group">
          <label for="realName">真实姓名:</label>
          <input type="text" id="realName" name="realName" class="form-control" value="${user.realName}" required>
        </div>

        <div class="form-group">
          <label for="phone">联系电话:</label>
          <input type="text" id="phone" name="phone" class="form-control" value="${user.phone}">
        </div>

        <div class="form-group">
          <label for="role">用户角色:</label>
          <select id="role" name="role" class="form-control">
            <option value="admin" ${user.role == 'admin' ? 'selected' : ''}>管理员</option>
            <option value="user" ${user.role == 'user' ? 'selected' : ''}>普通用户</option>
          </select>
        </div>

        <div class="form-group">
          <label for="status">账号状态:</label>
          <select id="status" name="status" class="form-control">
            <option value="1" ${user.status == 1 ? 'selected' : ''}>启用</option>
            <option value="0" ${user.status == 0 ? 'selected' : ''}>禁用</option>
          </select>
        </div>

        <div class="form-group">
          <button type="submit" class="btn btn-primary">保存</button>
          <a href="${pageContext.request.contextPath}/user/list" class="btn btn-secondary">取消</a>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  document.getElementById('userForm').addEventListener('submit', function(e) {
    e.preventDefault();

    const formData = new FormData(this);
    const user = {};
    formData.forEach((value, key) => {
      // Skip empty password fields
      if (key === 'password' && !value) return;
      user[key] = value;
    });

    fetch('${pageContext.request.contextPath}/user/update', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(user)
    })
            .then(response => response.json())
            .then(data => {
              if (data.code === 200) {
                alert('用户更新成功');
                window.location.href = '${pageContext.request.contextPath}/user/list';
              } else {
                alert('更新失败: ' + data.msg);
              }
            })
            .catch(error => {
              console.error('Error:', error);
              alert('更新失败，请稍后重试');
            });
  });
</script>
</body>
</html>
