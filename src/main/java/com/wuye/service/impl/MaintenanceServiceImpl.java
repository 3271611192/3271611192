package com.wuye.service.impl;

import com.wuye.entity.Maintenance;
import com.wuye.mapper.MaintenanceMapper;
import com.wuye.service.MaintenanceService;
import com.wuye.common.PageResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 设备维修服务实现类
 */
@Service
public class MaintenanceServiceImpl implements MaintenanceService {

    @Autowired
    private MaintenanceMapper maintenanceMapper;

    @Override
    public PageResult<Maintenance> selectPage(Maintenance maintenance, int pageNum, int pageSize) {
        // 计算偏移量
        int offset = (pageNum - 1) * pageSize;

        // 获取当前页数据
        List<Maintenance> pageList = maintenanceMapper.selectListByPage(maintenance, offset, pageSize);

        // 获取总记录数
        int total = maintenanceMapper.selectCount(maintenance);

        return new PageResult<>(pageNum, pageSize, (long)total, pageList);
    }
    @Override
    public List<Maintenance> selectList(Maintenance maintenance) {
        return maintenanceMapper.selectList(maintenance);
    }

    @Override
    public Maintenance selectById(Long id) {
        return maintenanceMapper.selectById(id);
    }

    @Override
    public Long insert(Maintenance maintenance) {
        maintenanceMapper.insert(maintenance);
        return maintenance.getId();
    }

    @Override
    public int update(Maintenance maintenance) {
        return maintenanceMapper.update(maintenance);
    }

    @Override
    public int delete(Long id) {
        return maintenanceMapper.delete(id);
    }
}
