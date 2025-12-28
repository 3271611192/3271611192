package com.wuye.mapper;

import com.wuye.entity.User;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 用户Mapper接口
 * 负责用户相关的数据库操作
 */
public interface UserMapper {

    /**
     * 根据用户名查询用户
     * @param username 用户名
     * @return 用户对象
     */
    User findByUsername(@Param("username") String username);

    /**
     * 分页查询用户列表
     * @param offset 起始位置
     * @param pageSize 每页大小
     * @return 用户列表
     */
    List<User> findByPage(@Param("offset") Integer offset, @Param("pageSize") Integer pageSize);

    /**
     * 查询用户总数
     * @return 总数
     */
    Long countAll();

    /**
     * 根据条件搜索用户列表
     * @param username 用户名
     * @param realName 真实姓名
     * @param phone 电话
     * @param role 角色
     * @return 用户列表
     */
    List<User> search(@Param("username") String username,
                      @Param("realName") String realName,
                      @Param("phone") String phone,
                      @Param("role") String role);

    /**
     * 根据ID查询用户
     * @param id 用户ID
     * @return 用户对象
     */
    User findById(@Param("id") Long id);

    /**
     * 新增用户
     * @param user 用户对象
     * @return 影响行数
     */
    int insert(User user);

    /**
     * 更新用户信息
     * @param user 用户对象
     * @return 影响行数
     */
    int update(User user);

    /**
     * 根据ID删除用户
     * @param id 用户ID
     * @return 影响行数
     */
    int deleteById(@Param("id") Long id);
}
