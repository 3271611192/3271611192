<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>缴费记录列表 - 智慧物业管理系统</title>
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
            <!-- 一键返回上一页按钮 -->
            <a href="javascript:history.back()" class="nav-link">返回上一页</a>
            <a href="${pageContext.request.contextPath}/index" class="nav-link">返回首页</a>
            <a href="${pageContext.request.contextPath}/logout" class="nav-link">退出登录</a>
        </div>
    </nav>

    <!-- 缴费记录列表卡片 -->
    <div class="card">
        <div class="card-header">
            缴费记录管理
            <button class="btn btn-success" style="float: right;"
                    onclick="location.href='${pageContext.request.contextPath}/payment/add'">
                新增缴费记录
            </button>
        </div>

        <!-- 搜索表单 -->
        <div class="search-form">
            <form id="searchForm" action="${pageContext.request.contextPath}/payment/list" method="get">
                <input type="hidden" name="currentPage" value="${empty param.currentPage ? 1 : param.currentPage}">
                <div class="form-row">
                    <div class="form-group">
                        <label>业主ID:</label>
                        <input type="number" name="ownerId" value="${param.ownerId}" placeholder="请输入业主ID">
                    </div>
                    <div class="form-group">
                        <label>房屋ID:</label>
                        <input type="number" name="houseId" value="${param.houseId}" placeholder="请输入房屋ID">
                    </div>
                    <div class="form-group">
                        <label>费用类型:</label>
                        <select name="paymentType">
                            <option value="">全部</option>
                            <option value="物业费" ${param.paymentType eq '物业费' ? 'selected' : ''}>物业费</option>
                            <option value="水费" ${param.paymentType eq '水费' ? 'selected' : ''}>水费</option>
                            <option value="电费" ${param.paymentType eq '电费' ? 'selected' : ''}>电费</option>
                            <option value="燃气费" ${param.paymentType eq '燃气费' ? 'selected' : ''}>燃气费</option>
                            <option value="停车费" ${param.paymentType eq '停车费' ? 'selected' : ''}>停车费</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>缴费状态:</label>
                        <select name="status">
                            <option value="">全部</option>
                            <option value="0" ${param.status eq '0' ? 'selected' : ''}>未缴费</option>
                            <option value="1" ${param.status eq '1' ? 'selected' : ''}>已缴费</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">搜索</button>
                        <button type="button" class="btn btn-secondary" onclick="clearSearch()">清空</button>
                    </div>
                </div>
            </form>
        </div>

        <!-- 缴费记录列表表格 -->
        <table class="table">
            <thead>
            <tr>
                <th>ID</th>
                <th>业主ID</th>
                <th>房屋ID</th>
                <th>费用类型</th>
                <th>金额(元)</th>
                <th>账单月份</th>
                <th>缴费状态</th>
                <th>缴费时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <!-- 遍历缴费记录列表数据 -->
            <c:forEach items="${pageResult.data}" var="payment">
                <tr>
                    <td>${payment.id}</td>
                    <td>${payment.ownerId}</td>
                    <td>${payment.houseId}</td>
                    <td>${payment.paymentType}</td>
                    <td>${payment.amount}</td>
                    <td>${payment.billingMonth}</td>
                    <td>
                        <c:choose>
                            <c:when test="${payment.status == 1}">
                                <span style="color: #00b894;">已缴费</span>
                            </c:when>
                            <c:otherwise>
                                <span style="color: #d63031;">未缴费</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty payment.paymentTime}">
                                <fmt:formatDate value="${payment.paymentTime}" pattern="yyyy-MM-dd HH:mm"/>
                            </c:when>
                            <c:otherwise>
                                -
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <!-- 操作按钮组 -->
                        <div class="action-btns">
                            <button class="btn btn-primary" style="padding: 5px 12px; font-size: 12px;"
                                    onclick="location.href='${pageContext.request.contextPath}/payment/edit/${payment.id}'">
                                编辑
                            </button>
                            <button class="btn btn-danger" style="padding: 5px 12px; font-size: 12px;"
                                    onclick="deletePayment(${payment.id})">
                                删除
                            </button>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            <!-- 无数据提示 -->
            <c:if test="${empty pageResult.data}">
                <tr>
                    <td colspan="9" style="text-align: center; color: #999;">暂无数据</td>
                </tr>
            </c:if>
            </tbody>
        </table>

        <!-- 分页组件 -->
        <div class="pagination">
            <button class="pagination-btn"
                    onclick="goToPage(${pageResult.currentPage - 1})"
            ${!pageResult.hasPrevious ? 'disabled' : ''}>
                上一页
            </button>

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
     * 删除缴费记录函数
     * 弹出确认对话框，确认后发送删除请求
     * @param id 缴费记录ID
     */
    function deletePayment(id) {
        if (confirm('确认要删除该缴费记录吗？')) {
            fetch('${pageContext.request.contextPath}/payment/delete/' + id, {
                method: 'POST'
            })
                .then(response => response.json())
                .then(data => {
                    if (data.code === 200) {
                        alert('删除成功');
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

        window.location.href = '${pageContext.request.contextPath}/payment/list?' + params.toString();
    }

    /**
     * 清空搜索条件
     */
    function clearSearch() {
        document.querySelector('input[name="ownerId"]').value = '';
        document.querySelector('input[name="houseId"]').value = '';
        document.querySelector('select[name="paymentType"]').value = '';
        document.querySelector('select[name="status"]').value = '';
        document.querySelector('input[name="currentPage"]').value = '1';
        document.getElementById('searchForm').submit();
    }
</script>
</body>
</html>
