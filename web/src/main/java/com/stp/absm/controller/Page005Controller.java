package com.stp.absm.controller;

import com.stp.absm.model.*;
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
            @RequestParam(value = "searchCode", required = false) String searchCode,
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
        params.put("searchCode", searchCode);

        JSONObject jsonObject = new JSONObject();
        JSONArray cell = new JSONArray();

        List<Map<String, Object>> searchList = page005Mapper.selectAbsmData(params);

        if ("1".equals(searchCode)) {
            // 개인자료

            for(int i=0; i < searchList.size(); i++) {

                HashMap<String, Object> searchMap = (HashMap<String, Object>)searchList.get(i);
                JSONObject obj = new JSONObject();

                obj.put( "caId"      , searchMap.get("ca_id"));
                obj.put( "케이스명"   , searchMap.get("case_nm"));
                obj.put( "참가번호"   , searchMap.get("p_no"));
                obj.put( "이름"       , searchMap.get("name"));
                obj.put( "나이"       , searchMap.get("age"));
                obj.put( "성별"       , searchMap.get("sex"));
                cell.add(obj);
            }
        }
        else if ("2".equals(searchCode)) {
            // 설문조사

            for(int i=0; i < searchList.size(); i++) {

                HashMap<String, Object> searchMap = (HashMap<String, Object>)searchList.get(i);
                JSONObject obj = new JSONObject();

                obj.put( "caId"      , searchMap.get("ca_id"));
                obj.put( "케이스명"   , searchMap.get("case_nm"));
                obj.put( "참가번호"   , searchMap.get("p_no"));
                obj.put( "이름"       , searchMap.get("name"));
                obj.put( "나이"       , searchMap.get("age"));
                obj.put( "성별"       , searchMap.get("sex"));
                obj.put( "판교역 출입구"  , searchMap.get("su_val1"));
                obj.put( "판교역 플랫폼"  , searchMap.get("su_val2"));
                obj.put( "지하철 탑승"    , searchMap.get("su_val3"));
                obj.put( "지하철 하차"    , searchMap.get("su_val4"));
                obj.put( "강남역 출입구"  , searchMap.get("su_val5"));
                obj.put( "버스정류장"     , searchMap.get("su_val6"));
                obj.put( "버스탑승"       , searchMap.get("su_val7"));
                obj.put( "버스하차"       , searchMap.get("su_val8"));
                cell.add(obj);
            }
        }
        else if ("3".equals(searchCode)) {
            // 이벤트

            for(int i=0; i < searchList.size(); i++) {

                HashMap<String, Object> searchMap = (HashMap<String, Object>)searchList.get(i);
                JSONObject obj = new JSONObject();

                obj.put( "caId"      , searchMap.get("ca_id"));
                obj.put( "케이스명"   , searchMap.get("case_nm"));
                obj.put( "참가번호"   , searchMap.get("p_no"));
                obj.put( "이름"       , searchMap.get("name"));
                obj.put( "나이"       , searchMap.get("age"));
                obj.put( "성별"       , searchMap.get("sex"));
                obj.put( "대기지점출발"  , searchMap.get("ev_dt1"));
                obj.put( "판교역 출입구"  , searchMap.get("ev_dt2"));
                obj.put( "판교역 플랫폼"  , searchMap.get("ev_dt3"));
                obj.put( "지하철 탑승"    , searchMap.get("ev_dt4"));
                obj.put( "지하철 하차"    , searchMap.get("ev_dt5"));
                obj.put( "강남역 출입구"  , searchMap.get("ev_dt6"));
                obj.put( "버스정류장"     , searchMap.get("ev_dt7"));
                obj.put( "버스탑승"       , searchMap.get("ev_dt8"));
                obj.put( "버스하차"       , searchMap.get("ev_dt9"));
                obj.put( "대기지점"       , searchMap.get("ev_dt10"));

                cell.add(obj);
            }
        }
        else if ("4".equals(searchCode)) {
            // 생체정보
            for(int i=0; i < searchList.size(); i++) {

                HashMap<String, Object> searchMap = (HashMap<String, Object>)searchList.get(i);
                JSONObject obj = new JSONObject();

                obj.put( "caId"      , searchMap.get("ca_id"));
                obj.put( "케이스명"   , searchMap.get("case_nm"));
                obj.put( "참가번호"   , searchMap.get("p_no"));
                obj.put( "이름"       , searchMap.get("name"));
                obj.put( "나이"       , searchMap.get("age"));
                obj.put( "성별"       , searchMap.get("sex"));
                obj.put( "ECG/GSR구분"  , searchMap.get("eg_cd"));
                obj.put( "측정시간"  , searchMap.get("me_tm"));
                obj.put( "측정값"  , searchMap.get("me_val"));

                cell.add(obj);
            }

        }
        else if ("5".equals(searchCode)) {
            // 업로드파일
            for(int i=0; i < searchList.size(); i++) {

                HashMap<String, Object> searchMap = (HashMap<String, Object>)searchList.get(i);
                JSONObject obj = new JSONObject();

                obj.put( "caId"      , searchMap.get("ca_id"));
                obj.put( "케이스명"   , searchMap.get("case_nm"));
                obj.put( "참가번호"   , searchMap.get("p_no"));
                obj.put( "이름"       , searchMap.get("name"));
                obj.put( "나이"       , searchMap.get("age"));
                obj.put( "성별"       , searchMap.get("sex"));
                obj.put( "파일명"  , searchMap.get("file_name"));
                obj.put( "파일구분"  , searchMap.get("file_cd"));
                obj.put( "업로드일자"  , searchMap.get("reg_date"));
                obj.put( "파일다운"  , searchMap.get("url"));
                cell.add(obj);
            }

        }

        jsonObject.put("rows", cell);
        result.put("boards", jsonObject);

        return result;
    }


}
