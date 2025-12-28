package com.wuye.service.impl;

import com.wuye.common.PageResult;
import com.wuye.entity.Owner;
import com.wuye.mapper.OwnerMapper;
import com.wuye.service.OwnerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 业主Service实现类
 * 实现业主相关的业务逻辑
 */
@Service
@Transactional
public class OwnerServiceImpl implements OwnerService {

    @Autowired
    private OwnerMapper ownerMapper;

    /**
     * 分页查询业主列表
     * 计算偏移量，调用Mapper查询数据和总数
     * @param currentPage 当前页码
     * @param pageSize 每页大小
     * @return 分页结果对象
     */
    @Override
    public PageResult<Owner> findByPage(Integer currentPage, Integer pageSize) {
        // 计算偏移量：(当前页-1) * 每页大小
        Integer offset = (currentPage - 1) * pageSize;

        // 查询数据列表
        List<Owner> ownerList = ownerMapper.findByPage(offset, pageSize);

        // 查询总数
        Long total = ownerMapper.countAll();

        // 封装分页结果
        return new PageResult<>(currentPage, pageSize, total, ownerList);
    }

    /**
     * 根据条件搜索业主列表
     * @param name 姓名
     * @param phone 电话
     * @param idCard 身份证号
     * @param currentPage 当前页码
     * @param pageSize 每页大小
     * @return 分页结果对象
     */
    @Override
    public PageResult<Owner> search(String name, String phone, String idCard, Integer currentPage, Integer pageSize) {
        // 计算偏移量：(当前页-1) * 每页大小
        Integer offset = (currentPage - 1) * pageSize;

        // 查询数据列表
        List<Owner> ownerList = ownerMapper.search(name, phone, idCard);

        // 简单处理分页（实际项目中应该在数据库层面完成）
        int totalSize = ownerList.size();
        int fromIndex = Math.min(offset, totalSize);
        int toIndex = Math.min(offset + pageSize, totalSize);
        List<Owner> pagedOwnerList = ownerList.subList(fromIndex, toIndex);

        // 封装分页结果
        return new PageResult<>(currentPage, pageSize, (long) totalSize, pagedOwnerList);
    }

    /**
     * 根据ID查询业主
     * @param id 业主ID
     * @return 业主对象
     */
    @Override
    public Owner findById(Long id) {
        return ownerMapper.findById(id);
    }

    /**
     * 新增业主
     * @param owner 业主对象
     * @return 是否成功
     */
    @Override
    public boolean save(Owner owner) {
        return ownerMapper.insert(owner) > 0;
    }

    /**
     * 更新业主信息
     * @param owner 业主对象
     * @return 是否成功
     */
    @Override
    public boolean update(Owner owner) {
        return ownerMapper.update(owner) > 0;
    }

    /**
     * 删除业主
     * @param id 业主ID
     * @return 是否成功
     */
    @Override
    public boolean delete(Long id) {
        return ownerMapper.deleteById(id) > 0;
    }
}
