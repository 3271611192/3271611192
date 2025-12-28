package com.wuye.mapper;

import com.wuye.entity.Payment;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 缴费Mapper接口
 * 负责缴费记录相关的数据库操作
 */
public interface PaymentMapper {

    /**
     * 分页查询缴费记录列表
     * @param offset 起始位置
     * @param pageSize 每页大小
     * @return 缴费记录列表
     */
    List<Payment> findByPage(@Param("offset") Integer offset, @Param("pageSize") Integer pageSize);

    /**
     * 查询缴费记录总数
     * @return 总数
     */
    Long countAll();

    /**
     * 根据条件搜索缴费记录列表
     * @param ownerId 业主ID
     * @param houseId 房屋ID
     * @param paymentType 缴费类型
     * @param status 缴费状态
     * @return 缴费记录列表
     */
    List<Payment> search(@Param("ownerId") Long ownerId,
                         @Param("houseId") Long houseId,
                         @Param("paymentType") String paymentType,
                         @Param("status") String status);

    /**
     * 根据ID查询缴费记录
     * @param id 缴费记录ID
     * @return 缴费记录对象
     */
    Payment findById(@Param("id") Long id);

    /**
     * 新增缴费记录
     * @param payment 缴费记录对象
     * @return 影响行数
     */
    int insert(Payment payment);

    /**
     * 更新缴费记录
     * @param payment 缴费记录对象
     * @return 影响行数
     */
    int update(Payment payment);

    /**
     * 根据ID删除缴费记录
     * @param id 缴费记录ID
     * @return 影响行数
     */
    int deleteById(@Param("id") Long id);
}
