package com.wuye.entity;

import lombok.Data;
import java.io.Serializable;
import java.util.Date;

/**
 * 用户实体类
 * 用于管理系统登录用户信息
 */
@Data
public class User implements Serializable {
    /**
     * 用户ID，主键自增
     */
    private Long id;
    
    /**
     * 用户名，用于登录
     */
    private String username;
    
    /**
     * 密码，加密存储
     */
    private String password;
    
    /**
     * 真实姓名
     */
    private String realName;
    
    /**
     * 联系电话
     */
    private String phone;
    
    /**
     * 用户角色：admin-管理员，user-普通用户
     */
    private String role;
    
    /**
     * 账号状态：0-禁用，1-启用
     */
    private Integer status;
    
    /**
     * 创建时间
     */
    private Date createTime;
    
    /**
     * 更新时间
     */
    private Date updateTime;
}
