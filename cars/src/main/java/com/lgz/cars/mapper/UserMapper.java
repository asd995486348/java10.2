package com.lgz.cars.mapper;

import com.lgz.cars.pojo.User;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    User login(User user);

    @Select("select * from user where id=#{id}")
    User getById(Integer id);

    List<User> getPage(User user);

    User checkUname(String usernmae);

    User checkPwd(User user);
}