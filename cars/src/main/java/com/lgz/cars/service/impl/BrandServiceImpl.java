package com.lgz.cars.service.impl;

import com.lgz.cars.mapper.BrandMapper;
import com.lgz.cars.pojo.Brand;
import com.lgz.cars.service.BrandService;
import com.lgz.cars.util.ResBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class BrandServiceImpl implements BrandService {
    @Autowired
    private BrandMapper brandMapper;
    @Override
    public List<Brand> getAll(Brand brand) {
        return brandMapper.getAll(brand);
    }

    @Override
    public ResBean getChildren(Brand brand) {
        if (brandMapper.getAll(brand).size()>0){
            return new ResBean(0);
        }
        return new ResBean(1);
    }
}
