package com.stp.absm.security;

import com.stp.absm.model.XUser;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class XAdminControllerAdvice {

    @ModelAttribute("user")
    public XUser getCurrentUser(Authentication authentication) {

        return (authentication == null) ? null : (XUser) authentication.getPrincipal();
    }
}