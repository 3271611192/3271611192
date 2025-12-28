package com.wuye.controller;

import com.wuye.common.PageResult;
import com.wuye.common.Result;
import com.wuye.entity.User;
import com.wuye.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * 用户控制器
 * 处理用户管理相关的增删改查请求
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 显示用户列表页面
     * 支持分页显示和条件搜索，默认第1页，每页10条
     * @param currentPage 当前页码，默认为1
     * @param username 用户名
     * @param realName 真实姓名
     * @param phone 电话
     * @param role 角色
     * @param model 模型对象
     * @return 返回用户列表页面视图
     */
    @GetMapping("/list")
    public String list(@RequestParam(value = "currentPage", defaultValue = "1") Integer currentPage,
                       @RequestParam(value = "username", required = false) String username,
                       @RequestParam(value = "realName", required = false) String realName,
                       @RequestParam(value = "phone", required = false) String phone,
                       @RequestParam(value = "role", required = false) String role,
                       Model model) {
        // 每页显示10条数据
        int pageSize = 10;

        // 调用Service查询分页数据
        PageResult<User> pageResult;
        if (username != null || realName != null || phone != null || role != null) {
            // 如果有任何搜索条件，则执行搜索
            pageResult = userService.search(username, realName, phone, role, currentPage, pageSize);
        } else {
            // 否则执行普通分页查询
            pageResult = userService.findByPage(currentPage, pageSize);
        }

        // 将分页结果和搜索参数添加到模型中
        model.addAttribute("pageResult", pageResult);

        Map<String, Object> searchParams = new HashMap<>();
        searchParams.put("username", username);
        searchParams.put("realName", realName);
        searchParams.put("phone", phone);
        searchParams.put("role", role);
        model.addAttribute("searchParams", searchParams);

        return "user/list";
    }

    /**
     * 显示新增用户页面
     * @return 返回新增用户页面视图
     */
    @GetMapping("/add")
    public String addPage() {
        return "user/add";
    }

    /**
     * 处理新增用户请求
     * 接收表单提交的用户数据，保存到数据库
     * @param user 用户对象
     * @return JSON格式的操作结果
     */
    @PostMapping("/add")
    @ResponseBody
    public Result<Void> add(@RequestBody User user) {
        // 调用Service保存用户
        boolean success = userService.save(user);

        if (success) {
            return Result.success("新增用户成功");
        } else {
            return Result.error("新增用户失败");
        }
    }

    /**
     * 显示编辑用户页面
     * 根据ID查询用户信息并显示
     * @param id 用户ID
     * @param model 模型对象
     * @return 返回编辑用户页面视图
     */
    @GetMapping("/edit/{id}")
    public String editPage(@PathVariable("id") Long id, Model model) {
        // 根据ID查询用户信息
        User user = userService.findById(id);

        // 将用户信息添加到模型中
        model.addAttribute("user", user);

        return "user/edit";
    }

    /**
     * 处理更新用户请求
     * 接收表单提交的用户数据，更新数据库
     * @param user 用户对象
     * @return JSON格式的操作结果
     */
    @PostMapping("/update")
    @ResponseBody
    public Result<Void> update(@RequestBody User user) {
        // 调用Service更新用户
        boolean success = userService.update(user);

        if (success) {
            return Result.success("更新用户成功");
        } else {
            return Result.error("更新用户失败");
        }
    }

    /**
     * 处理删除用户请求
     * 根据ID删除指定用户
     * @param id 用户ID
     * @return JSON格式的操作结果
     */
    @PostMapping("/delete/{id}")
    @ResponseBody
    public Result<Void> delete(@PathVariable("id") Long id) {
        // 调用Service删除用户
        boolean success = userService.delete(id);

        if (success) {
            return Result.success("删除用户成功");
        } else {
            return Result.error("删除用户失败");
        }
    }
}
