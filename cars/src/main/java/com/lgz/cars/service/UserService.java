package com.lgz.cars.service;

import com.lgz.cars.pojo.User;
import com.lgz.cars.util.ResBean;

import javax.servlet.http.HttpSession;

public interface UserService {
    User getInfoById(Integer id);

    User login(User user);

    ResBean getPage(int page,int limit,User user);

    ResBean checkUname(String username);

    ResBean update(User user, HttpSession session);

    ResBean delete(Integer id);

    User getById(Integer id);

    ResBean checkPwd(User user);
}
