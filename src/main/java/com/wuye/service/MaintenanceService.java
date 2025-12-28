package com.wuye.service;

import com.wuye.entity.Maintenance;
import com.wuye.common.PageResult;

import java.util.List;

/**
 * 设备维修服务接口
 */
public interface MaintenanceService {
    /**
     * 分页查询维修记录
     * @param maintenance 查询条件
     * @param pageNum 页码
     * @param pageSize 每页显示数量
     * @return 分页结果
     */
    PageResult<Maintenance> selectPage(Maintenance maintenance, int pageNum, int pageSize);

    /**
     * 查询维修记录列表（不分页）
     * @param maintenance 查询条件
     * @return 维修记录列表
     */
    List<Maintenance> selectList(Maintenance maintenance);

    /**
     * 根据ID查询维修记录
     * @param id 维修记录ID
     * @return 维修记录
     */
    Maintenance selectById(Long id);

    /**
     * 新增维修记录
     * @param maintenance 维修记录
     * @return 新增记录ID
     */
    Long insert(Maintenance maintenance);

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
