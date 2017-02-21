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
     * 모집등록 form
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


        mav.setViewName("main/main_form");

        return mav;
    }


    @RequestMapping(value = "/main/form", method = RequestMethod.POST)
    public Map<String, Object> addForm(
            @RequestParam(value = "mainId", required = false) Integer mainId,
            @RequestParam(value = "projectId", required = true) Integer projectId,
            @RequestParam(value = "title", required = true) String title,
            @RequestParam(value = "summary", required = false) String summary,
            @RequestParam(value = "url", required = false) String url,
            @RequestParam(value = "image", required = false) String image,
            @RequestParam(value = "status", required = false) String status

    ) {
        Map<String, Object> result = new HashMap<String, Object>();


        return result;
    }


    /**
     * 모집공고 조회
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/main/list", method = RequestMethod.GET)
    public ModelAndView list(
            ModelAndView mav, WebRequest request
    ) {

        mav.setViewName("main/main_list");

        return mav;
    }

    /**
     * 모집공고 조회 div
     * @param keyword
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/main/list_div", method = RequestMethod.GET)
    public ModelAndView listDiv(
            @RequestParam(value = "keyword", required = false) String keyword,
            Pageable pageable,
            ModelAndView mav, HttpServletRequest request
    ) {

        Map<String, Object> params = new HashMap<String, Object>();
        params.put("keyword"    , keyword);
        params.put("pageable"   , pageable);


        mav.setViewName("main/main_list_div");

        return mav;
    }


    @RequestMapping(value = "/main", method = RequestMethod.DELETE)
    public Map<String, Object> mainProjectDelete(
            @RequestParam(value = "mainIds", required = true) String mainIds,
            WebRequest request
    ) {
        Map<String, Object> result = new HashMap<String, Object>();

        String[] mainProjectArr = mainIds.split(",");


        return result;
    }

}
