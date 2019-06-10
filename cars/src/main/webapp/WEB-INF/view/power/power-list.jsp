<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html class="x-admin-sm">
    <head>
        <base href="${basePath}">
        <meta charset="UTF-8">
        <title>欢迎页面-X-admin2.2</title>
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
            <a href="">演示</a>
            <a><cite>导航元素</cite></a>
          </span>
          <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新">
            <i class="layui-icon layui-icon-refresh" style="line-height:30px"></i>
          </a>
        </div>
        <div class="layui-fluid">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-body ">
                            <table class="layui-table" lay-filter="infoTable" id="infoTable"></table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script type="text/html" id="toolbar">
        <button type="button" class="layui-btn layui-btn-sm" onclick="xadmin.open('权限添加','power/toEdit.do',600,400)">添加</button>
    </script>
    <script type="text/html" id="status">
        <input type="checkbox" name="status" lay-skin="switch" lay-text="可用|禁用" lay-filter="statusDemo">
    </script>
    <script type="text/html" id="opt">
        <button type="button" class="layui-btn layui-btn-sm" lay-event="edit">修改</button>
        <button type="button" class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
    </script>
    <script>
        $(function () {
            layui.use(['table'], function(){
                var table = layui.table;
                table.render({
                    elem: '#infoTable'
                    ,url:'power/getAll.do'
                    ,method:'get'
                    ,toolbar: '#toolbar'
                    ,cols: [[
                        {field:'id', title: '编号', sort: true}
                        ,{field:'power', title: '权限名'}
                        ,{field:'status', title: '状态', templet: '#status'}
                        ,{field:'createDate', title: '创建时间'}
                        ,{field:'createAdmin', title: '创建人'}
                        ,{field:'updateDate', title: '修改时间'}
                        ,{field:'updateAdmin', title: '修改人'}
                        ,{title:'操作',fixed:'right',toolbar:'#opt'}
                    ]]
                });
                table.on('tool(infoTable)',function (data) {
                    if (data.event=='del'){
                        layer.confirm("确认删除本数据吗?",function () {
                            $.ajax({
                                url: 'power/delete.do',
                                data:{
                                    id:data.data.id
                                },
                                method: 'post',
                                dataType:'json',
                                success:function (res) {
                                    layer.alert(res.msg,function (index) {
                                        layer.close(index);
                                        if (res.code==1){
                                            table.reload('infoTable');//重载表格
                                        }
                                    });
                                },
                                error:function (e) {
                                    console.log(e);
                                    layer.alert("与服务器连接失败!请稍后再试...",{icon:5});
                                }
                            });
                        });
                    }
                });
            });
        });
    </script>
</html>