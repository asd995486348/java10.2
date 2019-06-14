<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="x-admin-sm">
    <head>
        <base href="${basePath}">
        <meta charset="UTF-8">
        <title>品牌编辑页</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <link rel="stylesheet" href="static/css/font.css">
        <link rel="stylesheet" href="static/css/xadmin.css">
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
                  <input type="hidden" name="id" value="${br.id}">
                  <input type="hidden" name="pid" value="${pid}">
                  <div class="layui-form-item">
                      <label for="brand" class="layui-form-label">
                          <span class="x-red">*</span>品牌名
                      </label>
                      <div class="layui-input-inline">
                          <input type="text" value="${br.brand}" id="brand" name="brand" required="" autocomplete="off" class="layui-input" lay-verify="required">
                      </div>
                  </div>

                  <div class="layui-form-item">
                      <label class="layui-form-label">
                      </label>
                      <button  class="layui-btn" lay-filter="add" lay-submit="">
                          更新
                      </button>
                  </div>
              </form>
            </div>
        </div>
        <script>
            layui.use(['form', 'layer'],
            function() {
                $ = layui.jquery;
                var form = layui.form,
                    layer = layui.layer;
                //监听提交
                form.on('submit(add)',
                    function(data) {
                        $.ajax({
                            url: 'brand/doEdit.do',
                            data:data.field,
                            method: 'post',
                            dataType: 'json',
                            success:function (res) {
                                layer.alert(res.msg,{icon:6},function () {
                                    if (res.code==1){
                                        //关闭当前frame
                                        xadmin.close();
                                        // 可以对父窗口进行刷新
                                        xadmin.father_reload();
                                    }
                                });
                            },
                            error:function (e) {
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
