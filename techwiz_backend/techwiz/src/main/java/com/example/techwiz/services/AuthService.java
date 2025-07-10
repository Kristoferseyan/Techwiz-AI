package com.example.techwiz.services;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.techwiz.dto.AuthDto;
import com.example.techwiz.dto.LoginResponseDto;
import com.example.techwiz.jparepository.UsersRepository;
import com.example.techwiz.model.Roles;
import com.example.techwiz.model.Users;
import com.example.techwiz.securitystuff.JwtUtil;

@Service
public class AuthService {
    @Autowired UsersRepository usersRepository;
    @Autowired PasswordEncoder passwordEncoder;
    @Autowired JwtUtil jwtUtil;

    public LoginResponseDto authLogin (AuthDto dto){
        Users user = usersRepository.findByUsername(dto.getUsername())
            .orElseThrow(() -> new UsernameNotFoundException("Username not found"));
        if(!passwordEncoder.matches(dto.getPassword(), user.getPassword())){
            throw new BadCredentialsException("Password Incorrect");
        }
        String jwt = jwtUtil.generateToken(user);
        List<Integer> roles = user.getRoles().stream().map(Roles::getId).collect(Collectors.toList()); 

        return new LoginResponseDto(
            user.getEmail(),
            roles,
            jwt,
            user.getUsername()
        );
    }
}
