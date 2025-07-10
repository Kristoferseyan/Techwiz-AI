package com.example.techwiz.securitystuff;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.techwiz.jparepository.UsersRepository;
import com.example.techwiz.model.Users;

@Service
public class CustomUserDetailsService implements UserDetailsService{
    @Autowired
    private UsersRepository usersRepository;
    

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Users user = usersRepository.findByUsername(username)
            .orElseThrow(() -> new UsernameNotFoundException(username + " user not found"));

        List<GrantedAuthority> authorities = user
                                                .getRoles()
                                                .stream()
                                                .map(role -> new SimpleGrantedAuthority("ROLE_" + role.getName()))
                                                .collect(Collectors.toList());
        return new User(user.getUsername(),user.getPassword(),authorities);
    }
    
}
