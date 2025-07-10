package com.example.techwiz.dto;

import java.util.List;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public class LoginResponseDto{
    @NotBlank(message="Username cannot be blank")
    private String username;
    @NotBlank(message="Email cannot be blank")
    private String email;
    @NotBlank(message="Token cannot be blank")
    private String token;
    @NotNull(message="Role ID cannot be blank")
    private List <Integer> roleIds;

    public LoginResponseDto(String email, List<Integer> roleIds, String token, String username) {
        this.email = email;
        this.roleIds = roleIds;
        this.token = token;
        this.username = username;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public List<Integer> getRoleIds() {
        return roleIds;
    }

    public void setRoleIds(List<Integer> roleIds) {
        this.roleIds = roleIds;
    }
}