package com.lgz.cars.util;

import java.util.List;

public class ResBean {
    private Integer code;
    private String msg;
    private Long count;
    private List data;

    public ResBean() {
    }

    public ResBean(Integer code) {
        this.code = code;
    }

    public ResBean(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public ResBean(Integer code, List data) {
        this.code = code;
        this.data = data;
    }

    public ResBean(Integer code, String msg, Long count, List data) {
        this.code = code;
        this.msg = msg;
        this.count = count;
        this.data = data;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Long getCount() {
        return count;
    }

    public void setCount(Long count) {
        this.count = count;
    }

    public List getData() {
        return data;
    }

    public void setData(List data) {
        this.data = data;
    }
}
