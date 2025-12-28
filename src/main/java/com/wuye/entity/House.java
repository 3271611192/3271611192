package com.wuye.entity;

import lombok.Data;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 房屋实体类
 * 用于管理小区房屋信息
 */
@Data
public class House implements Serializable {
    /**
     * 房屋ID，主键自增
     */
    private Long id;
    
    /**
     * 楼栋号
     */
    private String buildingNo;
    
    /**
     * 单元号
     */
    private String unitNo;
    
    /**
     * 房号
     */
    private String roomNo;
    
    /**
     * 房屋面积（平方米）
     */
    private BigDecimal area;
    
    /**
     * 房屋类型：住宅、商铺、车库等
     */
    private String houseType;
    
    /**
     * 房屋状态：空置、自住、出租
     */
    private String status;
    
    /**
     * 备注信息
     */
    private String remark;
    
    /**
     * 创建时间
     */
    private Date createTime;
    
    /**
     * 更新时间
     */
    private Date updateTime;
}
