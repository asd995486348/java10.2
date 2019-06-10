package com.lgz.cars.pojo;

public class Record {
    private Integer id;

    private Integer uid;

    private Integer carid;

    private String btime;

    private String address;

    private String bmsg;

    private Integer apply;

    private Double bmileage;

    private String rtime;

    private Double rmileage;

    private String rmsg;

    private Integer status;

    private String createDate;

    private String createAdmin;

    private String updateDate;

    private String updateAdmin;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Integer getCarid() {
        return carid;
    }

    public void setCarid(Integer carid) {
        this.carid = carid;
    }

    public String getBtime() {
        return btime;
    }

    public void setBtime(String btime) {
        this.btime = btime == null ? null : btime.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getBmsg() {
        return bmsg;
    }

    public void setBmsg(String bmsg) {
        this.bmsg = bmsg == null ? null : bmsg.trim();
    }

    public Integer getApply() {
        return apply;
    }

    public void setApply(Integer apply) {
        this.apply = apply;
    }

    public Double getBmileage() {
        return bmileage;
    }

    public void setBmileage(Double bmileage) {
        this.bmileage = bmileage;
    }

    public String getRtime() {
        return rtime;
    }

    public void setRtime(String rtime) {
        this.rtime = rtime == null ? null : rtime.trim();
    }

    public Double getRmileage() {
        return rmileage;
    }

    public void setRmileage(Double rmileage) {
        this.rmileage = rmileage;
    }

    public String getRmsg() {
        return rmsg;
    }

    public void setRmsg(String rmsg) {
        this.rmsg = rmsg == null ? null : rmsg.trim();
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate == null ? null : createDate.trim();
    }

    public String getCreateAdmin() {
        return createAdmin;
    }

    public void setCreateAdmin(String createAdmin) {
        this.createAdmin = createAdmin == null ? null : createAdmin.trim();
    }

    public String getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(String updateDate) {
        this.updateDate = updateDate == null ? null : updateDate.trim();
    }

    public String getUpdateAdmin() {
        return updateAdmin;
    }

    public void setUpdateAdmin(String updateAdmin) {
        this.updateAdmin = updateAdmin == null ? null : updateAdmin.trim();
    }
}