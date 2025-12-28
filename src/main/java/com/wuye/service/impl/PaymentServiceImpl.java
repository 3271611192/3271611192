package com.wuye.service.impl;

import com.wuye.common.PageResult;
import com.wuye.entity.Payment;
import com.wuye.mapper.PaymentMapper;
import com.wuye.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 缴费Service实现类
 * 实现缴费记录相关的业务逻辑
 */
@Service
@Transactional
public class PaymentServiceImpl implements PaymentService {

    @Autowired
    private PaymentMapper paymentMapper;

    /**
     * 分页查询缴费记录列表
     * 计算偏移量，调用Mapper查询数据和总数
     * @param currentPage 当前页码
     * @param pageSize 每页大小
     * @return 分页结果对象
     */
    @Override
    public PageResult<Payment> findByPage(Integer currentPage, Integer pageSize) {
        // 计算偏移量：(当前页-1) * 每页大小
        Integer offset = (currentPage - 1) * pageSize;

        // 查询数据列表
        List<Payment> paymentList = paymentMapper.findByPage(offset, pageSize);

        // 查询总数
        Long total = paymentMapper.countAll();

        // 封装分页结果
        return new PageResult<>(currentPage, pageSize, total, paymentList);
    }

    /**
     * 根据条件搜索缴费记录列表
     * @param ownerId 业主ID
     * @param houseId 房屋ID
     * @param paymentType 缴费类型
     * @param status 缴费状态
     * @param currentPage 当前页码
     * @param pageSize 每页大小
     * @return 分页结果对象
     */
    @Override
    public PageResult<Payment> search(Long ownerId, Long houseId, String paymentType, String status, Integer currentPage, Integer pageSize) {
        // 计算偏移量：(当前页-1) * 每页大小
        Integer offset = (currentPage - 1) * pageSize;

        // 查询数据列表
        List<Payment> paymentList = paymentMapper.search(ownerId, houseId, paymentType, status);

        // 简单处理分页（实际项目中应该在数据库层面完成）
        int totalSize = paymentList.size();
        int fromIndex = Math.min(offset, totalSize);
        int toIndex = Math.min(offset + pageSize, totalSize);
        List<Payment> pagedPaymentList = paymentList.subList(fromIndex, toIndex);

        // 封装分页结果
        return new PageResult<>(currentPage, pageSize, (long) totalSize, pagedPaymentList);
    }

    /**
     * 根据ID查询缴费记录
     * @param id 缴费记录ID
     * @return 缴费记录对象
     */
    @Override
    public Payment findById(Long id) {
        return paymentMapper.findById(id);
    }

    /**
     * 新增缴费记录
     * 设置默认状态为未缴费
     * @param payment 缴费记录对象
     * @return 是否成功
     */
    @Override
    public boolean save(Payment payment) {
        // 设置默认状态为未缴费
        if (payment.getStatus() == null) {
            payment.setStatus(0);
        }

        return paymentMapper.insert(payment) > 0;
    }

    /**
     * 更新缴费记录
     * @param payment 缴费记录对象
     * @return 是否成功
     */
    @Override
    public boolean update(Payment payment) {
        return paymentMapper.update(payment) > 0;
    }

    /**
     * 删除缴费记录
     * @param id 缴费记录ID
     * @return 是否成功
     */
    @Override
    public boolean delete(Long id) {
        return paymentMapper.deleteById(id) > 0;
    }
}
