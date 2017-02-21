package com.stp.absm.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.stp.absm.model.*;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;

import com.stp.absm.model.dz.DzDept;

@RestController
public class RecordController extends RootController {

    private final Logger log = LoggerFactory.getLogger(RecordController.class);


    /**
     * 실적 등록 form
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/record/form", method = RequestMethod.GET)
    public ModelAndView form(
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam(value = "dt", required = false) String dt,
            @RequestParam(value = "deptCd", required = false) String deptCd,
            @RequestParam(value = "prod", required = false) String prod,
            @RequestParam(value = "acc", required = false) String acc,
            Pageable pageable,
            ModelAndView mav, HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        Map<String, Object> comboParams = new HashMap<String, Object>();
        XUser user = (XUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Date now        = new Date();
        String today    = DateFormatUtils.format(now, "yyyyMMdd");

        if(user.getAdminType().equals("ADMIN") || user.getAdminType().equals("SYSAD")){
            deptCd = null;
            comboParams.put("adminType",user.getAdminType());
        }else{
            deptCd = user.getDeptCd();
            comboParams.put("deptCd",deptCd);
        }
//        if(dt == null) dt = today;

        params.put("dt",dt);
        params.put("deptCd",deptCd);
//        params.put("prod",prod);
//        params.put("acc",acc);
        KPlList kPlList = null;
        if(id != null ){
            params.put("id",id);
            kPlList = kamsRecordMapper.selectPlOne(params);
            System.out.println("record : "+ kPlList.getId());
            mav.addObject("record", kPlList);
        }

        List<DzDept> dzDepts            = kamsRecordMapper.selectTbDeptsGrpByDeptCd(comboParams);
        List<DzDept> dzDepts1            = kamsRecordMapper.selectTbDeptsGrpByDeptCd(null);

        List<KAccCode> kAccCodes        = kamsRecordMapper.selectAccCdList(comboParams);
        List<KProdCode> kProdCodes        = kamsRecordMapper.selectProdCdList(comboParams);
        mav.addObject("record", kPlList);
        mav.addObject("dzDepts", dzDepts);
        mav.addObject("dzDepts1", dzDepts1);

        mav.addObject("kAccCodes", kAccCodes);
        mav.addObject("kProdCodes", kProdCodes);

        mav.setViewName("record/record_form");

        return mav;
    }
    /**
     * 실적 등록 form
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/record/form_list_div", method = RequestMethod.GET)
    public ModelAndView form_list_div(
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam(value = "dt", required = false) String dt,
            @RequestParam(value = "deptCd", required = false) String deptCd,
            @RequestParam(value = "prod", required = false) String prod,
            @RequestParam(value = "acc", required = false) String acc,
            Pageable pageable,
            ModelAndView mav, HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        Map<String, Object> comboParams = new HashMap<String, Object>();
        XUser user = (XUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Date now        = new Date();
        String today    = DateFormatUtils.format(now, "yyyyMMdd");

        if(!(user.getAdminType().equals("ADMIN") || user.getAdminType().equals("SYSAD"))){
            deptCd = user.getDeptCd();
        }
        dt = (dt != null) ? dt.replaceAll("-", "") : today;
        
//        if(dt == null) dt = today;
        params.put("dt",dt);
        params.put("deptCd",deptCd);
//        params.put("prod",prod);
//        params.put("acc",acc);

        params.put("pageable"   , pageable);
        int count = kamsRecordMapper.selectPlListCount(params);
        List<KPlList> kPlLists = kamsRecordMapper.selectPlList(params);
        mav.addObject("kPlLists", kPlLists);
        System.out.println("kPlLists : "+ kPlLists.size());

//        for(KPlList a: kPlLists){
//            System.out.println("kPlLists : "+ a.getId());
//        }

        String paging = pagingUtil.getPagingLink((int)Math.ceil((double)count / pageable.getPageSize()), count, pageable.getPageNumber() + 1, request.getRequestURI(), params);
//        //String paging = pagingUtil.getPagingLink((count / pagingUtil.getPageSize())+1, count, pageable.getPageNumber() + 1, request.getRequestURI(), params);
//
        mav.addObject("paging", paging);


        mav.setViewName("record/record_form_list_div");

        return mav;
    }
    /**
     * 실적 저장
     * @return
     */
    @RequestMapping(value = "/record/form", method = RequestMethod.POST)
    public Map<String, Object> save(
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam(value = "dt", required = false) String dt,
            @RequestParam(value = "deptCd", required = false) String deptCd,
            @RequestParam(value = "prod", required = false) String prod,
            @RequestParam(value = "acc", required = false) String acc,
            @RequestParam(value = "contents", required = false) String contents,
            @RequestParam(value = "amtString", required = false) Integer amt,
            @RequestParam(value = "fixid", required = false) Integer fixid,
            @RequestParam(value = "fixDeptCd", required = false) String fixDeptCd,
            @RequestParam(value = "fixAmtString", required = false) String fixAmt,
            Pageable pageable,
            ModelAndView mav, HttpServletRequest request
    ) {
        Map<String, Object> result = new HashMap<String, Object>();

        KPlList kPlList = new KPlList();
        KPreplList kPreplList = new KPreplList();
        Map<String, Object> comboParams = new HashMap<String, Object>();
        Map<String, Object> params = new HashMap<String, Object>();

        XUser user = (XUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        dt = (dt != null) ? dt.replaceAll("-", "") : null;
        //실적내역
        kPlList.setDt(dt);
        kPlList.setDeptCd(deptCd);
        kPlList.setProd(prod);
        kPlList.setAcc(acc);
        kPlList.setContents(contents);
        kPlList.setAmt(amt);

        //타사보전내역
        kPreplList.setDt(dt);
        kPreplList.setDeptCd(deptCd);
        kPreplList.setProd(prod);
        kPreplList.setAcc(acc);
        kPreplList.setFixDeptCd(fixDeptCd);
        kPreplList.setAmt(fixAmt);

        if(id == null) {
            kPlList.setRegEmp(user.getUserId());
            kPreplList.setRegEmp(user.getUserId());
        }else{
            kPlList.setId(id);
            kPlList.setUpdateEmp(user.getUserId());
            kPlList.setUpdateDate(new Date());
            kPreplList.setId(kPlList.getPreId());
            kPreplList.setUpdateEmp(user.getUserId());
            kPreplList.setUpdateDate(new Date());
        }
        if(!fixAmt.isEmpty() || fixid != null){
            kPreplListRepository.save(kPreplList);
        }

        kPlList.setPreId(kPreplList.getId());
        kPlListRepository.save(kPlList);

        result.put("record", kPlList);
        result.put("record2", kPreplList);



//        List<KPlList> kPlLists = kamsRecordMapper.selectPlList(params);
//        mav.addObject("kPlLists", kPlLists);
//
//
//
//        System.out.println("kPlLists : "+ kPlLists.size());
//
//        for(KPlList a: kPlLists){
//            System.out.println("kPlList id : "+ a.getId());
//        }

//        comboParams.put("deptCd",deptCd);
//        List<DzDept> dzDepts            = kamsRecordMapper.selectTbDeptsGrpByDeptCd(comboParams);
//        List<DzDept> dzDepts1            = kamsRecordMapper.selectTbDeptsGrpByDeptCd(null);
//        List<KAccCode> kAccCodes        = kamsRecordMapper.selectAccCdList(comboParams);
//        List<KProdCode> kProdCodes        = kamsRecordMapper.selectProdCdList(comboParams);
//
//        mav.addObject("dzDepts", dzDepts);
//        mav.addObject("dzDepts1", dzDepts1);
//        mav.addObject("kAccCodes", kAccCodes);
//        mav.addObject("kProdCodes", kProdCodes);

//        mav.setViewName("record/record_form");

        return result;
    }


    /**
     * 실적 삭제
     * @param request
     * @return
     */
    @RequestMapping(value = "/record/form", method = RequestMethod.DELETE)
    public Map<String, Object> delete(
            @RequestParam(value = "id", required = true) String id,

            WebRequest request
    ) {
        Map<String, Object> result = new HashMap<String, Object>();
        Map<String, Object> params = new HashMap<String, Object>();

        String[] ids = id.split(",");

        for(String i : ids){
            System.out.println("i : "+ i);
            KPreplList kPreplList = new KPreplList();

            KPlList kPlList = kPlListRepository.findOne(Integer.parseInt(i));
            kPreplList.setId(kPlList.getPreId());
            kPlList.setDeleteDate(new Date());
            kPlListRepository.delete(kPlList);
            kPreplListRepository.delete(kPreplList);
        }

        return result;
    }

    /**
     * 실적내역 리스트 조회
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/record/list", method = RequestMethod.GET)
    public ModelAndView list(

            Pageable pageable,
            ModelAndView mav, WebRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        Map<String, Object> comboParams = new HashMap<String, Object>();
        String deptCd = null;
        XUser user = (XUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if(user.getAdminType().equals("ADMIN") || user.getAdminType().equals("SYSAD")){
            deptCd = null;
            comboParams.put("adminType",user.getAdminType());
        }else{
            deptCd = user.getDeptCd();
            comboParams.put("deptCd",deptCd);
        }

        List<DzDept> dzDepts            = kamsRecordMapper.selectTbDeptsGrpByDeptCd(comboParams);
        List<KAccCode> kAccCodes        = kamsRecordMapper.selectAccCdList(comboParams);
        List<KProdCode> kProdCodes        = kamsRecordMapper.selectProdCdList(comboParams);
        mav.addObject("dzDepts", dzDepts);

        mav.addObject("kAccCodes", kAccCodes);
        mav.addObject("kProdCodes", kProdCodes);

//        for( DzDept dzDept :dzDepts ){
//            System.out.println("dzDept:" + dzDept);
//        }


        mav.setViewName("record/record_list");
        Sort sortObj = new Sort(Sort.Direction.ASC, "dt");
        mav.addObject("order", sortObj.iterator().next());

        return mav;
    }


    /**
     * 실적내역 리스트 div 조회
     * @param deptCd
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/record/list_div", method = RequestMethod.GET)
    public ModelAndView listDiv(
            @RequestParam(value = "stDt", required = false) String stDt,
            @RequestParam(value = "ndDt", required = false) String ndDt,
            @RequestParam(value = "deptCd", required = false) String deptCd,
            @RequestParam(value = "prod", required = false) String prod,
            @RequestParam(value = "acc", required = false) String acc,
            @RequestParam(value = "level", required = false) String level,
            Pageable pageable,
            ModelAndView mav, HttpServletRequest request
    ) {

        XUser user = (XUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Map<String, Object> params = new HashMap<String, Object>();
        Date now        = new Date();
        String today    = DateFormatUtils.format(now, "yyyyMMdd");

        params.put("stDt"   , (stDt != null) ? stDt.replaceAll("-", "") : today);
        params.put("ndDt"   , (ndDt != null) ? ndDt.replaceAll("-", "") : today);

        if(!(user.getAdminType().equals("ADMIN") || user.getAdminType().equals("SYSAD"))){
            deptCd = user.getDeptCd();
        }
        level = (level != null)? level : "3" ;

        params.put("deptCd"    , deptCd);
        params.put("prod"    , prod);
        params.put("acc"    , acc);
        params.put("level"    , level);
        params.put("pageable"   , pageable);

        int count = kamsRecordMapper.selectPlListCountAll(params);
        List<KPlList> kPlLists = kamsRecordMapper.selectPlListAll(params);

        String paging = pagingUtil.getPagingLink((int)Math.ceil((double)count / pageable.getPageSize()), count, pageable.getPageNumber() + 1, request.getRequestURI(), params);
        //String paging = pagingUtil.getPagingLink((count / pagingUtil.getPageSize())+1, count, pageable.getPageNumber() + 1, request.getRequestURI(), params);
        mav.addObject("kPlLists", kPlLists);
        mav.addObject("paging", paging);

        mav.setViewName("record/record_list_div");

        return mav;
    }

    /**
     * 실적보고 리스트 조회
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/record/reportList", method = RequestMethod.GET)
    public ModelAndView reportList(
            Pageable pageable,
            ModelAndView mav, WebRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        Map<String, Object> comboParams = new HashMap<String, Object>();
        String deptCd = null;
        XUser user = (XUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if(user.getAdminType().equals("ADMIN") || user.getAdminType().equals("SYSAD")){
            deptCd = null;
            comboParams.put("adminType",user.getAdminType());
        }else{
            deptCd = user.getDeptCd();
            comboParams.put("deptCd",deptCd);
        }

        List<DzDept> dzDepts            = kamsRecordMapper.selectTbDeptsGrpByDeptCd(comboParams);

        mav.addObject("dzDepts", dzDepts);

//        for( DzDept dzDept :dzDepts ){
//            System.out.println("dzDept:" + dzDept);
//        }


        mav.setViewName("record/record_report_list");
        Sort sortObj = new Sort(Sort.Direction.ASC, "dt");
        mav.addObject("order", sortObj.iterator().next());

        return mav;
    }


    /**
     * 실적보고 리스트 div 조회
     * @param deptCd
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/record/reportList_div", method = RequestMethod.GET)
    public ModelAndView reportListDiv(
            @RequestParam(value = "dt", required = false) String dt,
            @RequestParam(value = "deptCd", required = false) String deptCd,
            @RequestParam(value = "prod", required = false) String prod,
            @RequestParam(value = "acc", required = false) String acc,
            @RequestParam(value = "level", required = false) String level,
            Pageable pageable,
            ModelAndView mav, HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();

        Date now        = new Date();
        String today    = DateFormatUtils.format(now, "yyyyMMdd");
        String year    = DateFormatUtils.format(now, "yyyy");
        XUser user = (XUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if(!(user.getAdminType().equals("ADMIN") || user.getAdminType().equals("SYSAD"))){
            deptCd = user.getDeptCd();
        }

        if(dt == null) dt = today;
        params.put("dt"   , (dt != null) ? dt.replaceAll("-", "") : null);
        params.put("deptCd"    , deptCd);
        params.put("prod"    , prod);
        params.put("acc"    , acc);
        params.put("level"    , level);
        params.put("year"    , year);


        List<KPlList> kPlLists = kamsRecordMapper.selectPlLisReport(params);

          mav.addObject("kPlLists", kPlLists);
        mav.setViewName("record/record_report_list_div");

        return mav;
    }
}
