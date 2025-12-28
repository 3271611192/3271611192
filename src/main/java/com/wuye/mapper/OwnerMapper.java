package com.wuye.mapper;

import com.wuye.entity.Owner;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 业主Mapper接口
 * 负责业主相关的数据库操作
 */
public interface OwnerMapper {
    
    /**
     * 分页查询业主列表
     * @param offset 起始位置
     * @param pageSize 每页大小
     * @return 业主列表
     */
    List<Owner> findByPage(@Param("offset") Integer offset, @Param("pageSize") Integer pageSize);
    
    /**
     * 查询业主总数
     * @return 总数
     */
    Long countAll();

    /**
     * 根据条件搜索业主列表
     * @param name 姓名
     * @param phone 电话
     * @param idCard 身份证号
     * @return 业主列表
     */
    List<Owner> search(@Param("name") String name,
                       @Param("phone") String phone,
                       @Param("idCard") String idCard);

    /**
     * 根据ID查询业主
     * @param id 业主ID
     * @return 业主对象
     */
    Owner findById(@Param("id") Long id);
    
    /**
     * 新增业主
     * @param owner 业主对象
     * @return 影响行数
     */
    int insert(Owner owner);
    
    /**
     * 更新业主信息
     * @param owner 业主对象
     * @return 影响行数
     */
    int update(Owner owner);
    
    /**
     * 根据ID删除业主
     * @param id 业主ID
     * @return 影响行数
     */
    int deleteById(@Param("id") Long id);
}
