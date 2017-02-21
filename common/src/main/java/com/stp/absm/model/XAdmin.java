package com.stp.absm.model;

import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;

@Data
@Entity
@Table(name = "kams_admin")
public class XAdmin implements UserDetails {


    private static final long serialVersionUID = 4738825834389687602L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer adminId;
    private String empNo;
    private String password;
    private String name;
    private String deptCd;
    private String adminType;
    private Date regDate;
    private Date updateDate;
    private Date deleteDate;


    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Collection<GrantedAuthority> authorities = new HashSet<GrantedAuthority>(1);
        authorities.add(new SimpleGrantedAuthority("ROLE_SUPERVISOR"));
        return authorities;
    }

    @Override
    public String getUsername() {
        return name;
    }

    @Override
    public String getPassword() {
        return password;
    }


    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
