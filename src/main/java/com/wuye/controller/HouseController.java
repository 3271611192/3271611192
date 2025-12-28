package com.wuye.controller;

import com.wuye.common.PageResult;
import com.wuye.common.Result;
import com.wuye.entity.House;
import com.wuye.service.HouseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * 房屋控制器
 * 处理房屋管理相关的增删改查请求
 */
@Controller
@RequestMapping("/house")
public class HouseController {

    @Autowired
    private HouseService houseService;

    /**
     * 显示房屋列表页面
     * 支持分页显示和条件搜索，默认第1页，每页10条
     * @param currentPage 当前页码，默认为1
     * @param buildingNo 楼栋号
     * @param unitNo 单元号
     * @param roomNo 房号
     * @param houseType 房屋类型
     * @param status 房屋状态
     * @param model 模型对象
     * @return 返回房屋列表页面视图
     */
    @GetMapping("/list")
    public String list(@RequestParam(value = "currentPage", defaultValue = "1") Integer currentPage,
                       @RequestParam(value = "buildingNo", required = false) String buildingNo,
                       @RequestParam(value = "unitNo", required = false) String unitNo,
                       @RequestParam(value = "roomNo", required = false) String roomNo,
                       @RequestParam(value = "houseType", required = false) String houseType,
                       @RequestParam(value = "status", required = false) String status,
                       Model model) {
        // 每页显示10条数据
        int pageSize = 10;

        // 调用Service查询分页数据
        PageResult<House> pageResult;
        if (buildingNo != null || unitNo != null || roomNo != null || houseType != null || status != null) {
            // 如果有任何搜索条件，则执行搜索
            pageResult = houseService.search(buildingNo, unitNo, roomNo, houseType, status, currentPage, pageSize);
        } else {
            // 否则执行普通分页查询
            pageResult = houseService.findByPage(currentPage, pageSize);
        }

        // 将分页结果和搜索参数添加到模型中
        model.addAttribute("pageResult", pageResult);

        Map<String, Object> searchParams = new HashMap<>();
        searchParams.put("buildingNo", buildingNo);
        searchParams.put("unitNo", unitNo);
        searchParams.put("roomNo", roomNo);
        searchParams.put("houseType", houseType);
        searchParams.put("status", status);
        model.addAttribute("searchParams", searchParams);

        return "house/list";
    }

    /**
     * 显示新增房屋页面
     * @return 返回新增房屋页面视图
     */
    @GetMapping("/add")
    public String addPage() {
        return "house/add";
    }

    /**
     * 处理新增房屋请求
     * 接收表单提交的房屋数据，保存到数据库
     * @param house 房屋对象
     * @return JSON格式的操作结果
     */
    @PostMapping("/add")
    @ResponseBody
    public Result<Void> add(@RequestBody House house) {
        // 调用Service保存房屋
        boolean success = houseService.save(house);

        if (success) {
            return Result.success("新增房屋成功");
        } else {
            return Result.error("新增房屋失败");
        }
    }

    /**
     * 显示编辑房屋页面
     * 根据ID查询房屋信息并显示
     * @param id 房屋ID
     * @param model 模型对象
     * @return 返回编辑房屋页面视图
     */
    @GetMapping("/edit/{id}")
    public String editPage(@PathVariable("id") Long id, Model model) {
        // 根据ID查询房屋信息
        House house = houseService.findById(id);

        // 将房屋信息添加到模型中
        model.addAttribute("house", house);

        return "house/edit";
    }

    /**
     * 处理更新房屋请求
     * 接收表单提交的房屋数据，更新数据库
     * @param house 房屋对象
     * @return JSON格式的操作结果
     */
    @PostMapping("/update")
    @ResponseBody
    public Result<Void> update(@RequestBody House house) {
        // 调用Service更新房屋
        boolean success = houseService.update(house);

        if (success) {
            return Result.success("更新房屋成功");
        } else {
            return Result.error("更新房屋失败");
        }
    }

    /**
     * 处理删除房屋请求
     * 根据ID删除指定房屋
     * @param id 房屋ID
     * @return JSON格式的操作结果
     */
    @PostMapping("/delete/{id}")
    @ResponseBody
    public Result<Void> delete(@PathVariable("id") Long id) {
        // 调用Service删除房屋
        boolean success = houseService.delete(id);

        if (success) {
            return Result.success("删除房屋成功");
        } else {
            return Result.error("删除房屋失败");
        }
    }
}
