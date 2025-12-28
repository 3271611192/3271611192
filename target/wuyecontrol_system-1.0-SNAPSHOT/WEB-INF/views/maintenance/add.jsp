<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增设备维修记录</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .container { max-width: 800px; margin: 20px auto; padding: 20px; }
        .form-group { margin-bottom: 15px; }
        .form-label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-input { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        .form-textarea { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; resize: vertical; }
        .btn { padding: 10px 20px; margin-right: 10px; cursor: pointer; border: 1px solid #ddd; background: #fff; }
        .btn-primary { background: #007bff; color: white; }
    </style>
</head>
<body>
<div class="container">
    <h2>新增设备维修记录</h2>

    <form id="addForm">
        <div class="form-group">
            <label class="form-label">设备名称 *</label>
            <input type="text" id="deviceName" name="deviceName" class="form-input" required>
        </div>

        <div class="form-group">
            <label class="form-label">设备位置 *</label>
            <input type="text" id="deviceLocation" name="deviceLocation" class="form-input" required>
        </div>

        <div class="form-group">
            <label class="form-label">问题描述</label>
            <textarea id="problemDescription" name="problemDescription" class="form-textarea" rows="4"></textarea>
        </div>

        <div class="form-group">
            <label class="form-label">维修状态</label>
            <select id="repairStatus" name="repairStatus" class="form-input">
                <option value="待处理">待处理</option>
                <option value="处理中">处理中</option>
                <option value="已完成">已完成</option>
                <option value="已取消">已取消</option>
            </select>
        </div>

        <div class="form-group">
            <label class="form-label">优先级</label>
            <select id="priority" name="priority" class="form-input">
                <option value="高">高</option>
                <option value="中" selected>中</option>
                <option value="低">低</option>
            </select>
        </div>

        <div class="form-group">
            <label class="form-label">报告人</label>
            <input type="text" id="reporter" name="reporter" class="form-input">
        </div>

        <div class="form-group">
            <label class="form-label">报告人联系方式</label>
            <input type="text" id="reporterPhone" name="reporterPhone" class="form-input">
        </div>

        <div class="form-group">
            <label class="form-label">维修人员</label>
            <input type="text" id="repairPerson" name="repairPerson" class="form-input">
        </div>

        <div class="form-group">
            <label class="form-label">维修费用</label>
            <input type="number" id="repairCost" name="repairCost" class="form-input" step="0.01" min="0">
        </div>

        <div class="form-group">
            <label class="form-label">备注信息</label>
            <textarea id="remark" name="remark" class="form-textarea" rows="3"></textarea>
        </div>

        <div style="margin-top: 20px;">
            <button type="button" class="btn" onclick="back()">返回</button>
            <button type="submit" class="btn btn-primary">提交</button>
        </div>
    </form>
</div>

<script>
    $('#addForm').on('submit', function(e) {
        e.preventDefault();

        const formData = {
            deviceName: $('#deviceName').val(),
            deviceLocation: $('#deviceLocation').val(),
            problemDescription: $('#problemDescription').val(),
            repairStatus: $('#repairStatus').val(),
            priority: $('#priority').val(),
            reporter: $('#reporter').val(),
            reporterPhone: $('#reporterPhone').val(),
            repairPerson: $('#repairPerson').val(),
            repairCost: $('#repairCost').val() ? parseFloat($('#repairCost').val()) : null,
            remark: $('#remark').val()
        };

        $.ajax({
            url: '${pageContext.request.contextPath}/maintenance/add',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(formData),
            success: function(result) {
                if (result.code === 200) {
                    alert('新增成功');
                    window.location.href = '${pageContext.request.contextPath}/maintenance/list';
                } else {
                    alert('新增失败：' + result.msg);
                }
            },
            error: function() {
                alert('新增失败');
            }
        });
    });

    function back() {
        window.location.href = '${pageContext.request.contextPath}/maintenance/list';
    }
</script>
</body>
</html>
