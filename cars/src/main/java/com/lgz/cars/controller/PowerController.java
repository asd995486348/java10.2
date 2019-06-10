package com.lgz.cars.controller;

import com.lgz.cars.pojo.Power;
import com.lgz.cars.service.PowerService;
import com.lgz.cars.util.ResBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/power")
public class PowerController {
    @Autowired
    private PowerService powerService;
    @RequestMapping("/toList")
    public String index(){
        return "power/power-list";
    }
    @RequestMapping("/getAll")
    @ResponseBody
    public ResBean getAll(Power power){
        List<Power> list=powerService.getAll(power);
        return new ResBean(0,list);
    }
    @RequestMapping("/toEdit")
    public String toEdit(HttpServletRequest request){
        request.setAttribute("pl",powerService.getAll(new Power(1)));
        return "power/power-edit";
    }
    @RequestMapping("/doEdit")
    @ResponseBody
    public ResBean update(Power power, HttpSession session){
        return powerService.update(power,session);
    }
    @RequestMapping("/delete")
    @ResponseBody
    public ResBean delete(Integer id){
        return powerService.delete(id);
    }
}
