package com.wuye.controller;

import com.wuye.entity.User;
import com.wuye.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

/**
 * 登录控制器
 * 处理用户登录、退出登录相关请求
 */
@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    // 通过反射获取UserMapper来检查用户名是否已存在
    private boolean isUsernameExists(String username) {
        try {
            // 获取userServiceImpl实例
            com.wuye.service.impl.UserServiceImpl userServiceImpl = (com.wuye.service.impl.UserServiceImpl) userService;

            // 通过反射获取userMapper字段
            java.lang.reflect.Field userMapperField = userServiceImpl.getClass().getDeclaredField("userMapper");
            userMapperField.setAccessible(true);

            // 获取userMapper实例
            com.wuye.mapper.UserMapper userMapper = (com.wuye.mapper.UserMapper) userMapperField.get(userServiceImpl);

            // 查询用户
            User user = userMapper.findByUsername(username);
            return user != null;
        } catch (Exception e) {
            // 出现异常则认为用户名不存在
            return false;
        }
    }

    /**
     * 显示登录页面
     * 映射GET请求 /login
     * @return 返回登录页面视图
     */
    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    /**
     * 处理用户登录请求
     * 验证用户名和密码，登录成功后将用户信息存入session
     * @param username 用户名
     * @param password 密码
     * @param session HTTP会话对象
     * @param redirectAttributes 重定向属性
     * @return 登录成功跳转到首页，失败返回登录页面
     */
    @PostMapping("/doLogin")
    public String doLogin(@RequestParam("username") String username,
                          @RequestParam("password") String password,
                          HttpSession session,
                          RedirectAttributes redirectAttributes) {
        // 调用Service进行登录验证
        User user = userService.login(username, password);

        if (user != null) {
            // 登录成功，将用户信息存入session
            session.setAttribute("loginUser", user);

            // 重定向到首页
            return "redirect:/index";
        } else {
            // 登录失败，设置错误提示信息
            redirectAttributes.addFlashAttribute("error", "用户名或密码错误，或账号已被禁用");

            // 重定向回登录页面
            return "redirect:/login";
        }
    }

    /**
     * 用户退出登录
     * 清除session中的用户信息，并跳转到登录页面
     * @param session HTTP会话对象
     * @return 重定向到登录页面
     */
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        // 清除session中的用户信息
        session.removeAttribute("loginUser");

        // 重定向到登录页面
        return "redirect:/login";
    }

    /**
     * 显示系统首页
     * 用户登录成功后进入的页面
     * @return 返回首页视图
     */
    @GetMapping("/index")
    public String index() {
        return "index";
    }

    /**
     * 显示注册页面
     * @return 返回注册页面视图
     */
    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    /**
     * 处理用户注册请求
     * @param username 用户名
     * @param password 密码
     * @param confirmPassword 确认密码
     * @param realName 真实姓名
     * @param phone 联系电话
     * @param redirectAttributes 重定向属性
     * @return 注册成功跳转到登录页面，失败返回注册页面
     */
    @PostMapping("/doRegister")
    public String doRegister(@RequestParam("username") String username,
                             @RequestParam("password") String password,
                             @RequestParam("confirmPassword") String confirmPassword,
                             @RequestParam("realName") String realName,
                             @RequestParam(value = "phone", required = false) String phone,
                             RedirectAttributes redirectAttributes) {
        // 检查两次输入的密码是否一致
        if (!password.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "两次输入的密码不一致");
            return "redirect:/register";
        }

        // 检查用户名是否已存在
        if (isUsernameExists(username)) {
            redirectAttributes.addFlashAttribute("error", "用户名已存在");
            return "redirect:/register";
        }

        // 创建新用户
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password); // 实际项目中应该加密存储
        newUser.setRealName(realName);
        newUser.setPhone(phone);
        newUser.setRole("user"); // 默认为普通用户
        newUser.setStatus(1); // 默认启用

        // 保存用户
        boolean success = userService.save(newUser);
        if (success) {
            redirectAttributes.addFlashAttribute("success", "注册成功，请登录");
            return "redirect:/login";
        } else {
            redirectAttributes.addFlashAttribute("error", "注册失败，请稍后再试");
            return "redirect:/register";
        }
    }

    /**
     * 根路径重定向到登录页面
     * @return 重定向到登录页面
     */
    @GetMapping("/")
    public String root() {
        return "redirect:/login";
    }

}
