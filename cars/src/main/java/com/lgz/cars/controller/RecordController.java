package com.lgz.cars.controller;

import com.lgz.cars.pojo.Car;
import com.lgz.cars.pojo.Record;
import com.lgz.cars.service.CarService;
import com.lgz.cars.service.RecordService;
import com.lgz.cars.util.ResBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/record")
public class RecordController {

    @Autowired
    private CarService carService;
    @Autowired
    private RecordService recordService;

    @RequestMapping("/toApply")
    public String toApply(HttpServletRequest request, Car car){
        request.setAttribute("carInfo",carService.getById(car.getId()));
        return "record/apply";
    }
    @RequestMapping("/doEdit")
    @ResponseBody
    public ResBean doEdit(Record record, HttpSession session){
        return recordService.update(record,session);
    }

    @RequestMapping("/borrowList")
    public String borrowList(Record record,HttpServletRequest request){
        request.setAttribute("apply",record.getApply());
        return "record/record-list";
    }

    @RequestMapping("/getPage")
    @ResponseBody
    public ResBean getPage(Integer page,Integer limit,Record record,HttpSession session){
        return recordService.getPage(page,limit,record,session);
    }
}
