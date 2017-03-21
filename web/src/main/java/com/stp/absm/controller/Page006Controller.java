package com.stp.absm.controller;

import com.stp.absm.model.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
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
            HttpServletRequest request,
            ModelAndView mav
    ) {
        List<AbsmCase> cases = absmCaseRepository.findByDeleteDateIsNullOrderByCaIdAsc();
        List<AbsmPrivate> pris = absmPrivateRepository.findByDeleteDateIsNullOrderByPrIdAsc();

        /*Map<String , Object> params = new HashMap<String, Object>();
        params.put("caId", caId);
        params.put("pNo", pNo);
        params.put("chartId", 1);

        List<AbsmFilter> filters = page006Mapper.selectResultData(params);*/

        mav.addObject("cases", cases);
        mav.addObject("pris", pris);

        //mav.addObject("chartData", filters);
        //mav.addObject("bioChartData", filters);
        //mav.addObject("privateData");
        //mav.addObject("measureResult");
        mav.setViewName("result/result");

        return mav;
    }

    @RequestMapping(value = "/result/chart", method = RequestMethod.GET)
    public @ResponseBody Map<String, Object> chartInfoAjax(
            @RequestParam(value = "caId", required = false) String caId,
            @RequestParam(value = "pNo", required = false) String pNo,
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

        result.put("chartInfo", chartInfo);
        result.put("videoInfo", absmFile);

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
    @RequestMapping(value = "/result/model", method = RequestMethod.GET)
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
    @RequestMapping(value = "/result/measure", method = RequestMethod.GET)
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
