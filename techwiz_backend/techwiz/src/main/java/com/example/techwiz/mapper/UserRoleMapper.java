package com.example.techwiz.mapper;

import com.example.techwiz.dto.Users.UserRolesDto;
import com.example.techwiz.model.Users;

public class UserRoleMapper {
    public static Users toEntity(UserRolesDto dto){
        Users users = new Users();
        users.setUsername(dto.getUsername());
        users.setPassword(dto.getPassword());
        users.setEmail(dto.getEmail());
        return users;
    }


}
