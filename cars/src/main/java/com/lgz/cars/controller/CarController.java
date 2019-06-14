package com.lgz.cars.controller;

import com.lgz.cars.pojo.Brand;
import com.lgz.cars.pojo.Car;
import com.lgz.cars.service.BrandService;
import com.lgz.cars.service.CarService;
import com.lgz.cars.service.ImgsService;
import com.lgz.cars.util.ResBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
@RequestMapping("/cars")
public class CarController {
    @Autowired
    private CarService carService;
    @Autowired
    private BrandService brandService;
    @Autowired
    private ImgsService imgsService;

    @RequestMapping("/toList")
    public String toList(HttpServletRequest request){
        Brand brand=new Brand();
        brand.setPid(0);
        request.setAttribute("bl",brandService.getAll(brand));
        return "cars/cars-list";
    }

    @RequestMapping("/getPage")
    @ResponseBody
    public ResBean getPage(Integer page, Integer limit, Car car,HttpSession session){
        return carService.getPage(page,limit,car,session);
    }
    @RequestMapping("/toEdit")
    public String toEdit(HttpServletRequest request,Car car){
        if (car.getId()!=null){
            request.setAttribute("carInfo",carService.getById(car.getId()));
            request.setAttribute("imgList",imgsService.getByCarId(car.getId()));
        }
        return "cars/cars-edit";
    }
    @RequestMapping("/doEdit")
    @ResponseBody
    public ResBean doEdit(Car car, String[] carImgs, HttpSession session){
        return carService.update(car,carImgs,session);
    }
    @RequestMapping("/delete")
    @ResponseBody
    public ResBean delete(Car car){
        return carService.delete(car.getId());
    }

    @RequestMapping("/getImgsByCarId")
    @ResponseBody
    public Map<String,Object> getImgsByCarId(Car car){
        return imgsService.getImgsByCarId(car.getId());
    }
}
