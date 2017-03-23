package com.stp.absm.controller;

import com.stp.absm.model.AbsmCase;
import com.stp.absm.model.AbsmPrivate;
import com.stp.absm.model.AbsmSurvey;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *  자료 조회 화면
 */

@RestController
public class Page005Controller extends RootController {

    private final Logger logger = LoggerFactory.getLogger(Page005Controller.class);
    /**
     * 조회화면
     * @param request
     * @param mav
     * @return
     */
    @RequestMapping(value = "/search/search", method = RequestMethod.GET)
    public ModelAndView pageFormList(
            HttpServletRequest request,
            ModelAndView mav
    ) {
        List<AbsmCase> cases = absmCaseRepository.findByOrderByCaIdAsc();
        List<AbsmPrivate> pris = absmPrivateRepository.findByOrderByPrIdAsc();

        mav.addObject("cases", cases);
        mav.addObject("pris", pris);

        mav.setViewName("search/search");

        return mav;
    }

    /**
     * 조회화면 목록 DIV
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/search/search_div", method = RequestMethod.GET)
    public Map<String, Object> pageFormListDiv(
            @RequestParam(value = "caId", required = false) String caId,
            @RequestParam(value = "name", required = false) String name,
            @RequestParam(value = "age", required = false) String age,
            @RequestParam(value = "sex", required = false) String sex,
            Pageable pageable,
            ModelAndView mav,
            HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();

        params.put("caId", caId);
        params.put("name", name);
        params.put("age", age);
        params.put("sex", sex);
        //params.put("pageable", pageable);

        logger.info("param info " + params.toString());

        //int count = page005Mapper.selectBoardsCount(params);
        List<AbsmSurvey> boards = page005Mapper.selectPrivateInfo(params);
        //String paging = pagingUtil.getPagingLink((int) Math.ceil((double) count / pageable.getPageSize()), count, pageable.getPageNumber() + 1, request.getRequestURI(), params);

        JSONObject jsonObject = new JSONObject();
        JSONArray cell = new JSONArray();

        for(int i=0; i < boards.size(); i++) {

            AbsmSurvey absmSurvey = (AbsmSurvey)boards.get(i);
            JSONObject obj = new JSONObject();

            obj.put( "caId"      , absmSurvey.getCaId());
            obj.put( "참가번호"   , absmSurvey.getPNo());
            obj.put( "이름"       , absmSurvey.getName());
            obj.put( "나이"       , absmSurvey.getAge());
            obj.put( "성별"       , absmSurvey.getSex());
            obj.put( "설문조사1"  , absmSurvey.getSuVal1());
            obj.put( "설문조사2"  , absmSurvey.getSuVal2());
            obj.put( "설문조사3"  , absmSurvey.getSuVal3());
            obj.put( "설문조사4"  , absmSurvey.getSuVal4());
            obj.put( "설문조사5"  , absmSurvey.getSuVal5());
            obj.put( "설문조사6"  , absmSurvey.getSuVal6());
            obj.put( "설문조사7"  , absmSurvey.getSuVal7());
            obj.put( "설문조사8"  , absmSurvey.getSuVal8());
            cell.add(obj);
        }

        jsonObject.put("rows", cell);

        result.put("boards", jsonObject);
        //result.put("paging", paging);

        //mav.addObject("boards", boards);
        //mav.addObject("paging", paging);
        //mav.setViewName("search/search_div");
        return result;
    }


}
