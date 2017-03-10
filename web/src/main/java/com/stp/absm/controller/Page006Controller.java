package com.stp.absm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.stp.absm.model.*;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;

/**
 * 결과보기 화면
 */

@RestController
public class Page006Controller extends RootController {

    /**
     * 조회화면
     * @param request
     * @param mav
     * @return
     */
    @RequestMapping(value = "/page006/list", method = RequestMethod.GET)
    public ModelAndView pageFormList(
            HttpServletRequest request,
            ModelAndView mav
    ) {
        List<AbsmCase> cases = absmCaseRepository.findByDeleteDateIsNullOrderByCaIdAsc();
        List<AbsmPrivate> pris = absmPrivateRepository.findByDeleteDateIsNullOrderByPrIdAsc();

        mav.addObject("cases", cases);
        mav.addObject("pris", pris);

        mav.setViewName("page006/list");

        return mav;
    }

    /**
     * Filter값 조회 ajax
     * @param request
     * @return
     */
    @RequestMapping(value = "/page006/filter", method = RequestMethod.GET)
    public @ResponseBody
    List<AbsmFilter> filterFormListAjax(
            @RequestParam(value = "caId", required = false) String caId,
            @RequestParam(value = "prId", required = false) String prId,
            HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("caId", caId);
        params.put("prId", prId);

        List<AbsmFilter> filters = page006Mapper.selectFilters(params);

        return filters;
    }

    /**
     * Model값 조회 ajax
     * @param request
     * @return
     */
    @RequestMapping(value = "/page006/model", method = RequestMethod.GET)
    public @ResponseBody
    List<AbsmModel> modelFormListAjax(
            @RequestParam(value = "caId", required = false) String caId,
            @RequestParam(value = "prId", required = false) String prId,
            HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("caId", caId);
        params.put("prId", prId);

        List<AbsmModel> models = page006Mapper.selectModels(params);

        return models;
    }

    /**
     * Measure값 조회 ajax
     * @param request
     * @return
     */
    @RequestMapping(value = "/page006/measure", method = RequestMethod.GET)
    public @ResponseBody
    List<AbsmModel> measureFormListAjax(
            @RequestParam(value = "caId", required = false) String caId,
            @RequestParam(value = "prId", required = false) String prId,
            @RequestParam(value = "egCd", required = false) String egCd,
            @RequestParam(value = "lastRow", required = false) String lastRow,

            HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("caId", caId);
        params.put("prId", prId);
        params.put("egCd", egCd);
        params.put("lastRow", lastRow);

        List<AbsmModel> models = page006Mapper.selectModels(params);

        return models;
    }



}
