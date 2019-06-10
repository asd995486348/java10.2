<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="x-admin-sm">
    <head>
        <base href="${basePath}">
        <meta charset="UTF-8">
        <title>用户编辑页</title>
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
                  <input type="hidden" name="id" value="${user.id}">
                  <div class="layui-form-item">
                      <label for="username" class="layui-form-label">
                          <span class="x-red">*</span>登录名
                      </label>
                      <div class="layui-input-inline">
                          <input type="text" value="${user.username}" id="username" name="username"required=""autocomplete="off" class="layui-input"
                          <c:choose>
                             <c:when test="${empty user}">
                                 lay-verify="required|nikename|username|rename"
                             </c:when>
                             <c:otherwise>disabled</c:otherwise>
                          </c:choose>
                          >
                      </div>
                      <div class="layui-form-mid layui-word-aux">
                          <span class="x-red">*</span>将会成为您唯一的登入名
                      </div>
                  </div>
                  <div class="layui-form-item">
                      <label for="phone" class="layui-form-label">
                          <span class="x-red">*</span>手机
                      </label>
                      <div class="layui-input-inline">
                          <input type="text" value="${user.phone}" id="phone" name="phone" required="" lay-verify="phone"
                          autocomplete="off" class="layui-input">
                      </div>
                  </div>
                  <div class="layui-form-item">
                      <label for="realname" class="layui-form-label">
                          <span class="x-red">*</span>真实姓名
                      </label>
                      <div class="layui-input-inline">
                          <input type="text" value="${user.realname}" id="realname" name="realname" required="" lay-verify="required"
                          autocomplete="off" class="layui-input">
                      </div>
                  </div>
                  <div class="layui-form-item">
                      <label class="layui-form-label"><span class="x-red">*</span>权限</label>
                      <div class="layui-input-inline">
                        <select name="powerid" id="powerid">
                            <c:forEach items="${pl}" var="p">
                                <option <c:if test="${p.id==user.powerid}">selected</c:if> value="${p.id}">${p.power}</option>
                            </c:forEach>
                        </select>
                      </div>
                  </div>
                  <c:if test="${empty user}">
                      <div class="layui-form-item">
                          <label for="password" class="layui-form-label">
                              <span class="x-red">*</span>密码
                          </label>
                          <div class="layui-input-inline">
                              <input type="password" id="password" name="password" required="" lay-verify="pass"
                                     autocomplete="off" class="layui-input">
                          </div>
                          <div class="layui-form-mid layui-word-aux">
                              6到16个字符
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
                  </c:if>
                  <div class="layui-form-item">
                      <label for="L_repass" class="layui-form-label">
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
                //自定义验证规则
                form.verify({
                    nikename: function(value) {
                        if (value.length < 5||value.length > 16) {
                            return '你这是外星人名字吧!长度不对啊';
                        }
                    },
                    pass: [/(.+){6,12}$/, '密码必须6到12位'],
                    repass: function(value) {
                        if ($('#password').val() != $('#L_repass').val()) {
                            return '两次密码不一致';
                        }
                    },
                    username:[/^[a-zA-Z0-9_]+$/,'用户名只能由字母、数字或下换线组成'],
                    rename:function (value) {
                        var ok=false;
                        $.ajax({
                            url:'user/checkUname.do',
                            data:{
                                username:value
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
                            return "用户名已存在!";
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
