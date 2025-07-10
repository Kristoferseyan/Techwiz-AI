package com.example.techwiz.jparepository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.techwiz.model.Roles;

public interface RoleRepository extends JpaRepository<Roles, Integer>{
    
}
