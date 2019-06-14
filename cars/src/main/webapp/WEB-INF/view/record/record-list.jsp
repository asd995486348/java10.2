<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html class="x-admin-sm">
    <head>
        <base href="${basePath}">
        <meta charset="UTF-8">
        <title>申请列表</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <link rel="stylesheet" href="static/css/font.css">
        <link rel="stylesheet" href="static/css/xadmin.css">
        <script src="static/lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="static/js/xadmin.js"></script>
        <script src="static/js/jquery.min.js"></script>
        <!--[if lt IE 9]>
        <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
        <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
        <div class="x-nav">
            <span class="layui-breadcrumb">
                <a href="">首页</a>
                <a href="">用车管理</a>
                <a><cite>借车记录</cite></a>
            </span>
            <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新">
                <i class="layui-icon layui-icon-refresh" style="line-height:30px"></i>
            </a>
        </div>
        <div class="layui-fluid">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-body">

                            <form class="layui-form layui-col-space5">
                                <div class="layui-inline layui-show-xs-block">
                                    <input type="text" class="layui-input" name="carno" placeholder="车牌号">
                                </div>

                                <c:if test="${loginUser.powerid<3}">
                                    <div class="layui-inline layui-show-xs-block">
                                        <select name="status">
                                            <option value="">选择状态</option>
                                            <option value="1">可用</option>
                                            <option value="2">禁用</option>
                                        </select>
                                    </div>
                                    <div class="layui-inline layui-show-xs-block">
                                        <select name="isborrow">
                                            <option value="">是否可借</option>
                                            <option value="1">可借</option>
                                            <option value="2">已借</option>
                                        </select>
                                    </div>
                                </c:if>

                                <div class="layui-inline layui-show-xs-block">
                                    <select name="bp" id="bp" lay-filter="bp">
                                        <option value="">选择品牌</option>
                                        <c:forEach items="${bl}" var="bp">
                                            <option value="${bp.id}">${bp.brand}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="layui-inline layui-show-xs-block">
                                    <select name="brandid" id="brandid">
                                        <option value="">选择型号</option>
                                    </select>
                                </div>

                                <div class="layui-inline layui-show-xs-block">
                                    <button class="layui-btn"  lay-submit="" lay-filter="search"><i class="layui-icon">&#xe615;</i></button>
                                    <button class="layui-btn" id="clear" type="button"><i class="iconfont">&#xe6aa;</i></button>
                                </div>
                            </form>

                            <table class="layui-table" lay-filter="infoTable" id="infoTable"></table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>

    <script type="text/html" id="opt">
        <button type="button" class="layui-btn layui-btn-sm" lay-event="edit">修改</button>
    </script>

    <script>
        $(function () {
            layui.use(['table','form'],function () {
                var table=layui.table;
                var form=layui.form;
                table.render({
                    elem:'#infoTable',
                    url:'record/getPage.do?apply=${apply}',
                    method:'get',
                    page: true,
                    toolbar: true,
                    cols:[[
                        {field:'id',title:'编号',sort:true},
                        {field:'realname',title:'借车人'},
                        {field:'carno',title:'车牌'},
                        {field:'btime',title:'用车时间'},
                        {field:'rtime',title:'还车时间'},
                        {field:'bmsg',title:'用车事由'},
                        {field:'address',title:'目的地'},
                        {field:'rmileage',title:'行驶里程'},
                        {field:'apply',title:'审核状态',sort: true,templet: applyFun},
                        {title:'操作',fixed:'right',toolbar:'#opt'}
                    ]]
                });

                function applyFun(d){
                    if (d.apply==10){
                        return '待审核';
                    }
                    if (d.apply==20){
                        return '已通过';
                    }
                    if (d.apply==30){
                        return '未通过';
                    }
                    if (d.apply==40){
                        return '已还车';
                    }
                    return '记录异常';
                }

                table.on('tool(infoTable)',function (data) {
                    if (data.event=='edit') {
                        xadmin.open('车辆信息','',600,600);
                    }
                });

                form.on('submit(search)',function (data) {
                    table.reload('infoTable',{
                        where:data.field
                    });
                    return false;
                });

                $('#clear').click(function () {
                    $(this).parents('form').find('input,select').val('');
                });
            });
        });
    </script>
</html>