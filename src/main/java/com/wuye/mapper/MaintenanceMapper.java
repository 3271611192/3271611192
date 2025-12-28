package com.wuye.mapper;

import com.wuye.entity.Maintenance;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 设备维修数据访问接口
 */
public interface MaintenanceMapper {
    /**
     * 根据ID查询维修记录
     * @param id 维修记录ID
     * @return 维修记录
     */
    Maintenance selectById(Long id);

    /**
     * 查询维修记录列表
     * @param maintenance 查询条件
     * @return 维修记录列表
     */
    List<Maintenance> selectList(@Param("maintenance") Maintenance maintenance);
    /**
     * 分页查询维修记录列表
     * @param maintenance 查询条件
     * @param offset 偏移量
     * @param pageSize 每页大小
     * @return 维修记录列表
     */
    List<Maintenance> selectListByPage(@Param("maintenance") Maintenance maintenance, @Param("offset") int offset, @Param("pageSize") int pageSize);

    /**
     * 查询维修记录总数
     * @param maintenance 查询条件
     * @return 总记录数
     */
    int selectCount(@Param("maintenance") Maintenance maintenance);
    /**
     * 新增维修记录
     * @param maintenance 维修记录
     * @return 影响行数
     */
    int insert(Maintenance maintenance);

    /**
     * 更新维修记录
     * @param maintenance 维修记录
     * @return 影响行数
     */
    int update(Maintenance maintenance);

    /**
     * 删除维修记录
     * @param id 维修记录ID
     * @return 影响行数
     */
    int delete(Long id);
}
