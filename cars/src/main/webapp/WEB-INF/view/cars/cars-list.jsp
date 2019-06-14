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
                <a href="">车辆管理</a>
                <a><cite>车辆列表</cite></a>
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
    <script type="text/html" id="toolbar">
        <c:if test="${loginUser.powerid<3}">
            <button type="button" class="layui-btn layui-btn-sm" onclick="xadmin.open('车辆添加','cars/toEdit.do',600,600)">添加</button>
        </c:if>
    </script>
    <script type="text/html" id="imgBar">
        <button type="button" class="layui-btn layui-btn-sm" lay-event="showImg">查看</button>
    </script>
    <script type="text/html" id="opt">
        <c:choose>
            <c:when test="${loginUser.powerid<3}">
                <button type="button" class="layui-btn layui-btn-sm" lay-event="edit">修改</button>
                <button type="button" class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
            </c:when>
            <c:otherwise>
                <button type="button" class="layui-btn layui-btn-sm" lay-event="borrow">借车</button>
            </c:otherwise>
        </c:choose>
    </script>
    <script type="text/html" id="staTpl">
        <c:choose>
            <c:when test="${loginUser.powerid<3}">
                <input type="checkbox" value="{{d.id}}" lay-text="可用|禁用" lay-skin="switch" lay-filter="staFilter" {{d.status==1?'checked':''}}>
            </c:when>
            <c:otherwise>
                {{d.status==1?'可用':'禁用'}}
            </c:otherwise>
        </c:choose>
    </script>
    <script>
        $(function () {
            layui.use(['table','form'],function () {
                var table=layui.table;
                var form=layui.form;
                table.render({
                    elem:'#infoTable',
                    url:'cars/getPage.do',
                    method:'get',
                    page: true,
                    toolbar: '#toolbar',
                    cols:[[
                        {field:'id',title:'编号',sort:true},
                        {field:'brand',title:'品牌'},
                        {field:'color',title:'颜色'},
                        {field:'carno',title:'车牌'},
                        {field:'carage',title:'车龄'},
                        {field:'bcount',title:'被借次数',sort: true},
                        {field:'isborrow',title:'是否可借',sort: true,templet: borrowFun},
                        {field:'status',title:'状态',templet: '#staTpl'},
                        {title:'车况图',toolbar:'#imgBar'},
                        {title:'操作',fixed:'right',toolbar:'#opt'}
                    ]]
                });

                function borrowFun(d){
                    if (d.isborrow==1){
                        return '已借';
                    }
                    return '可借';
                }

                form.on('select(bp)',function (data) {
                    if (data.value==0){
                        clearBrand();
                        return;
                    }
                    $.ajax({
                        url:'brand/getPage.do',
                        data:{
                            pid:data.value
                        },
                        method:'get',
                        dataType:'json',
                        success:function (res) {
                            var ops='';
                            for (var i=0;i<res.length;i++){
                                ops+='<option value="'+res[i].id+'">'+res[i].brand+'</option>';
                            }
                            $('#brandid').empty().append(ops);
                            form.render();
                        },
                        error:function (e) {
                            layer.alert("获取品牌型号异常!请稍后再试...");
                            console.log(e);
                        }
                    });
                });

                form.on('switch(staFilter)',function (data) {
                    $.ajax({
                        url:'cars/doEdit.do',
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
                    if (data.data.isborrow==1){
                        layer.alert("本车已被借出,不能删除!");
                        return;
                    }
                    layer.confirm("确认删除本数据吗?",function () {
                      $.ajax({
                          url: 'cars/delete.do',
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
                }else if (data.event=='edit') {
                    xadmin.open('车辆信息','cars/toEdit.do?id='+data.data.id,600,600);
                }else if (data.event=='borrow') {
                    xadmin.open('借车申请','record/toApply.do?id='+data.data.id,600,600);
                }else {
                    $.getJSON('cars/getImgsByCarId.do?id='+data.data.id,function (res) {
                        if (res.data.length>0){
                            layer.photos({
                                photos: res
                            });
                        }else {
                            layer.alert('暂无车况图片',{icon:7});
                        }
                    });
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
                    clearBrand();
                });

                function clearBrand() {
                    var opt='<option value="">选择型号</option>';
                    $('#brandid').empty().append(opt);
                    form.render();
                }
            });
        });
    </script>
</html>