package com.example.techwiz.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.techwiz.dto.Auth.AuthDto;
import com.example.techwiz.dto.Auth.LoginResponseDto;
import com.example.techwiz.services.Auth.AuthService;

import jakarta.validation.Valid;


@RestController
@RequestMapping("/auth")
public class AuthController {
    @Autowired AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<LoginResponseDto> login(@Valid @RequestBody AuthDto dto) {
        LoginResponseDto responseDto= authService.authLogin(dto);

        return ResponseEntity.ok(responseDto);
    }
    
}
