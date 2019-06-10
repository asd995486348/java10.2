package com.lgz.cars.service;

import com.lgz.cars.pojo.Brand;
import com.lgz.cars.util.ResBean;

import java.util.List;

public interface BrandService {
    List<Brand> getAll(Brand brand);

    ResBean getChildren(Brand brand);
}
