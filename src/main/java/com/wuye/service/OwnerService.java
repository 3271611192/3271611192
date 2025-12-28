package com.wuye.service;

import com.wuye.common.PageResult;
import com.wuye.entity.Owner;

/**
 * 业主Service接口
 * 定义业主相关的业务逻辑方法
 */
public interface OwnerService {

    /**
     * 分页查询业主列表
     * @param currentPage 当前页码
     * @param pageSize 每页大小
     * @return 分页结果
     */
    PageResult<Owner> findByPage(Integer currentPage, Integer pageSize);

    /**
     * 根据条件搜索业主列表
     * @param name 姓名
     * @param phone 电话
     * @param idCard 身份证号
     * @param currentPage 当前页码
     * @param pageSize 每页大小
     * @return 分页结果
     */
    PageResult<Owner> search(String name, String phone, String idCard, Integer currentPage, Integer pageSize);

    /**
     * 根据ID查询业主
     * @param id 业主ID
     * @return 业主对象
     */
    Owner findById(Long id);

    /**
     * 新增业主
     * @param owner 业主对象
     * @return 是否成功
     */
    boolean save(Owner owner);

    /**
     * 更新业主
     * @param owner 业主对象
     * @return 是否成功
     */
    boolean update(Owner owner);

    /**
     * 删除业主
     * @param id 业主ID
     * @return 是否成功
     */
    boolean delete(Long id);
}
