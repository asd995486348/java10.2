package com.lgz.cars.controller;

import com.lgz.cars.pojo.Brand;
import com.lgz.cars.service.BrandService;
import com.lgz.cars.util.ResBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/brand")
public class BrandController {
    @Autowired
    private BrandService brandService;
    @RequestMapping("/toList")
    public String toList(){
        return "brand/brand-list";
    }
    @RequestMapping("/getPage")
    @ResponseBody
    public List<Brand> getPage(){
        return brandService.getAll(new Brand());
    }
    @RequestMapping("/getChildren")
    @ResponseBody
    public ResBean getChildren(Brand brand){
        return brandService.getChildren(brand);
    }
}
