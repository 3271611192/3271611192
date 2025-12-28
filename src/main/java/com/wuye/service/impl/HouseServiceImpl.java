package com.wuye.service.impl;

import com.wuye.common.PageResult;
import com.wuye.entity.House;
import com.wuye.mapper.HouseMapper;
import com.wuye.service.HouseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 房屋Service实现类
 * 实现房屋相关的业务逻辑
 */
@Service
@Transactional
public class HouseServiceImpl implements HouseService {

    @Autowired
    private HouseMapper houseMapper;

    /**
     * 分页查询房屋列表
     * 计算偏移量，调用Mapper查询数据和总数
     * @param currentPage 当前页码
     * @param pageSize 每页大小
     * @return 分页结果对象
     */
    @Override
    public PageResult<House> findByPage(Integer currentPage, Integer pageSize) {
        // 计算偏移量：(当前页-1) * 每页大小
        Integer offset = (currentPage - 1) * pageSize;

        // 查询数据列表
        List<House> houseList = houseMapper.findByPage(offset, pageSize);

        // 查询总数
        Long total = houseMapper.countAll();

        // 封装分页结果
        return new PageResult<>(currentPage, pageSize, total, houseList);
    }

    /**
     * 根据条件搜索房屋列表
     * @param buildingNo 楼栋号
     * @param unitNo 单元号
     * @param roomNo 房号
     * @param houseType 房屋类型
     * @param status 房屋状态
     * @param currentPage 当前页码
     * @param pageSize 每页大小
     * @return 分页结果对象
     */
    @Override
    public PageResult<House> search(String buildingNo, String unitNo, String roomNo, String houseType, String status, Integer currentPage, Integer pageSize) {
        // 计算偏移量：(当前页-1) * 每页大小
        Integer offset = (currentPage - 1) * pageSize;

        // 查询数据列表
        List<House> houseList = houseMapper.search(buildingNo, unitNo, roomNo, houseType, status);

        // 简单处理分页（实际项目中应该在数据库层面完成）
        int totalSize = houseList.size();
        int fromIndex = Math.min(offset, totalSize);
        int toIndex = Math.min(offset + pageSize, totalSize);
        List<House> pagedHouseList = houseList.subList(fromIndex, toIndex);

        // 封装分页结果
        return new PageResult<>(currentPage, pageSize, (long) totalSize, pagedHouseList);
    }

    /**
     * 根据ID查询房屋
     * @param id 房屋ID
     * @return 房屋对象
     */
    @Override
    public House findById(Long id) {
        return houseMapper.findById(id);
    }

    /**
     * 新增房屋
     * @param house 房屋对象
     * @return 是否成功
     */
    @Override
    public boolean save(House house) {
        return houseMapper.insert(house) > 0;
    }

    /**
     * 更新房屋信息
     * @param house 房屋对象
     * @return 是否成功
     */
    @Override
    public boolean update(House house) {
        return houseMapper.update(house) > 0;
    }

    /**
     * 删除房屋
     * @param id 房屋ID
     * @return 是否成功
     */
    @Override
    public boolean delete(Long id) {
        return houseMapper.deleteById(id) > 0;
    }
}
