<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html class="x-admin-sm">
    <head>
        <base href="${basePath}">
        <meta charset="UTF-8">
        <title>品牌列表</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <link rel="stylesheet" href="static/css/font.css">
        <link rel="stylesheet" href="static/css/xadmin.css">
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
        <div class="x-nav">
            <span class="layui-breadcrumb">
                <a href="">首页</a>
                <a href="">品牌管理</a>
                <a>
                    <cite>品牌列表</cite></a>
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
                            <form class="layui-form layui-col-space5">
                                <div class="layui-input-inline layui-show-xs-block">
                                    <input class="layui-input" placeholder="分类名" name="cate_name"></div>
                                <div class="layui-input-inline layui-show-xs-block">
                                    <button class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon"></i>增加</button>
                                </div>
                            </form>
                        </div>
                        <div class="layui-card-body ">
                            <table id="tableTree" class="layui-table layui-form">
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script type="text/html" id="staTpl">

        </script>
        <script>
          layui.config({
              /*设置第三方插件地址*/
              base:'static/lib/layui/lay/modules/'
          });
          layui.use(['form','table','treeTable'], function(){
            var form = layui.form;
            var treeTable=layui.treeTable;
            treeTable.render({
                elem:'#tableTree',
                url:'brand/getPage.do',
                icon_key:'brand',
                cols:[
                    {key:'id',title:'编号'},
                    {key:'brand',title:'品牌'},
                    {key:'pid',title:'父id'},
                    {key:'status',title:'状态',template:staTpl},
                    {title:'操作',template:optTpl}
                ],
                end:function () {
                    form.render();
                }
            });
          });

          function staTpl(obj) {
              var checked='';
              if(obj.status==1){
                  checked='checked';
              }
              return '<input type="checkbox" lay-text="可用|禁用" lay-skin="switch" lay-filter="staFilter" '+checked+' >';
          }

          function optTpl(obj) {
              var btns='';
              var editBtn='<button type="button" class="layui-btn">修改</button>';
              var addChildren='<button type="button" class="layui-btn">添加子项</button>';
              btns=editBtn+addChildren;
              $.ajax({
                  url: 'brand/getChildren.do',
                  data:{
                      pid:obj.id
                  },
                  dataType:'json',
                  async:false,
                  success:function (res) {
                      if (res.code==1){
                          btns+='<button type="button" class="layui-btn layui-btn-danger">删除</button>';
                      }
                  },
                  error:function (e) {
                      layer.alert('查询子选项出错!',{icon: 5});
                      console.log(e);
                  }
              });
              return btns;
          }

           /*用户-删除*/
          function member_del(obj,id){
              layer.confirm('确认要删除吗？',function(index){
                  //发异步删除数据
                  $(obj).parents("tr").remove();
                  layer.msg('已删除!',{icon:1,time:1000});
              });
          }

          // 分类展开收起的分类的逻辑
          $(function(){
            $("tbody.x-cate tr[fid!='0']").hide();
            // 栏目多级显示效果
            $('.x-show').click(function () {
                if($(this).attr('status')=='true'){
                    $(this).html('&#xe625;'); 
                    $(this).attr('status','false');
                    cateId = $(this).parents('tr').attr('cate-id');
                    $("tbody tr[fid="+cateId+"]").show();
               }else{
                    cateIds = [];
                    $(this).html('&#xe623;');
                    $(this).attr('status','true');
                    cateId = $(this).parents('tr').attr('cate-id');
                    getCateId(cateId);
                    for (var i in cateIds) {
                        $("tbody tr[cate-id="+cateIds[i]+"]").hide().find('.x-show').html('&#xe623;').attr('status','true');
                    }
               }
            })
          });

          var cateIds = [];
          function getCateId(cateId) {
              $("tbody tr[fid="+cateId+"]").each(function(index, el) {
                  id = $(el).attr('cate-id');
                  cateIds.push(id);
                  getCateId(id);
              });
          }
   
        </script>
    </body>
</html>
