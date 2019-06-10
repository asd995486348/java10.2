<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="x-admin-sm">
    <head>
        <base href="${basePath}">
        <meta charset="UTF-8">
        <title>密码修改</title>
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
                  <input type="hidden" name="id" value="${loginUser.id}">
                  <div class="layui-form-item">
                      <label for="username" class="layui-form-label">
                          <span class="x-red">*</span>登录名
                      </label>
                      <div class="layui-input-inline">
                          <input type="text" value="${loginUser.username}" id="username" name="username" disabled autocomplete="off" class="layui-input">
                      </div>
                  </div>
                  <div class="layui-form-item">
                      <label for="oldPwd" class="layui-form-label">
                          <span class="x-red">*</span>原密码
                      </label>
                      <div class="layui-input-inline">
                          <input type="password" id="oldPwd" name="oldPwd" required="" lay-verify="checkPwd" autocomplete="off" class="layui-input">
                      </div>
                  </div>

                  <div class="layui-form-item">
                        <label for="password" class="layui-form-label">
                            <span class="x-red">*</span>密码
                        </label>
                        <div class="layui-input-inline">
                            <input type="password" id="password" name="password" required="" lay-verify="pass"
                                   autocomplete="off" class="layui-input">
                        </div>
                        <div class="layui-form-mid layui-word-aux">
                            5到16个字符
                        </div>
                  </div>
                  <div class="layui-form-item">
                        <label for="L_repass" class="layui-form-label">
                            <span class="x-red">*</span>确认密码
                        </label>
                        <div class="layui-input-inline">
                            <input type="password" id="L_repass" name="repass" required="" lay-verify="repass" autocomplete="off" class="layui-input">
                        </div>
                  </div>

                  <div class="layui-form-item">
                      <label for="L_repass" class="layui-form-label">
                      </label>
                      <button  class="layui-btn" lay-filter="add" lay-submit="">
                          确认
                      </button>
                  </div>
              </form>
            </div>
        </div>
        <script>
            layui.use(['form', 'layer'],
            function() {
                var form = layui.form,
                    layer = layui.layer;
                //自定义验证规则
                form.verify({
                    pass: [/(.+){5,12}$/, '密码必须5到12位'],
                    repass: function(value) {
                        if ($('#password').val() != $('#L_repass').val()) {
                            return '两次密码不一致';
                        }
                    },
                    checkPwd:function (value) {
                        var ok=false;
                        var id='${loginUser.id}';
                        $.ajax({
                            url:'user/checkPwd.do',
                            data:{
                                password:value,
                                id:id
                            },
                            method:'get',
                            dataType:'json',
                            async:false,    //设置同步请求
                            success:function (res) {
                                ok=res.code==1;
                            },
                            error:function (e) {
                                console.log(e);
                                layer.msg("与服务器连接失败!请稍后重试...");
                            }
                        });
                        if (ok){
                            return "原密码不正确!";
                        }
                    }
                });
                //监听提交
                form.on('submit(add)',
                    function(data) {
                        $.ajax({
                            url: 'user/doEdit.do',
                            data:data.field,
                            method: 'post',
                            dataType: 'json',
                            success:function (res) {
                                layer.alert(res.msg,{icon:6},function () {
                                    if (res.code==1){
                                        layer.alert('请重新登录!',{icon: 7},function () {
                                           top.location.replace('exit.do');
                                        });
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
