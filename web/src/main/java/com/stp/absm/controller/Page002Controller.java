package com.stp.absm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.stp.absm.model.AbsmCase;
import com.stp.absm.model.AbsmMeasure;
import com.stp.absm.model.AbsmPrivate;
import com.stp.absm.repository.AbsmCaseRepository;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;

import com.stp.absm.model.KamsBoardContent;

/**
 * 실험대상자 측정자료입력 화면
 */

@RestController
public class Page002Controller extends RootController {

    /**
     * 조회화면
     * @param request
     * @param mav
     * @return
     */
    @RequestMapping(value = "/page002/list", method = RequestMethod.GET)
    public ModelAndView pageFormList(
            HttpServletRequest request,
            ModelAndView mav
    ) {
        List<AbsmCase> cases = absmCaseRepository.findByDeleteDateIsNullOrderByCaIdAsc();
        List<AbsmPrivate> pris = absmPrivateRepository.findByDeleteDateIsNullOrderByPrIdAsc();

        mav.addObject("cases", cases);
        mav.addObject("pris", pris);

        mav.setViewName("page002/list");

        return mav;
    }

    /**
     * 조회화면 목록 DIV
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/page002/list_div", method = RequestMethod.GET)
    public ModelAndView pageFormListDiv(
            @RequestParam(value = "caId", required = false) String caId,
            @RequestParam(value = "prId", required = false) String prId,
            Pageable pageable,
            ModelAndView mav,
            HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("caId", caId);
        params.put("prId", prId);
        params.put("pageable", pageable);

        int count = page002Mapper.selectBoardsCount(params);
        List<AbsmMeasure> boards = page002Mapper.selectBoards(params);
        String paging = pagingUtil.getPagingLink((int) Math.ceil((double) count / pageable.getPageSize()), count, pageable.getPageNumber() + 1, request.getRequestURI(), params);

        mav.addObject("boards", boards);
        mav.addObject("paging", paging);
        mav.setViewName("page002/list_div");
        return mav;
    }

    /**
     * 케이스변경시 개인데이터 리로드 Ajax
     * 전화면 공통 사용
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/page002/private_combo" , method={RequestMethod.GET, RequestMethod.POST})
    public @ResponseBody List<AbsmPrivate> smallClassComboAjax(
            final HttpServletRequest request, final HttpServletResponse response)
    {
        String caId = request.getParameter("caId");
        List<AbsmPrivate> pris = absmPrivateRepository.findByCaIdAndDeleteDateIsNullOrderByPrIdAsc(caId);

        return pris;
    }

    /**
     * 입력처리
     * @param request
     * @return
     */
    @RequestMapping(value = "/page002/form", method = RequestMethod.POST)
    public Map<String, Object> pageFormSubmit(
            WebRequest request
    ) {

        Map<String, Object> result = new HashMap<String, Object>();
        return result;
    }


}
