package com.wuye.entity;

import lombok.Data;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 缴费实体类
 * 用于管理业主物业费、水电费等缴费记录
 */
@Data
public class Payment implements Serializable {
    /**
     * 缴费记录ID，主键自增
     */
    private Long id;
    
    /**
     * 业主ID，关联业主表
     */
    private Long ownerId;
    
    /**
     * 房屋ID，关联房屋表
     */
    private Long houseId;
    
    /**
     * 费用类型：物业费、水费、电费、燃气费、停车费
     */
    private String paymentType;
    
    /**
     * 缴费金额
     */
    private BigDecimal amount;
    
    /**
     * 缴费状态：0-未缴费，1-已缴费
     */
    private Integer status;
    
    /**
     * 缴费时间
     */
    private Date paymentTime;
    
    /**
     * 账单月份，格式：2024-01
     */
    private String billingMonth;
    
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
