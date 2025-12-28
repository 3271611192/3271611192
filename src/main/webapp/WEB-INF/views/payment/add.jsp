<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>新增缴费记录 - 智慧物业管理系统</title>
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
      <h3>新增缴费记录</h3>
    </div>

    <div class="card-body">
      <form id="paymentForm">
        <div class="form-group">
          <label for="ownerId">业主ID:</label>
          <input type="number" id="ownerId" name="ownerId" class="form-control" required>
        </div>

        <div class="form-group">
          <label for="houseId">房屋ID:</label>
          <input type="number" id="houseId" name="houseId" class="form-control" required>
        </div>

        <div class="form-group">
          <label for="paymentType">费用类型:</label>
          <select id="paymentType" name="paymentType" class="form-control">
            <option value="物业费">物业费</option>
            <option value="水费">水费</option>
            <option value="电费">电费</option>
            <option value="燃气费">燃气费</option>
            <option value="停车费">停车费</option>
          </select>
        </div>

        <div class="form-group">
          <label for="amount">缴费金额:</label>
          <input type="number" step="0.01" id="amount" name="amount" class="form-control" required>
        </div>

        <div class="form-group">
          <label for="status">缴费状态:</label>
          <select id="status" name="status" class="form-control">
            <option value="0">未缴费</option>
            <option value="1">已缴费</option>
          </select>
        </div>

        <div class="form-group">
          <label for="paymentTime">缴费时间:</label>
          <input type="datetime-local" id="paymentTime" name="paymentTime" class="form-control">
        </div>

        <div class="form-group">
          <label for="billingMonth">账单月份:</label>
          <input type="month" id="billingMonth" name="billingMonth" class="form-control">
        </div>

        <div class="form-group">
          <label for="remark">备注:</label>
          <textarea id="remark" name="remark" class="form-control"></textarea>
        </div>

        <div class="form-group">
          <button type="submit" class="btn btn-primary">保存</button>
          <a href="${pageContext.request.contextPath}/payment/list" class="btn btn-secondary">取消</a>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  document.getElementById('paymentForm').addEventListener('submit', function(e) {
    e.preventDefault();

    const formData = new FormData(this);
    const payment = {};
    formData.forEach((value, key) => {
      if (value !== '') {
        if (key === 'amount') {
          payment[key] = parseFloat(value);
        } else if (key === 'ownerId' || key === 'houseId' || key === 'status') {
          payment[key] = parseInt(value);
        } else if (key === 'paymentTime') {
          payment[key] = new Date(value).toISOString();
        } else if (key === 'billingMonth') {
          payment[key] = value; // Already in format yyyy-MM
        } else {
          payment[key] = value;
        }
      }
    });

    fetch('${pageContext.request.contextPath}/payment/add', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(payment)
    })
            .then(response => response.json())
            .then(data => {
              if (data.code === 200) {
                alert('缴费记录添加成功');
                window.location.href = '${pageContext.request.contextPath}/payment/list';
              } else {
                alert('添加失败: ' + data.msg);
              }
            })
            .catch(error => {
              console.error('Error:', error);
              alert('添加失败，请稍后重试');
            });
  });
</script>
</body>
</html>
