package com.wuye.service;

import com.wuye.common.PageResult;
import com.wuye.entity.House;

/**
 * 房屋Service接口
 * 定义房屋相关的业务逻辑方法
 */
public interface HouseService {

    /**
     * 分页查询房屋列表
     * @param currentPage 当前页码
     * @param pageSize 每页大小
     * @return 分页结果
     */
    PageResult<House> findByPage(Integer currentPage, Integer pageSize);

    /**
     * 根据条件搜索房屋列表
     * @param buildingNo 楼栋号
     * @param unitNo 单元号
     * @param roomNo 房号
     * @param houseType 房屋类型
     * @param status 房屋状态
     * @param currentPage 当前页码
     * @param pageSize 每页大小
     * @return 分页结果
     */
    PageResult<House> search(String buildingNo, String unitNo, String roomNo, String houseType, String status, Integer currentPage, Integer pageSize);

    /**
     * 根据ID查询房屋
     * @param id 房屋ID
     * @return 房屋对象
     */
    House findById(Long id);

    /**
     * 新增房屋
     * @param house 房屋对象
     * @return 是否成功
     */
    boolean save(House house);

    /**
     * 更新房屋
     * @param house 房屋对象
     * @return 是否成功
     */
    boolean update(House house);

    /**
     * 删除房屋
     * @param id 房屋ID
     * @return 是否成功
     */
    boolean delete(Long id);
}
