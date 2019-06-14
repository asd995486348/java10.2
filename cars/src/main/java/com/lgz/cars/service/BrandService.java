package com.lgz.cars.service;

import com.lgz.cars.pojo.Brand;
import com.lgz.cars.util.ResBean;

import javax.servlet.http.HttpSession;
import java.util.List;

public interface BrandService {
    List<Brand> getAll(Brand brand);

    ResBean getChildren(Brand brand);

    ResBean delete(Integer id);

    ResBean update(Brand brand, HttpSession session);

    ResBean updateStatus(Brand brand,HttpSession session);

    Brand getById(Integer id);
}
