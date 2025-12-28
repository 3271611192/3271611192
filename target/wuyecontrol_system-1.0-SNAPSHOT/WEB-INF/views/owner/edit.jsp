<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>编辑业主 - 智慧物业管理系统</title>
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
      <h3>编辑业主</h3>
    </div>

    <div class="card-body">
      <form id="ownerForm">
        <input type="hidden" id="id" name="id" value="${owner.id}">

        <div class="form-group">
          <label for="name">业主姓名:</label>
          <input type="text" id="name" name="name" class="form-control" value="${owner.name}" required>
        </div>

        <div class="form-group">
          <label for="gender">性别:</label>
          <select id="gender" name="gender" class="form-control">
            <option value="男" ${owner.gender == '男' ? 'selected' : ''}>男</option>
            <option value="女" ${owner.gender == '女' ? 'selected' : ''}>女</option>
          </select>
        </div>

        <div class="form-group">
          <label for="phone">联系电话:</label>
          <input type="text" id="phone" name="phone" class="form-control" value="${owner.phone}" required>
        </div>

        <div class="form-group">
          <label for="idCard">身份证号:</label>
          <input type="text" id="idCard" name="idCard" class="form-control" value="${owner.idCard}">
        </div>

        <div class="form-group">
          <label for="email">电子邮箱:</label>
          <input type="email" id="email" name="email" class="form-control" value="${owner.email}">
        </div>

        <div class="form-group">
          <label for="houseId">房屋ID:</label>
          <input type="number" id="houseId" name="houseId" class="form-control" value="${owner.houseId}">
        </div>

        <div class="form-group">
          <label for="remark">备注:</label>
          <textarea id="remark" name="remark" class="form-control">${owner.remark}</textarea>
        </div>

        <div class="form-group">
          <button type="submit" class="btn btn-primary">保存</button>
          <a href="${pageContext.request.contextPath}/owner/list" class="btn btn-secondary">取消</a>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  document.getElementById('ownerForm').addEventListener('submit', function(e) {
    e.preventDefault();

    const formData = new FormData(this);
    const owner = {};
    formData.forEach((value, key) => {
      if (value !== '') {
        owner[key] = value;
      }
    });

    fetch('${pageContext.request.contextPath}/owner/update', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(owner)
    })
            .then(response => response.json())
            .then(data => {
              if (data.code === 200) {
                alert('业主更新成功');
                window.location.href = '${pageContext.request.contextPath}/owner/list';
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
