package com.stp.absm.security;

import com.stp.absm.model.XUser;
import com.stp.absm.repository.XAdminRepository;
import com.stp.absm.repository.XUserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class XAdminDetailService implements org.springframework.security.core.userdetails.UserDetailsService{

    @Autowired
    XAdminRepository xAdminRepository;

    @Autowired
    XUserRepository xUserRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        //XAdmin xadmin = xAdminRepository.findByEmpNo(username);
        XUser xuser = xUserRepository.findByEmpNo(username);

        if( xuser == null ) throw new UsernameNotFoundException(String.format("User with email=%s was not found", username));

        return xuser;
    }
}
