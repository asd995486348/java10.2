package com.lgz.cars.service;

import com.lgz.cars.pojo.Record;
import com.lgz.cars.util.ResBean;

import javax.servlet.http.HttpSession;

public interface RecordService {
    ResBean update(Record record, HttpSession session);

    ResBean getPage(int page,int limit,Record record,HttpSession session);
}
