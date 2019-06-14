package com.lgz.cars.service;

import com.lgz.cars.pojo.Car;
import com.lgz.cars.util.ResBean;

import javax.servlet.http.HttpSession;

public interface CarService {
    ResBean getPage(int page, int limit, Car car,HttpSession session);
    ResBean update(Car car, String[] carImgs, HttpSession session);
    Car getById(Integer id);
    ResBean delete(Integer id);
}
