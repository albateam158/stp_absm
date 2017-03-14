package com.stp.absm.controller;

import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@RestController
public class MainController extends RootController{


    /**
     * main form
     * @param mainId
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/main/form", method = RequestMethod.GET)
    public ModelAndView form(
            @RequestParam(value = "mainId", required = false) Integer mainId,
            ModelAndView mav, WebRequest request,
            Pageable pageable
    ) {
        Map<String, Object> params = new HashMap<String, Object>();


        mav.setViewName("main");

        return mav;
    }

}
