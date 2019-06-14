package com.lgz.cars.service.impl;

import com.lgz.cars.mapper.BrandMapper;
import com.lgz.cars.pojo.Brand;
import com.lgz.cars.service.BrandService;
import com.lgz.cars.util.MyUtils;
import com.lgz.cars.util.ResBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
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

    @Override
    public ResBean delete(Integer id) {
        if (brandMapper.deleteByPrimaryKey(id)>0){
            return new ResBean(1,"删除成功!");
        }else {
            return new ResBean(0,"删除失败!");
        }
    }

    @Override
    public ResBean update(Brand brand, HttpSession session) {
        int result=0;
        if (brand.getId()==null){
            brand.setCreateAdmin(MyUtils.getLoginName(session));
            brand.setCreateDate(MyUtils.getNowTime());
            result=brandMapper.insertSelective(brand);
        }else {
            brand.setUpdateAdmin(MyUtils.getLoginName(session));
            brand.setUpdateDate(MyUtils.getNowTime());
            result=brandMapper.updateByPrimaryKeySelective(brand);
        }
        if (result>0){
            return new ResBean(1,"更新成功!");
        }
        return new ResBean(0,"更新失败!");
    }

    @Override
    public ResBean updateStatus(Brand brand,HttpSession session) {
        brand.setUpdateAdmin(MyUtils.getLoginName(session));
        brand.setUpdateDate(MyUtils.getNowTime());
        if (brandMapper.updateByPrimaryKeySelective(brand)>0){
            /*判断当前元素是否有子集元素*/
            brand.setPid(brand.getId());
            List<Brand> list=brandMapper.getAll(brand);
            if (list.size()>0){
                /*如果存在子集则修改所有子集状态和父级相同*/
                if (brandMapper.updateByPid(brand)==list.size()){
                    return new ResBean(1,"状态更新成功!");
                }else {
                    throw new Error("修改的子集个数与查询到的个数不同!");
                }
            }else {
                return new ResBean(1,"状态更新成功!");
            }
        }
        return new ResBean(0,"状态更新失败!");
    }

    @Override
    public Brand getById(Integer id) {
        return brandMapper.selectByPrimaryKey(id);
    }
}
