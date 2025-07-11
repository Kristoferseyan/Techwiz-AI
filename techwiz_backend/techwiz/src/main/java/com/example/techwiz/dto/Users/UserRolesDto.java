package com.example.techwiz.dto.Users;

import java.util.List;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public class UserRolesDto {
    @NotBlank(message="Username cannot be blank")
    private String username;
    @NotBlank(message="Password cannot be blank")
    private String password;
    @NotBlank(message="Email cannot be blank")
    private String email;
    @NotNull(message="RoleId cannot be null")
    private List<Integer> roleIds;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public List<Integer> getRoleIds() {
        return roleIds;
    }

    public void setRoleIds(List<Integer> roleIds) {
        this.roleIds = roleIds;
    }


}
