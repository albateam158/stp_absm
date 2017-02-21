package com.stp.absm.model;

import java.util.Collection;
import java.util.Date;
import java.util.HashSet;

import javax.persistence.*;

import com.stp.absm.type.UserStateType;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Data;

@Data
@Entity
@Table(name = "kams_user")
public class XUser implements UserDetails {



    private static final long serialVersionUID = -2738022895591545143L;

    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private String userId;
    private String empNo;
    private String password;
    private String name;
    private String email;
    private String deptCd;
    private String adminType;
    private String phone;
    private String profileImageUrl;
    private String userState = UserStateType.NORMAL;

    private Date regDate;
    private Date updateDate;
    private Date deleteDate;
    private Date outDate;
    private Date outedDate;


//    @Override
//    public Collection<? extends GrantedAuthority> getAuthorities() {
//        Collection<GrantedAuthority> authorities = new HashSet<GrantedAuthority>(1);
//        authorities.add(new SimpleGrantedAuthority("ROLE_EMP"));
////      "ADMIN"; //관리자
////      "RECORD"; //실적관리자
////      "DEPT"; //부서관리자
////      "EMP"; //사원
//
//       if( AdminType.ADMIN.equals(adminType) == true ){
//            authorities.add(new SimpleGrantedAuthority("ROLE_ADMIN."));
//       }else if( AdminType.RECORD.equals(adminType) == true ){
//            authorities.add(new SimpleGrantedAuthority("ROLE_RECORD"));
//       }else if( AdminType.DEPT.equals(adminType) == true ){
//           authorities.add(new SimpleGrantedAuthority("ROLE_DEPT"));
//       }
//
//        return authorities;
//    }


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
