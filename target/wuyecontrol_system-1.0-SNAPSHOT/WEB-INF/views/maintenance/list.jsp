<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>设备维修记录列表</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .container { padding: 20px; }
        .search-box { margin-bottom: 20px; padding: 15px; background: #f5f5f5; border-radius: 5px; }
        .search-item { margin-right: 15px; }
        .btn { padding: 8px 15px; margin-right: 5px; cursor: pointer; border: 1px solid #ddd; background: #fff; }
        .btn-primary { background: #007bff; color: white; }
        .table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        .table th, .table td { padding: 10px; border: 1px solid #ddd; text-align: left; }
        .table th { background: #f5f5f5; }
        .status-waiting { color: #ff9800; }
        .status-processing { color: #2196f3; }
        .status-completed { color: #4caf50; }
        .status-cancelled { color: #9e9e9e; }
        .priority-high { color: #f44336; }
        .priority-medium { color: #ff9800; }
        .priority-low { color: #4caf50; }
    </style>
</head>
<body>
<div class="container">
    <h2>设备维修记录列表</h2>

    <div class="search-box">
        <div style="display: flex; align-items: center;">
            <div class="search-item">
                <label>设备名称：</label>
                <input type="text" id="deviceName" placeholder="请输入设备名称">
            </div>
            <div class="search-item">
                <label>维修状态：</label>
                <select id="repairStatus">
                    <option value="">全部</option>
                    <option value="待处理">待处理</option>
                    <option value="处理中">处理中</option>
                    <option value="已完成">已完成</option>
                    <option value="已取消">已取消</option>
                </select>
            </div>
            <div class="search-item">
                <label>优先级：</label>
                <select id="priority">
                    <option value="">全部</option>
                    <option value="高">高</option>
                    <option value="中">中</option>
                    <option value="低">低</option>
                </select>
            </div>
            <div class="search-item">
                <label>报告人：</label>
                <input type="text" id="reporter" placeholder="请输入报告人">
            </div>
            <button class="btn btn-primary" onclick="search()">搜索</button>
            <button class="btn" onclick="resetSearch()">重置</button>
        </div>
    </div>

    <div style="margin-bottom: 15px;">
        <button class="btn btn-primary" onclick="add()">新增</button>
    </div>

    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>设备名称</th>
            <th>设备位置</th>
            <th>问题描述</th>
            <th>维修状态</th>
            <th>优先级</th>
            <th>报告人</th>
            <th>维修人员</th>
            <th>维修费用</th>
            <th>创建时间</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="dataList">
        <!-- 数据将通过JavaScript动态填充 -->
        </tbody>
    </table>

    <div id="pagination" style="margin-top: 20px; text-align: center;">
        <!-- 分页将通过JavaScript动态填充 -->
    </div>
</div>

<script>
    let currentPage = 1;
    const pageSize = 10;

    $(document).ready(function() {
        console.log('页面加载完成，开始加载数据');
        loadPage(currentPage);
    });

    function loadPage(pageNum) {
        console.log('加载第 ' + pageNum + ' 页数据');
        const params = {
            deviceName: $('#deviceName').val(),
            repairStatus: $('#repairStatus').val(),
            priority: $('#priority').val(),
            reporter: $('#reporter').val(),
            pageNum: pageNum,
            pageSize: pageSize
        };

        $.get('${pageContext.request.contextPath}/maintenance/page', params, function(result) {
            console.log('API响应:', result);
            if (result.code === 200) {
                const data = result.data;
                console.log('分页数据:', data);
                renderTable(data.data);  // 修改：从 data.list 改为 data.data
                renderPagination(data);
            } else {
                alert('获取数据失败：' + result.msg);
            }
        }).fail(function(xhr, status, error) {
            console.error('请求失败:', error);
            console.log('响应内容:', xhr.responseText);
            alert('请求失败：' + error);
        });
    }

    function renderTable(list) {
        console.log('渲染表格，数据量：', list ? list.length : 0);
        let html = '';
        if (list && list.length > 0) {
            for (let i = 0; i < list.length; i++) {
                const item = list[i];
                console.log('渲染项目:', item);
                html += '<tr>';
                html += '<td>' + item.id + '</td>';
                html += '<td>' + (item.deviceName || '') + '</td>';
                html += '<td>' + (item.deviceLocation || '') + '</td>';
                html += '<td>' + (item.problemDescription || '') + '</td>';
                html += '<td><span class="status-' + getStatusClass(item.repairStatus) + '">' + (item.repairStatus || '') + '</span></td>';
                html += '<td><span class="priority-' + (item.priority ? item.priority.toLowerCase() : 'default') + '">' + (item.priority || '') + '</span></td>';
                html += '<td>' + (item.reporter || '') + '</td>';
                html += '<td>' + (item.repairPerson || '') + '</td>';
                html += '<td>' + (item.repairCost ? '¥' + parseFloat(item.repairCost).toFixed(2) : '') + '</td>';
                html += '<td>' + (item.createTime ? new Date(item.createTime).toLocaleString() : '') + '</td>';
                html += '<td>';
                html += '<button class="btn" onclick="edit(' + item.id + ')">编辑</button>';
                html += '<button class="btn" onclick="del(' + item.id + ')">删除</button>';
                html += '</td>';
                html += '</tr>';
            }
        } else {
            html += '<tr><td colspan="11" style="text-align: center;">暂无数据</td></tr>';
        }
        $('#dataList').html(html);
    }

    function renderPagination(pageData) {
        console.log('渲染分页:', pageData);
        const currentPage = pageData.currentPage || 1;
        const totalPages = pageData.totalPages || 0;
        const total = pageData.total || 0;
        const pageSize = pageData.pageSize || 10;

        let html = '<div style="display: flex; justify-content: center; align-items: center; gap: 10px;">';
        html += '<span>共 ' + total + ' 条，第 ' + currentPage + ' 页/共 ' + totalPages + ' 页</span>';

        if (totalPages <= 1) {
            $('#pagination').html(html + '</div>');
            return;
        }

        if (currentPage > 1) {
            html += '<button class="btn" onclick="goPage(' + (currentPage - 1) + ')">上一页</button>';
        }

        // 显示页码
        const startPage = Math.max(1, currentPage - 2);
        const endPage = Math.min(totalPages, currentPage + 2);

        if (startPage > 1) {
            html += '<button class="btn" onclick="goPage(1)">1</button>';
            if (startPage > 2) {
                html += '<span>...</span>';
            }
        }

        for (let i = startPage; i <= endPage; i++) {
            if (i === currentPage) {
                html += '<button class="btn btn-primary" disabled>' + i + '</button>';
            } else {
                html += '<button class="btn" onclick="goPage(' + i + ')">' + i + '</button>';
            }
        }

        if (endPage < totalPages) {
            if (endPage < totalPages - 1) {
                html += '<span>...</span>';
            }
            html += '<button class="btn" onclick="goPage(' + totalPages + ')">' + totalPages + '</button>';
        }

        if (currentPage < totalPages) {
            html += '<button class="btn" onclick="goPage(' + (currentPage + 1) + ')">下一页</button>';
        }

        html += '</div>';
        $('#pagination').html(html);
    }

    function goPage(pageNum) {
        console.log('跳转到第 ' + pageNum + ' 页');
        currentPage = pageNum;
        loadPage(currentPage);
    }

    function search() {
        console.log('执行搜索');
        currentPage = 1;
        loadPage(currentPage);
    }

    function resetSearch() {
        console.log('重置搜索条件');
        $('#deviceName').val('');
        $('#repairStatus').val('');
        $('#priority').val('');
        $('#reporter').val('');
        currentPage = 1;
        loadPage(currentPage);
    }

    function add() {
        console.log('新增记录');
        window.location.href = '${pageContext.request.contextPath}/maintenance/add';
    }

    function edit(id) {
        console.log('编辑记录 ID: ' + id);
        window.location.href = '${pageContext.request.contextPath}/maintenance/edit/' + id;
    }

    function del(id) {
        console.log('删除记录 ID: ' + id);
        if (confirm('确定要删除这条维修记录吗？')) {
            $.ajax({
                url: '${pageContext.request.contextPath}/maintenance/delete/' + id,
                type: 'POST',
                success: function(result) {
                    console.log('删除结果:', result);
                    if (result.code === 200) {
                        alert('删除成功');
                        loadPage(currentPage);
                    } else {
                        alert('删除失败：' + result.msg);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('删除失败:', error);
                    alert('删除失败: ' + error);
                }
            });
        }
    }

    function getStatusClass(status) {
        switch(status) {
            case '待处理': return 'waiting';
            case '处理中': return 'processing';
            case '已完成': return 'completed';
            case '已取消': return 'cancelled';
            default: return 'default';
        }
    }
</script>
</body>
</html>
