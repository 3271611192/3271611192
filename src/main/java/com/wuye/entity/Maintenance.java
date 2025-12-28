package com.wuye.entity;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 设备维修实体类
 * 用于管理小区设备维修记录
 */
@Data
public class Maintenance implements Serializable {
    /**
     * 维修记录ID，主键自增
     */
    private Long id;

    /**
     * 设备名称
     */
    private String deviceName;

    /**
     * 设备位置
     */
    private String deviceLocation;

    /**
     * 问题描述
     */
    private String problemDescription;

    /**
     * 维修状态：待处理、处理中、已完成、已取消
     */
    private String repairStatus;

    /**
     * 优先级：高、中、低
     */
    private String priority;

    /**
     * 报告人
     */
    private String reporter;

    /**
     * 报告人联系方式
     */
    private String reporterPhone;

    /**
     * 维修人员
     */
    private String repairPerson;

    /**
     * 维修时间
     */
    private Date repairTime;

    /**
     * 维修费用
     */
    private BigDecimal repairCost;

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
