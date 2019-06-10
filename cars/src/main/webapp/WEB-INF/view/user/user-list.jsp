<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <!-- <link rel="stylesheet" href="./css/theme5.css"> -->
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
                        <div class="layui-card-body">
                            <form class="layui-form layui-col-space5">
                                <div class="layui-inline layui-show-xs-block">
                                    <input type="text" class="layui-input" name="username" placeholder="用户名">
                                </div>
                                <div class="layui-inline layui-show-xs-block">
                                    <input type="text" class="layui-input" name="realname" placeholder="真实姓名">
                                </div>
                                <div class="layui-inline layui-show-xs-block">
                                    <input type="text" class="layui-input" name="phone" placeholder="联系方式">
                                </div>
                                <div class="layui-inline layui-show-xs-block">
                                    <select name="status">
                                        <option value="">选择状态</option>
                                        <option value="1">可用</option>
                                        <option value="2">禁用</option>
                                    </select>
                                </div>
                                <div class="layui-inline layui-show-xs-block">
                                    <select name="powerid">
                                        <option value="">选择权限</option>
                                        <c:forEach items="${pl}" var="p">
                                            <option value="${p.id}">${p.power}</option>
                                        </c:forEach>
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
    <script type="text/html" id="toolbar">
        <button type="button" class="layui-btn layui-btn-sm" onclick="xadmin.open('用户添加','user/toEdit.do',600,400)">添加</button>
    </script>
    <script type="text/html" id="opt">
        <button type="button" class="layui-btn layui-btn-sm" lay-event="edit">修改</button>
        <button type="button" class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
    </script>
    <script type="text/html" id="staTpl">
        <input type="checkbox" value="{{d.id}}" lay-text="可用|禁用" lay-skin="switch" lay-filter="staFilter" {{d.status==1?'checked':''}}>
    </script>
    <script>
        $(function () {
            layui.use(['table','form'],function () {
                var table=layui.table;
                var form=layui.form;
                table.render({
                    elem:'#infoTable',
                    url:'user/getPage.do',
                    method:'get',
                    page: true,
                    toolbar: '#toolbar',
                    cols:[[
                        {field:'id',title:'编号',sort:true},
                        {field:'username',title:'用户名'},
                        {field:'realname',title:'真实姓名'},
                        {field:'phone',title:'联系方式'},
                        {field:'power',title:'权限'},
                        {field:'status',title:'状态',templet: '#staTpl'},
                        {title:'操作',fixed:'right',toolbar:'#opt'}
                    ]]
                });

                form.on('switch(staFilter)',function (data) {
                    $.ajax({
                        url:'user/doEdit.do',
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
                          url: 'user/delete.do',
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
                }else {
                    xadmin.open('用户信息','user/toEdit.do?id='+data.data.id,600,400);
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