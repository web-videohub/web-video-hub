package com.teamrocket.videohub.interceptor;

import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import static com.teamrocket.videohub.utils.LoginUtils.isLogin;

@Configuration
@Slf4j
public class AfterLoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(
            HttpServletRequest request,
            HttpServletResponse response,
            Object handler) throws Exception {
        log.info("after login interceptor execute");

        HttpSession session = request.getSession();

        if(isLogin(session)) {
            response.sendRedirect("/");
            return false;
        }
        return true;
    }
}
