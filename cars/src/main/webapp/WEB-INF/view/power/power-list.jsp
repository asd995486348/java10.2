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
        <script src="static/js/jquery.min.js"></script>
        <script src="static/lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="static/js/xadmin.js"></script>

        <!--[if lt IE 9]>
        <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
        <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
        <div class="x-nav">
          <span class="layui-breadcrumb">
            <a href="">首页</a>
            <a href="">权限</a>
            <a><cite>权限管理</cite></a>
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
    <script type="text/html" id="staTpl">
        <input type="checkbox" value="{{d.id}}" lay-text="可用|禁用" lay-skin="switch" lay-filter="staFilter" {{d.status==1?'checked':''}}>
    </script>
    <script type="text/html" id="opt">
        <button type="button" class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
    </script>
    <script>
        $(function () {
            layui.use(['form','table'], function(){
                var table = layui.table;
                var form = layui.form;
                table.render({
                    elem: '#infoTable'
                    ,url:'power/getAll.do'
                    ,method:'get'
                    ,toolbar: '#toolbar'
                    ,cols: [[
                        {field:'id', title: '编号', sort: true}
                        ,{field:'power', title: '权限名',edit:'text'}
                        ,{field:'status', title: '状态', templet: '#staTpl'}
                        ,{field:'createDate', title: '创建时间'}
                        ,{field:'createAdmin', title: '创建人'}
                        ,{field:'updateDate', title: '修改时间'}
                        ,{field:'updateAdmin', title: '修改人'}
                        ,{title:'操作',fixed:'right',toolbar:'#opt'}
                    ]]
                });

                form.on('switch(staFilter)',function (data) {
                    $.ajax({
                        url:'power/doEdit.do',
                        data:{
                            id:data.value,
                            status:data.elem.checked?1:2,
                        },
                        method:'post',
                        dataType: 'json',
                        success:function (res) {
                            layer.msg(res.msg,{icon:res.code==1?6:5});
                            table.reload('infoTable');
                        },
                        error:function (e) {
                            console.log(e);
                            layer.alert("与服务器连接失败!请稍后再试...");
                        }
                    });
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

                table.on('edit(infoTable)',function (obj) {
                    $.ajax({
                        url: 'power/doEdit.do',
                        data:{
                            id:obj.data.id,
                            power:obj.value
                        },
                        method: 'post',
                        dataType:'json',
                        success:function (res) {
                            layer.msg(res.msg,{icon:res.code==1?6:5,time:800});
                            table.reload('infoTable');
                        },
                        error:function (e) {
                            console.log(e);
                            layer.alert("与服务器连接失败!请稍后再试...",{icon:5});
                        }
                    });
                });
            });
        });
    </script>
</html>