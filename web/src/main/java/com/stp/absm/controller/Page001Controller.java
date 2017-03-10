package com.stp.absm.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.stp.absm.model.*;

/**
 * 개인특성자료입력 화면
 */

@RestController
public class Page001Controller extends RootController {

    /**
     * 조회화면
     * @param request
     * @param mav
     * @return
     */
    @RequestMapping(value = "/page001/list", method = RequestMethod.GET)
    public ModelAndView pageFormList(
            HttpServletRequest request,
            ModelAndView mav
    ) {

        mav.setViewName("page001/list");
        return mav;
    }

    /**
     * 조회화면 목록 DIV
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/page001/list_div", method = RequestMethod.GET)
    public ModelAndView pageFormListDiv(
            @RequestParam(value = "dt", required = false) String dt,
            @RequestParam(value = "caId", required = false) String caId,
            @RequestParam(value = "note", required = false) String note,
            Pageable pageable,
            ModelAndView mav,
            HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("dt", dt);
        params.put("caId", caId);
        params.put("note", note);
        params.put("pageable", pageable);

        int count = page001Mapper.selectBoardsCount(params);
        List<AbsmPrivate> boards = page001Mapper.selectBoards(params);
        String paging = pagingUtil.getPagingLink((int) Math.ceil((double) count / pageable.getPageSize()), count, pageable.getPageNumber() + 1, request.getRequestURI(), params);

        mav.addObject("boards", boards);
        mav.addObject("paging", paging);
        mav.setViewName("page001/list_div");
        return mav;
    }

    /**
     * 입력처리
     * @param request
     * @return
     */
    @RequestMapping(value = "/page001/form", method = RequestMethod.POST)
    public Map<String, Object> pageFormSubmit(
            WebRequest request
    ) {

        Map<String, Object> result = new HashMap<String, Object>();
        return result;
    }


}
