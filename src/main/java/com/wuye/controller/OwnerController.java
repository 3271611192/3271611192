package com.wuye.controller;

import com.wuye.common.PageResult;
import com.wuye.common.Result;
import com.wuye.entity.Owner;
import com.wuye.service.OwnerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * 业主控制器
 * 处理业主管理相关的增删改查请求
 */
@Controller
@RequestMapping("/owner")
public class OwnerController {

    @Autowired
    private OwnerService ownerService;

    /**
     * 显示业主列表页面
     * 支持分页显示和条件搜索，默认第1页，每页10条
     * @param currentPage 当前页码，默认为1
     * @param name 姓名
     * @param phone 电话
     * @param idCard 身份证号
     * @param model 模型对象
     * @return 返回业主列表页面视图
     */
    @GetMapping("/list")
    public String list(@RequestParam(value = "currentPage", defaultValue = "1") Integer currentPage,
                       @RequestParam(value = "name", required = false) String name,
                       @RequestParam(value = "phone", required = false) String phone,
                       @RequestParam(value = "idCard", required = false) String idCard,
                       Model model) {
        // 每页显示10条数据
        int pageSize = 10;

        // 调用Service查询分页数据
        PageResult<Owner> pageResult;
        if (name != null || phone != null || idCard != null) {
            // 如果有任何搜索条件，则执行搜索
            pageResult = ownerService.search(name, phone, idCard, currentPage, pageSize);
        } else {
            // 否则执行普通分页查询
            pageResult = ownerService.findByPage(currentPage, pageSize);
        }

        // 将分页结果和搜索参数添加到模型中
        model.addAttribute("pageResult", pageResult);

        Map<String, Object> searchParams = new HashMap<>();
        searchParams.put("name", name);
        searchParams.put("phone", phone);
        searchParams.put("idCard", idCard);
        model.addAttribute("searchParams", searchParams);

        return "owner/list";
    }

    /**
     * 显示新增业主页面
     * @return 返回新增业主页面视图
     */
    @GetMapping("/add")
    public String addPage() {
        return "owner/add";
    }

    /**
     * 处理新增业主请求
     * 接收表单提交的业主数据，保存到数据库
     * @param owner 业主对象
     * @return JSON格式的操作结果
     */
    @PostMapping("/add")
    @ResponseBody
    public Result<Void> add(@RequestBody Owner owner) {
        // 调用Service保存业主
        boolean success = ownerService.save(owner);

        if (success) {
            return Result.success("新增业主成功");
        } else {
            return Result.error("新增业主失败");
        }
    }

    /**
     * 显示编辑业主页面
     * 根据ID查询业主信息并显示
     * @param id 业主ID
     * @param model 模型对象
     * @return 返回编辑业主页面视图
     */
    @GetMapping("/edit/{id}")
    public String editPage(@PathVariable("id") Long id, Model model) {
        // 根据ID查询业主信息
        Owner owner = ownerService.findById(id);

        // 将业主信息添加到模型中
        model.addAttribute("owner", owner);

        return "owner/edit";
    }

    /**
     * 处理更新业主请求
     * 接收表单提交的业主数据，更新数据库
     * @param owner 业主对象
     * @return JSON格式的操作结果
     */
    @PostMapping("/update")
    @ResponseBody
    public Result<Void> update(@RequestBody Owner owner) {
        // 调用Service更新业主
        boolean success = ownerService.update(owner);

        if (success) {
            return Result.success("更新业主成功");
        } else {
            return Result.error("更新业主失败");
        }
    }

    /**
     * 处理删除业主请求
     * 根据ID删除指定业主
     * @param id 业主ID
     * @return JSON格式的操作结果
     */
    @PostMapping("/delete/{id}")
    @ResponseBody
    public Result<Void> delete(@PathVariable("id") Long id) {
        // 调用Service删除业主
        boolean success = ownerService.delete(id);

        if (success) {
            return Result.success("删除业主成功");
        } else {
            return Result.error("删除业主失败");
        }
    }
}
