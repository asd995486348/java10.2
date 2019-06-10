package com.lgz.cars.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
public class IndexController {
    @RequestMapping("/index")
    public String index(){
        return "index/index";
    }
    @RequestMapping("/welcome")
    public String welcome(){
        return "index/welcome";
    }
    @RequestMapping("/exit")
    public String exit(HttpSession session){
        session.removeAttribute("loginUser");
        return "redirect:/";
    }
}
