package com.example.techwiz.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.techwiz.dto.UserRolesDto;
import com.example.techwiz.jparepository.RoleRepository;
import com.example.techwiz.jparepository.UsersRepository;
import com.example.techwiz.mapper.UserRoleMapper;
import com.example.techwiz.model.Roles;
import com.example.techwiz.model.Users;

@Service
public class UserServices {

    @Autowired private UsersRepository usersRepository;
    @Autowired private RoleRepository roleRepository;
    @Autowired private PasswordEncoder passwordEncoder;
    public String addUser(UserRolesDto dto){
        Users users = UserRoleMapper.toEntity(dto);
        users.setPassword(passwordEncoder.encode(dto.getPassword()));
        List<Roles> roles = roleRepository.findAllById(dto.getRoleIds());
        users.setRoles(roles);
        usersRepository.save(users);
        return users.getUsername() + " added successfully";
    }
}
