package com.wuye.service;

import com.wuye.common.PageResult;
import com.wuye.entity.User;

/**
 * 用户Service接口
 * 定义用户相关的业务逻辑方法
 */
public interface UserService {

    /**
     * 用户登录验证
     * @param username 用户名
     * @param password 密码
     * @return 用户对象，登录失败返回null
     */
    User login(String username, String password);

    /**
     * 分页查询用户列表
     * @param currentPage 当前页码
     * @param pageSize 每页大小
     * @return 分页结果
     */
    PageResult<User> findByPage(Integer currentPage, Integer pageSize);

    /**
     * 根据条件搜索用户列表
     * @param username 用户名
     * @param realName 真实姓名
     * @param phone 电话
     * @param role 角色
     * @param currentPage 当前页码
     * @param pageSize 每页大小
     * @return 分页结果
     */
    PageResult<User> search(String username, String realName, String phone, String role, Integer currentPage, Integer pageSize);

    /**
     * 根据ID查询用户
     * @param id 用户ID
     * @return 用户对象
     */
    User findById(Long id);

    /**
     * 新增用户
     * @param user 用户对象
     * @return 是否成功
     */
    boolean save(User user);

    /**
     * 更新用户
     * @param user 用户对象
     * @return 是否成功
     */
    boolean update(User user);

    /**
     * 删除用户
     * @param id 用户ID
     * @return 是否成功
     */
    boolean delete(Long id);
}
