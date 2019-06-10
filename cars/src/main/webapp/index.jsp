<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html  class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>逆时光网咖</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="static/css/font.css">
    <link rel="stylesheet" href="static/css/login.css">
    <link rel="stylesheet" href="static/css/xadmin.css">
    <script type="text/javascript" src="static/js/jquery.min.js"></script>
    <script src="static/lib/layui/layui.js" charset="utf-8"></script>
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body class="login-bg">

<div class="login layui-anim layui-anim-up">
    <div class="message">逆时光后台登录</div>
    <div id="darkbannerwrap"></div>

    <form method="post" class="layui-form" >
        <input name="username" placeholder="用户名" type="text" lay-verify="required" class="layui-input" >
        <hr class="hr15">
        <input name="password" placeholder="密码" type="password" lay-verify="required" class="layui-input">
        <hr class="hr15">
        <input value="登录" lay-submit lay-filter="login" style="width:100%;" type="submit">
        <hr class="hr20">
    </form>
</div>

<script>
    $(function  () {
        layui.use(['form'], function(){
            var form = layui.form;
            // layer.msg('玩命卖萌中', function(){
            //   //关闭后的操作
            //   });
            //监听提交
            form.on('submit(login)', function(data){
                $.ajax({
                    url:'login.do',
                    data:data.field,
                    method:'post',
                    dataType:'json',
                    success:function (res) {
                        if (res.code==1){
                            location.replace('index.do');
                        }else {
                            layer.msg(res.msg);
                        }
                    },
                    error:function (e) {
                        console.log(e);
                        layer.alert('与服务器连接失败,请稍后再试!',{icon:5});
                    }
                });
                // alert(888)
                /*layer.msg(JSON.stringify(data.field),function(){
                    location.href='index.html'
                });*/
                return false;
            });
        });
    })
</script>
<!-- 底部结束 -->
</body>
</html>
