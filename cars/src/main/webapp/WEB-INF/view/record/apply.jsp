<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="x-admin-sm">
<head>
    <base href="${basePath}">
    <meta charset="UTF-8">
    <title>借车申请单</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="static/css/font.css">
    <link rel="stylesheet" href="static/css/xadmin.css">
    <link rel="stylesheet" href="static/css/selectY.css">
    <!-- <link rel="stylesheet" href="./css/theme5.css"> -->
    <script src="static/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="static/js/xadmin.js"></script>
    <script src="static/js/jquery.min.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div class="layui-fluid">
    <div class="layui-row">
        <form class="layui-form">
            <input type="hidden" name="id" value="${record.id}">

            <div class="layui-form-item">
                <label class="layui-form-label">
                    借车人
                </label>
                <div class="layui-input-inline">
                    <input type="text" value="${loginUser.realname}" disabled class="layui-input" lay-verify="required">
                    <input type="hidden" value="${loginUser.id}" name="uid">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">
                    车牌号
                </label>
                <div class="layui-input-inline">
                    <input type="text" value="${carInfo.carno}" disabled class="layui-input">
                    <input type="hidden" value="${carInfo.id}" name="carid">
                </div>
            </div>

            <div class="layui-form-item">
                <label for="btime" class="layui-form-label">
                    <span class="x-red">*</span>借车时间
                </label>
                <div class="layui-input-inline">
                    <input type="text" value="${record.btime}" id="btime" name="btime" required="" lay-verify="required"
                           autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label for="address" class="layui-form-label">
                    <span class="x-red">*</span>目的地
                </label>
                <div class="layui-input-inline">
                    <textarea name="address" id="address" class="layui-textarea" required lay-verify="required"
                              placeholder="请输入目的地"></textarea>
                </div>
            </div>

            <div class="layui-form-item">
                <label for="bmsg" class="layui-form-label">用车原因</label>
                <div class="layui-input-inline">
                    <textarea name="bmsg" id="bmsg" class="layui-textarea" placeholder="请输入用车原因"></textarea>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">
                </label>
                <button class="layui-btn" lay-filter="add" lay-submit="">
                    申请
                </button>
            </div>
        </form>
    </div>
</div>
<script>
    layui.use(['form','laydate'],
        function () {
            var form = layui.form;
            var laydate = layui.laydate;

            laydate.render({
                elem:'#btime',
                type: 'datetime'
            });

            //监听提交
            form.on('submit(add)', function (data) {
                $.ajax({
                    url: 'record/doEdit.do',
                    data: data.field,
                    method: 'post',
                    dataType: 'json',
                    success: function (res) {
                        layer.alert(res.msg, {icon: 6}, function () {
                            if (res.code == 1) {
                                //关闭当前frame
                                xadmin.close();
                                // 可以对父窗口进行刷新
                                xadmin.father_reload();
                            }
                        });
                    },
                    error: function (e) {
                        layer.alert("与服务器连接失败!请稍后重试...");
                        console.log(e);
                    }
                });
                return false;
            });
        });
</script>
</body>
</html>
