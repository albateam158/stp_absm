package com.stp.absm.controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by bridge on 15. 12. 17..
 */
@Controller
public class AuthController {

    @RequestMapping(value = "/login")
    public ModelAndView login(
            @RequestParam(value = "message", required = false) String message,
            ModelAndView mav
    ) {
        mav.addObject("message", message);
        mav.setViewName("login");

        return mav;
    }


}
