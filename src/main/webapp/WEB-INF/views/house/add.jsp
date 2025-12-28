<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新增房屋 - 智慧物业管理系统</title>
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
            <h3>新增房屋</h3>
        </div>

        <div class="card-body">
            <form id="houseForm">
                <div class="form-group">
                    <label for="buildingNo">楼栋号:</label>
                    <input type="text" id="buildingNo" name="buildingNo" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="unitNo">单元号:</label>
                    <input type="text" id="unitNo" name="unitNo" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="roomNo">房号:</label>
                    <input type="text" id="roomNo" name="roomNo" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="area">房屋面积(平方米):</label>
                    <input type="number" step="0.01" id="area" name="area" class="form-control">
                </div>

                <div class="form-group">
                    <label for="houseType">房屋类型:</label>
                    <input type="text" id="houseType" name="houseType" class="form-control" value="住宅">
                </div>

                <div class="form-group">
                    <label for="status">房屋状态:</label>
                    <select id="status" name="status" class="form-control">
                        <option value="空置">空置</option>
                        <option value="自住">自住</option>
                        <option value="出租">出租</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="remark">备注:</label>
                    <textarea id="remark" name="remark" class="form-control"></textarea>
                </div>

                <div class="form-group">
                    <button type="submit" class="btn btn-primary">保存</button>
                    <a href="${pageContext.request.contextPath}/house/list" class="btn btn-secondary">取消</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.getElementById('houseForm').addEventListener('submit', function(e) {
        e.preventDefault();

        const formData = new FormData(this);
        const house = {};
        formData.forEach((value, key) => {
            if (value !== '') {
                if (key === 'area') {
                    house[key] = parseFloat(value);
                } else {
                    house[key] = value;
                }
            }
        });

        fetch('${pageContext.request.contextPath}/house/add', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(house)
        })
            .then(response => response.json())
            .then(data => {
                if (data.code === 200) {
                    alert('房屋添加成功');
                    window.location.href = '${pageContext.request.contextPath}/house/list';
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
