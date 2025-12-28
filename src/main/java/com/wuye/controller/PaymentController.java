package com.wuye.controller;

import com.wuye.common.PageResult;
import com.wuye.common.Result;
import com.wuye.entity.Payment;
import com.wuye.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * 缴费控制器
 * 处理缴费记录管理相关的增删改查请求
 */
@Controller
@RequestMapping("/payment")
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    /**
     * 显示缴费记录列表页面
     * 支持分页显示和条件搜索，默认第1页，每页10条
     * @param currentPage 当前页码，默认为1
     * @param ownerId 业主ID
     * @param houseId 房屋ID
     * @param paymentType 缴费类型
     * @param status 缴费状态
     * @param model 模型对象
     * @return 返回缴费记录列表页面视图
     */
    @GetMapping("/list")
    public String list(@RequestParam(value = "currentPage", defaultValue = "1") Integer currentPage,
                       @RequestParam(value = "ownerId", required = false) Long ownerId,
                       @RequestParam(value = "houseId", required = false) Long houseId,
                       @RequestParam(value = "paymentType", required = false) String paymentType,
                       @RequestParam(value = "status", required = false) String status,
                       Model model) {
        // 每页显示10条数据
        int pageSize = 10;

        // 调用Service查询分页数据
        PageResult<Payment> pageResult;
        if (ownerId != null || houseId != null || paymentType != null || status != null) {
            // 如果有任何搜索条件，则执行搜索
            pageResult = paymentService.search(ownerId, houseId, paymentType, status, currentPage, pageSize);
        } else {
            // 否则执行普通分页查询
            pageResult = paymentService.findByPage(currentPage, pageSize);
        }

        // 将分页结果和搜索参数添加到模型中
        model.addAttribute("pageResult", pageResult);

        Map<String, Object> searchParams = new HashMap<>();
        searchParams.put("ownerId", ownerId);
        searchParams.put("houseId", houseId);
        searchParams.put("paymentType", paymentType);
        searchParams.put("status", status);
        model.addAttribute("searchParams", searchParams);

        return "payment/list";
    }

    /**
     * 显示新增缴费记录页面
     * @return 返回新增缴费记录页面视图
     */
    @GetMapping("/add")
    public String addPage() {
        return "payment/add";
    }

    /**
     * 处理新增缴费记录请求
     * 接收表单提交的缴费记录数据，保存到数据库
     * @param payment 缴费记录对象
     * @return JSON格式的操作结果
     */
    @PostMapping("/add")
    @ResponseBody
    public Result<Void> add(@RequestBody Payment payment) {
        // 调用Service保存缴费记录
        boolean success = paymentService.save(payment);

        if (success) {
            return Result.success("新增缴费记录成功");
        } else {
            return Result.error("新增缴费记录失败");
        }
    }

    /**
     * 显示编辑缴费记录页面
     * 根据ID查询缴费记录信息并显示
     * @param id 缴费记录ID
     * @param model 模型对象
     * @return 返回编辑缴费记录页面视图
     */
    @GetMapping("/edit/{id}")
    public String editPage(@PathVariable("id") Long id, Model model) {
        // 根据ID查询缴费记录信息
        Payment payment = paymentService.findById(id);

        // 将缴费记录信息添加到模型中
        model.addAttribute("payment", payment);

        return "payment/edit";
    }

    /**
     * 处理更新缴费记录请求
     * 接收表单提交的缴费记录数据，更新数据库
     * @param payment 缴费记录对象
     * @return JSON格式的操作结果
     */
    @PostMapping("/update")
    @ResponseBody
    public Result<Void> update(@RequestBody Payment payment) {
        // 调用Service更新缴费记录
        boolean success = paymentService.update(payment);

        if (success) {
            return Result.success("更新缴费记录成功");
        } else {
            return Result.error("更新缴费记录失败");
        }
    }

    /**
     * 处理删除缴费记录请求
     * 根据ID删除指定缴费记录
     * @param id 缴费记录ID
     * @return JSON格式的操作结果
     */
    @PostMapping("/delete/{id}")
    @ResponseBody
    public Result<Void> delete(@PathVariable("id") Long id) {
        // 调用Service删除缴费记录
        boolean success = paymentService.delete(id);

        if (success) {
            return Result.success("删除缴费记录成功");
        } else {
            return Result.error("删除缴费记录失败");
        }
    }
}
