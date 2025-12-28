package com.wuye.service.impl;

import com.wuye.common.PageResult;
import com.wuye.entity.User;
import com.wuye.mapper.UserMapper;
import com.wuye.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 用户Service实现类
 * 实现用户相关的业务逻辑
 */
@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    /**
     * 用户登录验证
     * 根据用户名查询用户，并验证密码是否正确
     * @param username 用户名
     * @param password 密码
     * @return 用户对象，登录失败返回null
     */
    @Override
    public User login(String username, String password) {
        // 根据用户名查询用户
        User user = userMapper.findByUsername(username);

        // 验证用户是否存在、密码是否正确、账号是否启用
        if (user != null && user.getPassword().equals(password) && user.getStatus() == 1) {
            return user;
        }

        return null;
    }

    /**
     * 分页查询用户列表
     * 计算偏移量，调用Mapper查询数据和总数
     * @param currentPage 当前页码
     * @param pageSize 每页大小
     * @return 分页结果对象
     */
    @Override
    public PageResult<User> findByPage(Integer currentPage, Integer pageSize) {
        // 计算偏移量：(当前页-1) * 每页大小
        Integer offset = (currentPage - 1) * pageSize;

        // 查询数据列表
        List<User> userList = userMapper.findByPage(offset, pageSize);

        // 查询总数
        Long total = userMapper.countAll();

        // 封装分页结果
        return new PageResult<>(currentPage, pageSize, total, userList);
    }

    /**
     * 根据条件搜索用户列表
     * @param username 用户名
     * @param realName 真实姓名
     * @param phone 电话
     * @param role 角色
     * @param currentPage 当前页码
     * @param pageSize 每页大小
     * @return 分页结果对象
     */
    @Override
    public PageResult<User> search(String username, String realName, String phone, String role, Integer currentPage, Integer pageSize) {
        // 计算偏移量：(当前页-1) * 每页大小
        Integer offset = (currentPage - 1) * pageSize;

        // 查询数据列表
        List<User> userList = userMapper.search(username, realName, phone, role);

        // 简单处理分页（实际项目中应该在数据库层面完成）
        int totalSize = userList.size();
        int fromIndex = Math.min(offset, totalSize);
        int toIndex = Math.min(offset + pageSize, totalSize);
        List<User> pagedUserList = userList.subList(fromIndex, toIndex);

        // 封装分页结果
        return new PageResult<>(currentPage, pageSize, (long) totalSize, pagedUserList);
    }

    /**
     * 根据ID查询用户
     * @param id 用户ID
     * @return 用户对象
     */
    @Override
    public User findById(Long id) {
        return userMapper.findById(id);
    }

    /**
     * 新增用户
     * 设置默认状态为启用
     * @param user 用户对象
     * @return 是否成功
     */
    @Override
    public boolean save(User user) {
        // 设置默认状态为启用
        if (user.getStatus() == null) {
            user.setStatus(1);
        }

        // 执行插入操作
        return userMapper.insert(user) > 0;
    }

    /**
     * 更新用户信息
     * @param user 用户对象
     * @return 是否成功
     */
    @Override
    public boolean update(User user) {
        return userMapper.update(user) > 0;
    }

    /**
     * 删除用户
     * @param id 用户ID
     * @return 是否成功
     */
    @Override
    public boolean delete(Long id) {
        return userMapper.deleteById(id) > 0;
    }
}
