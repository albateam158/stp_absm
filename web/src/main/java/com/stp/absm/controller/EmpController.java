package com.stp.absm.controller;

import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.stp.absm.model.dz.*;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class EmpController extends RootController {

    @Autowired
    protected PasswordEncoder passwordEncoder;
    private final Logger log = LoggerFactory.getLogger(EmpController.class);


    /**
     * 사용자 등록 form
     * @param empCd
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/emp/form", method = RequestMethod.GET)
    public ModelAndView form(
            @RequestParam(value = "empCd", required = false) String empCd,
            ModelAndView mav, WebRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("empCd",empCd);
        if( empCd != null ){

            DzEmp dzEmp = dzEmpMapper.selectEmp(params);
            mav.addObject("member", dzEmp);

            System.out.println("empCd : "+ params.get("empCd"));

            List<DzHhmcrer> dzCrers            = dzEmpMapper.selectEmpCrer(params);
            mav.addObject("dzCrers", dzCrers);

            System.out.println("dzCrers : "+ dzCrers.size());

        }

        List<DzDept> dzDepts            = dzEmpMapper.selectDeptsGrpByDeptCd();
        mav.addObject("dzDepts", dzDepts);

        mav.setViewName("emp/emp_form");

        return mav;
    }

    /**
     * 사용자 리스트 조회
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/emp/list", method = RequestMethod.GET)
    public ModelAndView list(
            Pageable pageable,
            ModelAndView mav, WebRequest request
    ) {
        List<DzDept> dzDepts            = dzEmpMapper.selectDeptsGrpByDeptCd();
        mav.addObject("dzDepts", dzDepts);

//        for( DzDept dzDept :dzDepts ){
//            System.out.println("dzDept:" + dzDept);
//        }


        mav.setViewName("emp/emp_list");
        Sort sortObj = new Sort(Sort.Direction.DESC, "joinDt");
        mav.addObject("order", sortObj.iterator().next());

        return mav;
    }
    /**
     * 사용자 리스트 조회
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/emp/listV", method = RequestMethod.GET)
    public ModelAndView listV(
            Pageable pageable,
            ModelAndView mav, WebRequest request
    ) {
        List<DzDept> dzDepts            = dzEmpMapper.selectDeptsGrpByDeptCd();
        mav.addObject("dzDepts", dzDepts);

//        for( DzDept dzDept :dzDepts ){
//            System.out.println("dzDept:" + dzDept);
//        }


        mav.setViewName("emp/emp_list_v");
        Sort sortObj = new Sort(Sort.Direction.DESC, "joinDt");
        mav.addObject("order", sortObj.iterator().next());

        return mav;
    }

    /**
     * 사용자 리스트 div 조회
     * @param deptCd
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/emp/list_div", method = RequestMethod.GET)
    public ModelAndView listDiv(
            @RequestParam(value = "deptCd", required = false) String deptCd,
            @RequestParam(value = "joinStDt", required = false) String joinStDt,
            @RequestParam(value = "joinNdDt", required = false) String joinNdDt,
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "keyword1", required = false) String keyword1,
            Pageable pageable,
            ModelAndView mav, HttpServletRequest request
    ) {
        System.out.println("deptCd : "+ deptCd);
        System.out.println("joinStDt : "+ joinStDt);
        System.out.println("joinNdDt : "+ joinNdDt);
        System.out.println("keyword : "+ keyword);
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("joinStDt"   , (joinStDt != null) ? joinStDt.replaceAll("-", "") : null);
        params.put("joinNdDt"   , (joinNdDt != null) ? joinNdDt.replaceAll("-", "") : null);

        if(org.springframework.util.StringUtils.isEmpty(keyword) == false ){

            params.put("keyword"        , keyword);
        }

        if(org.springframework.util.StringUtils.isEmpty(keyword1) == false ){

            params.put("keyword1"        , keyword1);
        }

        params.put("deptCd"    , deptCd);
        params.put("pageable"   , pageable);

        int count = dzEmpMapper.selectEmpsCount(params);

        List<DzEmp> emps = dzEmpMapper.selectEmps(params);

        String paging = pagingUtil.getPagingLink((int)Math.ceil((double)count / pageable.getPageSize()), count, pageable.getPageNumber() + 1, request.getRequestURI(), params);
        //String paging = pagingUtil.getPagingLink((count / pagingUtil.getPageSize())+1, count, pageable.getPageNumber() + 1, request.getRequestURI(), params);

        mav.addObject("emps"   , emps);
        mav.addObject("paging", paging);

        mav.setViewName("emp/emp_list_div");

        return mav;
    }

    @RequestMapping(value="/getByteImage1/{empCd}", method = RequestMethod.GET)
    public void pictureView(HttpServletRequest req, HttpServletResponse res
            , @PathVariable(value = "empCd") String empCd) throws IOException {
        res.setContentType("image/jpeg");
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("empCd",empCd);
        Map<String, Object> map  = dzEmpMapper.selectPicture(params);
        byte[] imageContent = (byte[]) map.get("image");
        InputStream in1 = new ByteArrayInputStream(imageContent);
        IOUtils.copy(in1, res.getOutputStream());
    }

    @RequestMapping(value="/getByteImage2/{empCd}", method = RequestMethod.GET)
    public ResponseEntity<byte[]> getByteImage(HttpServletRequest req, HttpServletResponse res
            , @PathVariable(value = "empCd") String empCd) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("empCd",empCd);
        Map<String, Object> map  = dzEmpMapper.selectPicture(params);
        byte[] imageContent = (byte[]) map.get("image");
        final HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_PNG);
        return new ResponseEntity<byte[]>(imageContent, headers, HttpStatus.OK);
    }


    /**
     * 전화번호부 리스트 조회
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/emp/phone", method = RequestMethod.GET)
    public ModelAndView phoneList(
            Pageable pageable,
            ModelAndView mav, WebRequest request
    ) {
        List<DzDept> dzDepts            = dzEmpMapper.selectDeptsGrpByDeptCd();
        mav.addObject("dzDepts", dzDepts);

//        for( DzDept dzDept :dzDepts ){
//            System.out.println("dzDept:" + dzDept);
//        }


        mav.setViewName("emp/phone_list");

        return mav;
    }
    /**
     * 전화번호부 리스트 조회
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/emp/phoneV", method = RequestMethod.GET)
    public ModelAndView phoneListV(
            Pageable pageable,
            ModelAndView mav, WebRequest request
    ) {
        List<DzDept> dzDepts            = dzEmpMapper.selectDeptsGrpByDeptCd();
        mav.addObject("dzDepts", dzDepts);

//        for( DzDept dzDept :dzDepts ){
//            System.out.println("dzDept:" + dzDept);
//        }


        mav.setViewName("emp/phone_list_v");

        return mav;
    }

    /**
     * 사용자 리스트 div 조회
     * @param deptCd
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/emp/phone_div", method = RequestMethod.GET)
    public ModelAndView phoneListDiv(
            @RequestParam(value = "deptCd", required = false) String deptCd ,
            Pageable pageable,
            ModelAndView mav, HttpServletRequest request
    ) {
        System.out.println("deptCd : "+ deptCd);
        Map<String, Object> params = new HashMap<String, Object>();

        params.put("deptCd"    , deptCd);
        params.put("pageable"   , pageable);

        int count = dzEmpMapper.selectPhoneCount(params);

        List<DzEmp> emps = dzEmpMapper.selectPhone(params);

        String paging = pagingUtil.getPagingLink((int)Math.ceil((double)count / pageable.getPageSize()), count, pageable.getPageNumber() + 1, request.getRequestURI(), params);
        //String paging = pagingUtil.getPagingLink((count / pagingUtil.getPageSize())+1, count, pageable.getPageNumber() + 1, request.getRequestURI(), params);

        mav.addObject("emps"   , emps);
        mav.addObject("paging", paging);

        mav.setViewName("emp/phone_list_div");

        return mav;
    }

    /**
     * 사용자 등록 form
     * @param empCd
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/emp/phone_form", method = RequestMethod.GET)
    public ModelAndView phoneForm(
            @RequestParam(value = "empCd", required = false) String empCd,
            ModelAndView mav, WebRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("empCd",empCd);
        if( empCd != null ){

            DzEmp dzEmp = dzEmpMapper.selectEmp(params);
            mav.addObject("member", dzEmp);

            System.out.println("empCd : "+ params.get("empCd"));

//            List<DzHhmcrer> dzCrers            = dzEmpMapper.selectEmpCrer(params);
//            mav.addObject("dzCrers", dzCrers);
//
//            System.out.println("dzCrers : "+ dzCrers.size());

        }

        List<DzDept> dzDepts            = dzEmpMapper.selectDeptsGrpByDeptCd();
        mav.addObject("dzDepts", dzDepts);

        mav.setViewName("emp/phone_form");

        return mav;
    }

    /**
     * 조직도 조회
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/emp/treeList", method = RequestMethod.GET)
    public ModelAndView  treeList(
            Pageable pageable,
            ModelAndView mav, WebRequest request
    ) {
        String data = kamsRecordMapper.selectJsonTreeData();

        mav.setViewName("emp/emp_tree_list");
        mav.addObject("data"   , data);

        return mav;
    }



    /**
     *
     */
    @RequestMapping(value = "/empSync", method = RequestMethod.GET)
    public ModelAndView empSync(
            ModelAndView mav, WebRequest request
    ) {

        List<DzEmp> dzEmps = dzEmpMapper.selectSyncEmp();

        for(DzEmp dzEmp: dzEmps){
            ZaEmpDaikin zaEmpDaikin = new ZaEmpDaikin();

            zaEmpDaikin.setCoCd(dzEmp.getCoCd());
            zaEmpDaikin.setEmpCd(dzEmp.getEmpCd());
            zaEmpDaikin.setKorNm(dzEmp.getKorNm());
            zaEmpDaikin.setKorNmk(dzEmp.getKorNmk());
            zaEmpDaikin.setEnlsNm(dzEmp.getEnlsNm());
            zaEmpDaikin.setBrthDt(dzEmp.getBrthDt());
            zaEmpDaikin.setLsclFg(dzEmp.getLsclFg());
            zaEmpDaikin.setJoinDt(dzEmp.getJoinDt());
            zaEmpDaikin.setRtrDt(dzEmp.getRtrDt());
            zaEmpDaikin.setDeptCd(dzEmp.getDeptCd());
            zaEmpDaikin.setTel(dzEmp.getTel());
            zaEmpDaikin.setGenderFg(dzEmp.getGenderFg());
            zaEmpDaikin.setHclsCd(dzEmp.getHclsCd());
            zaEmpDaikin.setHclsNm(dzEmp.getHclsNm());
            zaEmpDaikin.setHrspCd(dzEmp.getHrspCd());
            zaEmpDaikin.setHclsNm(dzEmp.getHclsNm());
            zaEmpDaikin.setEnrlFg(dzEmp.getEnrlFg());
            zaEmpDaikin.setEnrlNm(dzEmp.getEnrlNm());
            zaEmpDaikin.setEmalAdd(dzEmp.getEmalAdd());
            zaEmpDaikin.setHp(dzEmp.getHp());

            zaEmpDaikinRepository.save(zaEmpDaikin);
        }

        mav.setViewName("main/main_form");


        return mav;
    }


    /**
     *
     */
    @RequestMapping(value = "/deptSync", method = RequestMethod.GET)
    public ModelAndView deptSync(
            ModelAndView mav, WebRequest request
    ) {
        //더존부서
        List<DzDept> dzDepts            = dzEmpMapper.selectDeptsGrpByDeptCd();
        for(DzDept dzDept : dzDepts){
            ZaDeptDaikin zaDeptDaikin = new ZaDeptDaikin();

            zaDeptDaikin.setDeptCd(dzDept.getDeptCd());
            zaDeptDaikin.setCoCd(dzDept.getCoCd());
            zaDeptDaikin.setSectCd(dzDept.getSectCd());
            zaDeptDaikin.setSectNm(dzDept.getSectNm());
            zaDeptDaikin.setDeptNm(dzDept.getDeptNm());
            zaDeptDaikin.setDeptNmk(dzDept.getDeptNmk());
            zaDeptDaikin.setDivCd(dzDept.getDivCd());
            zaDeptDaikin.setRegDt(dzDept.getRegDt());
            zaDeptDaikin.setToDt(dzDept.getToDt());
            zaDeptDaikinRepository.save(zaDeptDaikin);
        }

        //실적용부서
        List<TbDzDept> dzDepts1            = kamsRecordMapper.selectTbDeptsRecord();
        for(TbDzDept dzDept : dzDepts1){
            ZaDeptDaikin zaDeptDaikin = new ZaDeptDaikin();

            zaDeptDaikin.setDeptCd(dzDept.getDeptCd());
            zaDeptDaikin.setCoCd(dzDept.getCoCd());
            zaDeptDaikin.setSectCd(dzDept.getSectCd());
            zaDeptDaikin.setSectNm(dzDept.getSectNm());
            zaDeptDaikin.setDeptNm(dzDept.getDeptNm());
            zaDeptDaikin.setDeptNmk(dzDept.getDeptNmk());
            zaDeptDaikin.setDivCd(dzDept.getDivCd());
            zaDeptDaikin.setRegDt(dzDept.getRegDt());
            zaDeptDaikin.setToDt(dzDept.getToDt());
            zaDeptDaikinRepository.save(zaDeptDaikin);
        }



        mav.setViewName("main/main_form");

        return mav;
    }
}
