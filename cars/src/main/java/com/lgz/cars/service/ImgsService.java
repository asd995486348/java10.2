package com.lgz.cars.service;

import com.lgz.cars.pojo.Imgs;

import java.util.List;
import java.util.Map;

public interface ImgsService {
    List<Imgs> getByCarId(Integer carId);

    Map<String,Object> getImgsByCarId(Integer carId);
}
