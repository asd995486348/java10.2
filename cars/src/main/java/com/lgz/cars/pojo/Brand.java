package com.lgz.cars.pojo;

import lombok.Data;

@Data
public class Brand {
    private Integer id;

    private String brand;

    private Integer pid;

    private Integer status;

    private String createDate;

    private String createAdmin;

    private String updateDate;

    private String updateAdmin;
}