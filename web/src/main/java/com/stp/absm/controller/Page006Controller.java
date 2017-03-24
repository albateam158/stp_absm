package com.stp.absm.controller;

import com.stp.absm.model.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    @RequestMapping(value = "/result/result", method = RequestMethod.GET)
    public ModelAndView pageFormList(
            @RequestParam(value = "caId", required = false) Integer caId,
            @RequestParam(value = "pNo", required = false) Integer pNo,
            HttpServletRequest request,
            ModelAndView mav
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("caId",caId);

        List<AbsmCase> cases = absmCaseRepository.findByOrderByCaIdAsc();
//        List<AbsmPrivate> LPris = absmPrivateRepository.findByCaIdOrderByPrIdAsc(caId);
        List<AbsmPrivate> LPris = page006Mapper.selectPrivates(params);

//        Map<String , Object> params = new HashMap<String, Object>();
//        params.put("caId", caId);
//        params.put("pNo", pNo);

        /*List<AbsmFilter> filters = page006Mapper.selectResultData(params);*/
        AbsmPrivate aPri = new AbsmPrivate();
        aPri.setCaId(caId);
        aPri.setPrNo(pNo);
        mav.addObject("cases", cases);
        mav.addObject("LPris", LPris);
        mav.addObject("aPri", aPri);

        //mav.addObject("chartData", filters);
        //mav.addObject("bioChartData", filters);
        //mav.addObject("privateData");
        //mav.addObject("measureResult");
        mav.setViewName("result/result");

        return mav;
    }

    @RequestMapping(value = "/result/pri_combo" , method={RequestMethod.GET, RequestMethod.POST})
    public @ResponseBody List<AbsmPrivate> smallClassComboAjax(
            final HttpServletRequest request, final HttpServletResponse response) {
        String  caId = request.getParameter("caId");
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("caId",caId);

        List<AbsmPrivate> LPris = page006Mapper.selectPrivates(params);

        return LPris;
    }


    @RequestMapping(value = "/result/chart", method = RequestMethod.GET)
    public @ResponseBody Map<String, Object> chartInfoAjax(
            @RequestParam(value = "caId", required = false) Integer caId,
            @RequestParam(value = "pNo", required = false) Integer pNo,
            @RequestParam(value = "chartId", required = false) String chartId,
            HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();

        params.put("caId"   , caId);
        params.put("pNo"    , pNo);
        params.put("chartId", chartId);

        // Filter Data
        List<AbsmFilter>   chartInfo    = page006Mapper.selectResultData(params);
        // Video Data
        AbsmFile           absmFile     = page006Mapper.selectVideoUrl(params);
        // Event Data
        List<AbsmEvent>    events = page006Mapper.selectEvents(params);

        result.put("chartInfo", chartInfo);
        result.put("videoInfo", absmFile);
        result.put("events", events);

        return result;
    }

    /**
     * Filter값 조회 ajax
     * @param request
     * @return
     */
    @RequestMapping(value = "/result/filter", method = RequestMethod.GET)
    public @ResponseBody
    List<AbsmFilter> filterFormListAjax(
            @RequestParam(value = "caId", required = false) Integer caId,
            @RequestParam(value = "prId", required = false) Integer prId,
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
    @RequestMapping(value = "/result/model", method = RequestMethod.GET)
    public @ResponseBody
    List<AbsmModel> modelFormListAjax(
            @RequestParam(value = "caId", required = false) Integer caId,
            @RequestParam(value = "prId", required = false) Integer prId,
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
    @RequestMapping(value = "/result/measure", method = RequestMethod.GET)
    public @ResponseBody
    List<AbsmModel> measureFormListAjax(
            @RequestParam(value = "caId", required = false) Integer caId,
            @RequestParam(value = "prId", required = false) Integer prId,
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
