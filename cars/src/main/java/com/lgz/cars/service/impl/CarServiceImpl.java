package com.lgz.cars.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lgz.cars.mapper.CarMapper;
import com.lgz.cars.mapper.ImgsMapper;
import com.lgz.cars.pojo.Car;
import com.lgz.cars.pojo.Imgs;
import com.lgz.cars.service.CarService;
import com.lgz.cars.util.MyUtils;
import com.lgz.cars.util.ResBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class CarServiceImpl implements CarService {
    @Autowired
    private CarMapper carMapper;
    @Autowired
    private ImgsMapper imgsMapper;

    @Override
    public ResBean getPage(int page, int limit, Car car,HttpSession session) {
        int powerid=MyUtils.getLoginPowerid(session);
        /*powerid>2表示非管理员*/
        if (powerid>2){
            /*不是管理员的用户只能看到可用和可借的车辆信息*/
            car.setStatus(1);/*设置可借*/
            car.setIsborrow(2);/*设置可用*/
        }
        PageHelper.startPage(page, limit);
        List<Car> list = carMapper.getAll(car);
        PageInfo<Car> pageInfo = new PageInfo<>(list);
        return new ResBean(0, "暂无数据", pageInfo.getTotal(), list);
    }

    @Override
    public ResBean update(Car car, String[] carImgs, HttpSession session) {
        int result;
        /*没有id,则添加车辆信息*/
        if (car.getId() == null) {
            /*设置创建人与创建时间*/
            car.setCreateDate(MyUtils.getNowTime());
            car.setCreateAdmin(MyUtils.getLoginName(session));
            /*车辆信息(除图片外)添加成功*/
            if (carMapper.insertSelective(car) > 0) {
                /*是否有图片,有图片则判断*/
                if (carImgs.length > 0) {
                    List<Imgs> list = new ArrayList<>();
                    /*遍历图片*/
                    for (String s : carImgs) {
                        /*设置图片信息*/
                        Imgs imgs = new Imgs();
                        imgs.setCarid(car.getId());
                        imgs.setImg(s);
                        imgs.setCreateAdmin(MyUtils.getLoginName(session));
                        imgs.setCreateDate(MyUtils.getNowTime());
                        list.add(imgs);
                    }
                    result = imgsMapper.batchInsert(list);
                    /*受影响行数是否与图片集合长度相同,不相同则抛出异常*/
                    if (result != list.size()) {
                        throw new Error("上传图片个数与所选图片个数不同,上传失败!");
                    }
                }
                /*没有图片则不判断,直接return*/
                return new ResBean(1, "信息更新成功!");
            } else {
                /*车辆其他信息更新不成功,则更新失败*/
                return new ResBean(0, "信息更新失败!");
            }
        } else {
            /*有id,则修改车辆信息,设置修改人与修改时间*/
            car.setUpdateAdmin(MyUtils.getLoginName(session));
            car.setUpdateDate(MyUtils.getNowTime());
            /*修改汽车信息*/
            if (carMapper.updateByPrimaryKeySelective(car) > 0) {
                /*判断车辆状态是否拿到值,有值则是修改状态(可用|禁用按钮),没有值则是修改车辆信息(修改按钮)*/
                if (car.getStatus()==null){
                    List<Imgs> imgsList = imgsMapper.getByCarId(car.getId());
                    /*汽车是否有图片*/
                    if (imgsList.size() > 0) {
                        /*被删除图片个数和查询到的图片个数不同*/
                        if (imgsMapper.deleteByCarId(car.getId()) != imgsList.size()) {
                            throw new Error("图片信息更新异常!");
                        }
                    }
                    /*添加的图片数量大于0*/
                    if (carImgs.length > 0) {
                        List<Imgs> list = new ArrayList<>();
                        /*遍历图片,设置图片信息*/
                        for (String s : carImgs) {
                            Imgs imgs = new Imgs();
                            imgs.setCarid(car.getId());
                            imgs.setImg(s);
                            imgs.setCreateAdmin(MyUtils.getLoginName(session));
                            imgs.setCreateDate(MyUtils.getNowTime());
                            list.add(imgs);
                        }
                        /*所选图片与添加的图片数量不同,则抛出异常*/
                        if (imgsMapper.batchInsert(list) != list.size()) {
                            throw new Error("图片信息更新异常!");
                        }
                    }
                }
                return new ResBean(1, "信息更新成功!");
            } else {
                return new ResBean(0, "信息更新失败!");
            }
        }
    }

    @Override
    public Car getById(Integer id) {
        return carMapper.getById(id);
    }

    @Override
    public ResBean delete(Integer id) {
        if (carMapper.deleteByPrimaryKey(id)>0){
                List<Imgs> list=imgsMapper.getByCarId(id);
                if (list.size()>0){
                    if (imgsMapper.deleteByCarId(id)!=list.size()){
                        throw new Error("删除图片异常!");
                    }
                }
            return new ResBean(1,"删除成功!");
        }
        return new ResBean(0,"删除失败!");
    }
}
