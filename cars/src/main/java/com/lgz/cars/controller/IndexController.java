package com.lgz.cars.controller;

import com.lgz.cars.util.ImageUtil;
import com.lgz.cars.util.ResBean;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
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
    @RequestMapping("/upload")
    @ResponseBody
    public ResBean upload(HttpServletRequest request, @RequestParam("file")MultipartFile[] files){
        String path=request.getServletContext().getRealPath("/static/upload")+"/";
        String fileName= ImageUtil.uploadImg(path,files);
        if (StringUtils.isNotEmpty(fileName)){
            return new ResBean(1,fileName);
        }
        return new ResBean(0);
    }
}
