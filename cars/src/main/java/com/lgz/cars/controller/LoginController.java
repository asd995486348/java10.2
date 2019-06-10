package com.lgz.cars.controller;

import com.lgz.cars.pojo.User;
import com.lgz.cars.service.UserService;
import com.lgz.cars.util.MD5Util;
import com.lgz.cars.util.ResBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpSession;

@Controller
public class LoginController {
    @Autowired
    private UserService userService;
    @RequestMapping("/login")
    @ResponseBody
    public ResBean login(User user, HttpSession session){
        user.setPassword(MD5Util.MD5(user.getPassword()));
        user=userService.login(user);
        if (user!=null){
            if (user.getStatus()==2){
                return new ResBean(0,"该账号被封号,请充值!");
            }else {
                session.setAttribute("loginUser",user);
                return new ResBean(1);
            }
        }else {
            return new ResBean(0,"用户名或密码不正确!");
        }
    }
}
