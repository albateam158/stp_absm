package com.stp.absm.model;

import com.stp.absm.type.UserStateType;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;

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

    public Date getOutedDate() {
        return outedDate;
    }

    public void setOutedDate(Date outedDate) {
        this.outedDate = outedDate;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getEmpNo() {
        return empNo;
    }

    public void setEmpNo(String empNo) {
        this.empNo = empNo;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDeptCd() {
        return deptCd;
    }

    public void setDeptCd(String deptCd) {
        this.deptCd = deptCd;
    }

    public String getAdminType() {
        return adminType;
    }

    public void setAdminType(String adminType) {
        this.adminType = adminType;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getProfileImageUrl() {
        return profileImageUrl;
    }

    public void setProfileImageUrl(String profileImageUrl) {
        this.profileImageUrl = profileImageUrl;
    }

    public String getUserState() {
        return userState;
    }

    public void setUserState(String userState) {
        this.userState = userState;
    }

    public Date getRegDate() {
        return regDate;
    }

    public void setRegDate(Date regDate) {
        this.regDate = regDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public Date getDeleteDate() {
        return deleteDate;
    }

    public void setDeleteDate(Date deleteDate) {
        this.deleteDate = deleteDate;
    }

    public Date getOutDate() {
        return outDate;
    }

    public void setOutDate(Date outDate) {
        this.outDate = outDate;
    }

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
