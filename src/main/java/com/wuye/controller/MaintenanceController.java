package com.wuye.controller;

import com.wuye.entity.Maintenance;
import com.wuye.service.MaintenanceService;
import com.wuye.common.PageResult;
import com.wuye.common.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 设备维修控制器
 */
@Controller
@RequestMapping("/maintenance")
public class MaintenanceController {

    @Autowired
    private MaintenanceService maintenanceService;

    /**
     * 跳转到维修记录列表页面
     */
    @GetMapping("/list")
    public String listPage() {
        return "maintenance/list";
    }

    /**
     * 获取维修记录分页数据
     */
    @GetMapping("/page")
    @ResponseBody
    public Result<PageResult<Maintenance>> selectPage(Maintenance maintenance,
                                                      @RequestParam(defaultValue = "1") Integer pageNum,
                                                      @RequestParam(defaultValue = "10") Integer pageSize) {
        try {
            System.out.println("Controller - 查询条件: " + maintenance);
            System.out.println("Controller - 页码: " + pageNum + ", 每页大小: " + pageSize);

            PageResult<Maintenance> pageResult = maintenanceService.selectPage(maintenance, pageNum, pageSize);
            System.out.println("Controller - 查询结果总数: " + pageResult.getTotal());
            System.out.println("Controller - 当前页数据量: " + pageResult.getData().size());

            return Result.success(pageResult);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("获取数据失败：" + e.getMessage());
        }
    }

    /**
     * 跳转到新增维修记录页面
     */
    @GetMapping("/add")
    public String addPage() {
        return "maintenance/add";
    }

    /**
     * 新增维修记录
     */
    @PostMapping("/add")
    @ResponseBody
    public Result<String> add(@RequestBody Maintenance maintenance) {
        try {
            maintenanceService.insert(maintenance);
            return Result.success("新增成功");
        } catch (Exception e) {
            return Result.error("新增失败：" + e.getMessage());
        }
    }

    /**
     * 跳转到编辑维修记录页面
     */
    @GetMapping("/edit/{id}")
    public String editPage(@PathVariable Long id, Model model) {
        Maintenance maintenance = maintenanceService.selectById(id);
        model.addAttribute("maintenance", maintenance);
        return "maintenance/edit";
    }

    /**
     * 更新维修记录
     */
    @PostMapping("/edit")
    @ResponseBody
    public Result<String> edit(@RequestBody Maintenance maintenance) {
        try {
            int result = maintenanceService.update(maintenance);
            if (result > 0) {
                return Result.success("更新成功");
            } else {
                return Result.error("更新失败");
            }
        } catch (Exception e) {
            return Result.error("更新失败：" + e.getMessage());
        }
    }

    /**
     * 删除维修记录
     */
    @PostMapping("/delete/{id}")
    @ResponseBody
    public Result<String> delete(@PathVariable Long id) {
        try {
            int result = maintenanceService.delete(id);
            if (result > 0) {
                return Result.success("删除成功");
            } else {
                return Result.error("删除失败");
            }
        } catch (Exception e) {
            return Result.error("删除失败：" + e.getMessage());
        }
    }

    /**
     * 查询维修记录列表（不带分页）
     */
    @GetMapping("/listData")
    @ResponseBody
    public Result<List<Maintenance>> listData(Maintenance maintenance) {
        List<Maintenance> list = maintenanceService.selectList(maintenance);
        return Result.success(list);
    }
}
