package com.wuye.service;

import com.wuye.common.PageResult;
import com.wuye.entity.Payment;

/**
 * 缴费Service接口
 * 定义缴费记录相关的业务逻辑方法
 */
public interface PaymentService {

    /**
     * 分页查询缴费记录列表
     * @param currentPage 当前页码
     * @param pageSize 每页大小
     * @return 分页结果
     */
    PageResult<Payment> findByPage(Integer currentPage, Integer pageSize);

    /**
     * 根据条件搜索缴费记录列表
     * @param ownerId 业主ID
     * @param houseId 房屋ID
     * @param paymentType 缴费类型
     * @param status 缴费状态
     * @param currentPage 当前页码
     * @param pageSize 每页大小
     * @return 分页结果
     */
    PageResult<Payment> search(Long ownerId, Long houseId, String paymentType, String status, Integer currentPage, Integer pageSize);

    /**
     * 根据ID查询缴费记录
     * @param id 缴费记录ID
     * @return 缴费记录对象
     */
    Payment findById(Long id);

    /**
     * 新增缴费记录
     * @param payment 缴费记录对象
     * @return 是否成功
     */
    boolean save(Payment payment);

    /**
     * 更新缴费记录
     * @param payment 缴费记录对象
     * @return 是否成功
     */
    boolean update(Payment payment);

    /**
     * 删除缴费记录
     * @param id 缴费记录ID
     * @return 是否成功
     */
    boolean delete(Long id);
}
