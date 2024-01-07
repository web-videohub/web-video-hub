package com.teamrocket.videohub.repository;

import com.teamrocket.videohub.entity.Member;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface MemberMapper {

    boolean save(Member member);

    Member findMember(String userAccount);

    boolean isDuplicate(@Param("type") String type, @Param("keyword") String keyword);

    boolean isConsistent(@Param("account") String account, @Param("email") String email);

    boolean modifyPassword(@Param("account") String account, @Param("password") String newPassword);
}
