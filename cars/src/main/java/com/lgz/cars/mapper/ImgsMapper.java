package com.lgz.cars.mapper;

import com.lgz.cars.pojo.Imgs;

public interface ImgsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Imgs record);

    int insertSelective(Imgs record);

    Imgs selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Imgs record);

    int updateByPrimaryKey(Imgs record);
}