package com.example.techwiz.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.techwiz.dto.Users.UserRolesDto;
import com.example.techwiz.services.UserServices;

import jakarta.validation.Valid;


@RestController
@RequestMapping("/user")
public class UserController {
    @Autowired private UserServices userServices;

    @PostMapping("/addUser")
    public ResponseEntity<?> addUser(@Valid @RequestBody UserRolesDto dto) { 
        userServices.addUser(dto);
        return ResponseEntity.ok("User added successfully");
    }
    
}
