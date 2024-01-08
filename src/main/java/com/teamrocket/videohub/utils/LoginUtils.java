package com.teamrocket.videohub.utils;

import com.teamrocket.videohub.dto.response.LoginUserResponseDTO;

import javax.servlet.http.HttpSession;

public class LoginUtils {
    public static final String LOGIN_KEY = "login";

    public static final String AUTO_LOGIN_COOKIE = "auto";

    public static boolean isLogin(HttpSession session) {
        return session.getAttribute(LOGIN_KEY) != null;
    }

    public static String getCurrentLoginMemberAccount(HttpSession session) {
        LoginUserResponseDTO loginUserInfo
                = (LoginUserResponseDTO) session.getAttribute(LOGIN_KEY);
        return loginUserInfo.getUserAccount();
    }
}
