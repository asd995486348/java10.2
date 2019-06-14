package com.lgz.cars.mapper;

import com.lgz.cars.pojo.Imgs;

import java.util.List;

public interface ImgsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Imgs record);

    int insertSelective(Imgs record);

    Imgs selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Imgs record);

    int updateByPrimaryKey(Imgs record);

    int batchInsert(List<Imgs> list);

    List<Imgs> getByCarId(Integer carId);

    int deleteByCarId(Integer id);
}