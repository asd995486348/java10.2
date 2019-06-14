package com.lgz.cars.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lgz.cars.mapper.CarMapper;
import com.lgz.cars.mapper.RecordMapper;
import com.lgz.cars.pojo.Car;
import com.lgz.cars.pojo.Record;
import com.lgz.cars.pojo.User;
import com.lgz.cars.service.RecordService;
import com.lgz.cars.util.MyUtils;
import com.lgz.cars.util.ResBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.List;

@Service
@Transactional
public class RecordServiceImpl implements RecordService {

    @Autowired
    private RecordMapper recordMapper;

    @Autowired
    private CarMapper carMapper;

    @Override
    public ResBean update(Record record, HttpSession session) {
        int result;
        if (record.getId()==null){
            record.setCreateAdmin(MyUtils.getLoginName(session));
            record.setCreateDate(MyUtils.getNowTime());
            if (recordMapper.insertSelective(record)>0){
                Car car=new Car();
                car.setId(record.getCarid());
                car.setIsborrow(1);
                if (carMapper.updateByPrimaryKeySelective(car)!=1){
                    throw new Error("车辆状态更新异常!");
                }
                return new ResBean(1,"申请提交成功!");
            }
        }
        return new ResBean(0,"申请提交失败");
    }

    @Override
    public ResBean getPage(int page, int limit, Record record, HttpSession session) {
        /*获取登录用户实体*/
        User user = MyUtils.getLoginUser(session);
        /*判断登录用户权限*/
        if (user.getPowerid()==2){
            /*管理员只能查看可用状态下的记录*/
            record.setStatus(1);
        }
        if (user.getPowerid()>2){
            /*普通用户只能查看可用并且自己申请的记录*/
            record.setStatus(1);
            record.setUid(user.getId());
        }
        PageHelper.startPage(page,limit);
        List<Record> list=recordMapper.getAll(record);
        PageInfo<Record> pageInfo=new PageInfo<>(list);
        return new ResBean(0,"暂无数据",pageInfo.getTotal(),list);
    }
}
