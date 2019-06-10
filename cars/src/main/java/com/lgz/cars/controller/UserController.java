package com.lgz.cars.controller;

import com.lgz.cars.pojo.Power;
import com.lgz.cars.pojo.User;
import com.lgz.cars.service.PowerService;
import com.lgz.cars.service.UserService;
import com.lgz.cars.util.ResBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private PowerService powerService;
    @RequestMapping("/getById")
    @ResponseBody
    public User getUser(){
        return userService.getInfoById(1);
    }
    @RequestMapping("/toList")
    public String toList(HttpServletRequest request){
        User user= (User) request.getSession().getAttribute("loginUser");
        request.setAttribute("pl",powerService.getAll(new Power(user.getPowerid())));
        return "user/user-list";
    }
    @RequestMapping("/getPage")
    @ResponseBody
    public ResBean getPage(Integer page, Integer limit, User user){
        return userService.getPage(page,limit,user);
    }
    @RequestMapping("/toEdit")
    public String toEdit(HttpServletRequest request,Integer id){
        if (id!=null){
            request.setAttribute("user",userService.getById(id));
        }
        /*获取当前登录对象session*/
        User user= (User) request.getSession().getAttribute("loginUser");
        request.setAttribute("pl",powerService.getAll(new Power(user.getPowerid())));
        return "user/user-edit";
    }
    @RequestMapping("/checkUname")
    @ResponseBody
    public ResBean checkUname(String username){
        return userService.checkUname(username);
    }
    @RequestMapping("/doEdit")
    @ResponseBody
    public ResBean update(User user, HttpSession session){
        return userService.update(user,session);
    }
    @RequestMapping("/delete")
    @ResponseBody
    public ResBean delete(Integer id){
        return userService.delete(id);
    }
    @RequestMapping("/toPwd")
    public String toPwd(){
        return "user/user-pwd";
    }
    @RequestMapping("/checkPwd")
    @ResponseBody
    public ResBean checkPwd(User user){
        return userService.checkPwd(user);
    }
}
