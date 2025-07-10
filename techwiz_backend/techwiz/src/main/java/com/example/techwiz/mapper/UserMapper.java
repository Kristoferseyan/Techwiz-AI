package com.example.techwiz.mapper;

import com.example.techwiz.dto.UsersDto;
import com.example.techwiz.model.Users;

public class UserMapper {
    public static Users toEntity(UsersDto dto){
        Users user = new Users();
        user.setUsername(dto.getUsername());
        user.setPassword(dto.getPassword());
        user.setEmail(dto.getEmail());
        return user;
    }
}
