<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="x-admin-sm">
    <head>
        <base href="${basePath}">
        <meta charset="UTF-8">
        <title>车辆编辑</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <link rel="stylesheet" href="static/css/font.css">
        <link rel="stylesheet" href="static/css/xadmin.css">
        <link rel="stylesheet" href="static/css/selectY.css">
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
                  <input type="hidden" name="id" value="${carInfo.id}">
                  <div class="layui-form-item">
                      <label for="carno" class="layui-form-label">
                          <span class="x-red">*</span>车牌号
                      </label>
                      <div class="layui-input-inline">
                          <input type="text" value="${carInfo.carno}" id="carno" name="carno" required="" autocomplete="off" class="layui-input" lay-verify="required">
                      </div>
                  </div>
                  <div class="layui-form-item">
                      <label for="color" class="layui-form-label">
                          <span class="x-red">*</span>颜色
                      </label>
                      <div class="layui-input-inline">
                          <input type="text" value="${carInfo.color}" id="color" name="color" required="" lay-verify="required" autocomplete="off" class="layui-input">
                      </div>
                  </div>
                  <div class="layui-form-item">
                      <label for="carage" class="layui-form-label">
                          <span class="x-red">*</span>车龄
                      </label>
                      <div class="layui-input-inline">
                          <input type="text" value="${carInfo.carage}" id="carage" name="carage" required="" lay-verify="required"
                          autocomplete="off" class="layui-input">
                      </div>
                  </div>

                  <div class="layui-form-item">
                      <label for="brandid" class="layui-form-label">
                          <span class="x-red">*</span>品牌型号
                      </label>
                      <div class="layui-input-block">
                          <input type="hidden" id="brand" required lay-verify="required" value="${carInfo.brand}">
                          <input type="hidden" id="brandid" name="brandid" required lay-verify="required" value="${carInfo.brandid}">
                      </div>
                  </div>

                  <div class="layui-form-item">
                      <label for="imgs" class="layui-form-label">车况图</label>
                      <div class="layui-input-block">
                          <div class="layui-upload">
                              <button type="button" class="layui-btn" id="imgs">车况上传</button>
                              <button type="button" class="layui-btn layui-btn-danger" id="clearImg">清空预览</button>
                              <blockquote class="layui-elem-quote layui-quote-nm" style="margin-top: 10px;">
                                  预览图：
                                  <div class="layui-upload-list" id="imgList">
                                      <c:forEach items="${imgList}" var="il">
                                          <img style="margin: 5px" width="100" height="100" layer-src="static/upload/${il.img}" src="static/upload/${il.img}" alt="${il.img}" class="layui-upload-img">
                                      </c:forEach>
                                  </div>
                              </blockquote>
                          </div>
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
            layui.config({
                /*设置第三方插件地址*/
                base:'static/lib/layui/lay/modules/'
            });
            layui.use(['form', 'layer','selectY','upload'],
            function() {
                $ = layui.jquery;
                var form = layui.form,
                    layer = layui.layer,
                    selectY=layui.selectY,
                    upload=layui.upload;

                layer.photos({
                    photos:'#imgList'
                });

                upload.render({
                    elem: '#imgs',
                    url:'upload.do',
                    multiple:true,
                    auto:true,
                    done:function (res) {
                        if (res.code==1){
                            $('#imgList').append('<img style="margin: 5px" width="100" height="100" layer-src="static/upload/'+res.msg+'" src="static/upload/'+ res.msg +'" alt="'+ res.msg +'" class="layui-upload-img">');
                            layer.photos({
                                photos:'#imgList'
                            });
                        }
                    }
                });

                $('#clearImg').click(function () {
                    var imgs=$('#imgList img').length;
                    if (imgs>0){
                        layer.confirm("确定清空预览图片吗?",function (index) {
                            $('#imgList').empty();
                            layer.close(index);
                        });
                    }
                });

                selectY({
                    elem:'#brand',
                    url: 'brand/getPage.do',
                    placeholder:'品牌型号',
                    success:function (data) {
                        var brandid=data.ids[1];
                        $('#brandid').val(brandid);
                    }
                });

                //监听提交
                form.on('submit(add)', function(data) {
                    /*获取所有的图片*/
                    var imgs=$('#imgList').find('img');
                    /*存放图片的空数组*/
                    var carImgs=new Array();
                    /*有图片则遍历所有图片追加到数组*/
                    if (imgs.length>0){
                        imgs.each(function () {
                            var imgName=$(this).prop('alt');
                            carImgs.push(imgName);
                        });
                    }
                    /*数组转字符串*/
                    carImgs+='';
                    /*把carImgs加入到data中*/
                    data.field.carImgs=carImgs;
                    console.log(data);
                        $.ajax({
                            url: 'cars/doEdit.do',
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
