package com.wuye.mapper;

import com.wuye.entity.House;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 房屋Mapper接口
 * 负责房屋相关的数据库操作
 */
public interface HouseMapper {
    
    /**
     * 分页查询房屋列表
     * @param offset 起始位置
     * @param pageSize 每页大小
     * @return 房屋列表
     */
    List<House> findByPage(@Param("offset") Integer offset, @Param("pageSize") Integer pageSize);
    
    /**
     * 查询房屋总数
     * @return 总数
     */
    Long countAll();

    /**
     * 根据条件搜索房屋列表
     * @param buildingNo 楼栋号
     * @param unitNo 单元号
     * @param roomNo 房号
     * @param houseType 房屋类型
     * @param status 房屋状态
     * @return 房屋列表
     */
    List<House> search(@Param("buildingNo") String buildingNo,
                       @Param("unitNo") String unitNo,
                       @Param("roomNo") String roomNo,
                       @Param("houseType") String houseType,
                       @Param("status") String status);

    /**
     * 根据ID查询房屋
     * @param id 房屋ID
     * @return 房屋对象
     */
    House findById(@Param("id") Long id);
    
    /**
     * 新增房屋
     * @param house 房屋对象
     * @return 影响行数
     */
    int insert(House house);
    
    /**
     * 更新房屋信息
     * @param house 房屋对象
     * @return 影响行数
     */
    int update(House house);
    
    /**
     * 根据ID删除房屋
     * @param id 房屋ID
     * @return 影响行数
     */
    int deleteById(@Param("id") Long id);
}
