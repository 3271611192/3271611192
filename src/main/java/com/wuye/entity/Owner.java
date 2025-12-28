package com.wuye.entity;

import lombok.Data;
import java.io.Serializable;
import java.util.Date;

/**
 * 业主实体类
 * 用于管理小区业主基本信息
 */
@Data
public class Owner implements Serializable {
    /**
     * 业主ID，主键自增
     */
    private Long id;
    
    /**
     * 业主姓名
     */
    private String name;
    
    /**
     * 性别：男、女
     */
    private String gender;
    
    /**
     * 联系电话
     */
    private String phone;
    
    /**
     * 身份证号
     */
    private String idCard;
    
    /**
     * 电子邮箱
     */
    private String email;
    
    /**
     * 房屋ID，关联房屋表
     */
    private Long houseId;
    
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
