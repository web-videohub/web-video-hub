package com.teamrocket.videohub.config;

import com.teamrocket.videohub.interceptor.AfterLoginInterceptor;
import com.teamrocket.videohub.interceptor.BeforeLoginInterceptor;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@RequiredArgsConstructor
public class InterceptorConfig implements WebMvcConfigurer {

    private final AfterLoginInterceptor afterLoginInterceptor;
    private final BeforeLoginInterceptor beforeLoginInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry
                .addInterceptor(afterLoginInterceptor)
                .addPathPatterns("/login", "/register", "/find-pw")
                ;

        registry
                .addInterceptor(beforeLoginInterceptor)
                .addPathPatterns("/studio", "/setting")
                ;
    }
}
