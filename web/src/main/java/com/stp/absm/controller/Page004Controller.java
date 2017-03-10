package com.stp.absm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.stp.absm.model.AbsmCase;
import com.stp.absm.model.AbsmFile;
import com.stp.absm.model.AbsmPrivate;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;

import com.stp.absm.model.KamsBoardContent;

/**
 *  동영상 자료 화면
 */

@RestController
public class Page004Controller extends RootController {

    /**
     * 조회화면
     * @param request
     * @param mav
     * @return
     */
    @RequestMapping(value = "/page004/list", method = RequestMethod.GET)
    public ModelAndView pageFormList(
            HttpServletRequest request,
            ModelAndView mav
    ) {
        List<AbsmCase> cases = absmCaseRepository.findByDeleteDateIsNullOrderByCaIdAsc();
        List<AbsmPrivate> pris = absmPrivateRepository.findByDeleteDateIsNullOrderByPrIdAsc();

        mav.addObject("cases", cases);
        mav.addObject("pris", pris);

        mav.setViewName("page004/list");

        return mav;
    }

    /**
     * 조회화면 목록 DIV
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/page004/list_div", method = RequestMethod.GET)
    public ModelAndView pageFormListDiv(
            @RequestParam(value = "caId", required = false) String caId,
            @RequestParam(value = "prId", required = false) String prId,
            @RequestParam(value = "fileCd", required = false) String fileCd,
            Pageable pageable,
            ModelAndView mav,
            HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("caId", caId);
        params.put("prId", prId);
        params.put("fileCd", fileCd);

        int count = page004Mapper.selectBoardsCount(params);
        List<AbsmFile> boards = page004Mapper.selectBoards(params);
        String paging = pagingUtil.getPagingLink((int) Math.ceil((double) count / pageable.getPageSize()), count, pageable.getPageNumber() + 1, request.getRequestURI(), params);

        mav.addObject("boards", boards);
        mav.addObject("paging", paging);
        mav.setViewName("page004/list_div");
        return mav;
    }

    /**
     * 입력처리
     * @param request
     * @return
     */
    @RequestMapping(value = "/page004/form", method = RequestMethod.POST)
    public Map<String, Object> pageFormSubmit(
            WebRequest request
    ) {

        Map<String, Object> result = new HashMap<String, Object>();
        return result;
    }


}
