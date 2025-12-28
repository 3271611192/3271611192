package com.wuye.interceptor;

import com.wuye.entity.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 登录拦截器
 * 拦截未登录用户访问受保护的资源，自动跳转到登录页面
 */
public class LoginInterceptor implements HandlerInterceptor {

    /**
     * 在Controller方法执行之前进行拦截
     * 检查用户是否已登录，未登录则重定向到登录页面
     * @param request HTTP请求对象
     * @param response HTTP响应对象
     * @param handler 处理器
     * @return true-放行，false-拦截
     * @throws Exception 异常
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 获取当前会话
        HttpSession session = request.getSession();
        
        // 从session中获取登录用户信息
        User user = (User) session.getAttribute("loginUser");
        
        // 判断用户是否已登录
        if (user != null) {
            // 已登录，放行
            return true;
        } else {
            // 未登录，重定向到登录页面
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
    }
}
