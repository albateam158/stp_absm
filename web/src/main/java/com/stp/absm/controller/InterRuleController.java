package com.stp.absm.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.stp.absm.model.KInRule;
import com.stp.absm.model.KInRuleFile;
import com.stp.absm.model.XCode;
import com.stp.absm.model.XUser;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;

import com.stp.absm.model.dz.DzDept;

@RestController
public class InterRuleController extends RootController {

    private final Logger log = LoggerFactory.getLogger(InterRuleController.class);

    /**
     * 사규 등록 form
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/inter_rule/form", method = RequestMethod.GET)
    public ModelAndView form(
            @RequestParam(value = "ruleId", required = false) Integer ruleId,
            @RequestParam(value = "groupId", required = false) Integer groupId,
            @RequestParam(value = "docGroup", required = false) String docGroup,
            @RequestParam(value = "ruleCd", required = false) String ruleCd,
            @RequestParam(value = "ruleNm", required = false) String ruleNm,
            @RequestParam(value = "estDt", required = false) String estDt,
            @RequestParam(value = "reformDt", required = false) String reformDt,
            Pageable pageable,
            ModelAndView mav, HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        Map<String, Object> comboParams = new HashMap<String, Object>();
        KInRule kInRule = null;
//        XUser user = (XUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Date now        = new Date();
        String today    = DateFormatUtils.format(now, "yyyyMMdd");

        List<XCode> IRGs = xCodeRepository.findAllByCodeGroupAndDeleteDateIsNullOrderByOrderNoAsc("IRG");
        List<XCode> RDGs = xCodeRepository.findAllByCodeGroupAndDeleteDateIsNullOrderByOrderNoAsc("RDG");
        List<DzDept> dzDepts = kamsRecordMapper.selectTbDeptsGrpByDeptCd(comboParams);

        if(ruleId != null){
            params.put("ruleId",ruleId);
            kInRule = kamsInterRuleMapper.selectKinRule(params);
        }
        mav.addObject("inRule", kInRule);
        mav.addObject("IRGs", IRGs);
        mav.addObject("RDGs", RDGs);
        mav.addObject("dzDepts", dzDepts);

        mav.setViewName("inter_rule/inter_rule_form");

        return mav;
    }
    /**
     * 사규 등록 form
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/inter_rule/form_list_div", method = RequestMethod.GET)
    public ModelAndView form_list_div(
            @RequestParam(value = "ruleId", required = false) Integer ruleId,
            @RequestParam(value = "groupId", required = false) Integer groupId,
            @RequestParam(value = "docGroup", required = false) String docGroup,
            @RequestParam(value = "ruleCd", required = false) String ruleCd,
            @RequestParam(value = "ruleNm", required = false) String ruleNm,
            @RequestParam(value = "estDt", required = false) String estDt,
            @RequestParam(value = "reformDt", required = false) String reformDt,
            @RequestParam(value = "chargeDept", required = false) String chargeDept,
            @RequestParam(value = "stDt", required = false) String stDt,
            @RequestParam(value = "ndDt", required = false) String ndDt,
            Pageable pageable,
            ModelAndView mav, HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        Map<String, Object> comboParams = new HashMap<String, Object>();
//        XUser user = (XUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Date now        = new Date();
        String today    = DateFormatUtils.format(now, "yyyyMMdd");

        stDt = (stDt != null) ? stDt.replaceAll("-", "") : null;
        ndDt = (ndDt != null) ? ndDt.replaceAll("-", "") : null;

        params.put("groupId",groupId);
        params.put("docGroup",docGroup);
        params.put("chargeDept",chargeDept);
        params.put("stDt",stDt);
        params.put("ndDt",ndDt);

        int count = kamsInterRuleMapper.selectKinRuleCount(params);
        List<KInRule> kIRLists = kamsInterRuleMapper.selectKinRules(params);

        mav.addObject("kIRLists", kIRLists);
        params.put("pageable"   , pageable);
        System.out.println("kInRules : "+ kIRLists.size());

//        for(KPlList a: kPlLists){
//            System.out.println("kPlLists : "+ a.getId());
//        }

        String paging = pagingUtil.getPagingLink((int)Math.ceil((double)count / pageable.getPageSize()), count, pageable.getPageNumber() + 1, request.getRequestURI(), params);
//        //String paging = pagingUtil.getPagingLink((count / pagingUtil.getPageSize())+1, count, pageable.getPageNumber() + 1, request.getRequestURI(), params);
//        mav.addObject("paging", paging);

        mav.setViewName("inter_rule/inter_rule_form_list_div");

        return mav;
    }

    @RequestMapping(value = "/inter_rule/upload", method = RequestMethod.POST)
    public Map<String, Object> projectUpload (
            @RequestParam(value = "uploadedFile", required = true) String uploadedFile,
            @RequestParam(value = "dropzoneId", required = true) String dropzoneId,
            HttpServletRequest request
    ) {
        Map<String, Object> map = new HashMap<String, Object>();

        if(dropzoneId.equals("dropzone-attached")) {
            KInRuleFile kInRuleFile = gson.fromJson(uploadedFile, KInRuleFile.class);

            kInRuleFile.setRegDate(new Date());

            kInRuleFileRepository.save(kInRuleFile);

            map.put("file", kInRuleFile);
        }

        return map;
    }

    @RequestMapping(value = "/inter_rule/file", method = RequestMethod.DELETE)
    public Map<String, Object> fileDelete(
            @RequestParam(value = "fileId", required = true) Integer fileId,
            @RequestParam(value = "dropzoneId", required = true) String dropzoneId,
            WebRequest request
    ) {
        Map<String, Object> result = new HashMap<String, Object>();

        if(dropzoneId.equals("dropzone-attached")) {
            kInRuleFileRepository.delete(fileId);
        }
        else {
            kInRuleFileRepository.delete(fileId);
        }

        return result;
    }

    /**
     * 사규 저장
     * @return
     */
    @RequestMapping(value = "/inter_rule/form", method = RequestMethod.POST)
    public Map<String, Object> save(
            @RequestParam(value = "ruleId", required = false) Integer ruleId,
            @RequestParam(value = "groupId", required = false) String groupId,
            @RequestParam(value = "docGroup", required = false) String docGroup,
            @RequestParam(value = "docSeq", required = false) String docSeq,
            @RequestParam(value = "docId", required = false) String docId,
            @RequestParam(value = "ruleNm", required = false) String ruleNm,
            @RequestParam(value = "estDt", required = false) String estDt,
            @RequestParam(value = "reformDt", required = false) String reformDt,
            @RequestParam(value = "chargeDept", required = false) String chargeDept,
            @RequestParam(value = "chargeDeptDetail", required = false) String chargeDeptDetail,
            @RequestParam(value = "beforeFile", required = false) Integer beforeFile,
            @RequestParam(value = "recentFile", required = false) Integer recentFile,
            Pageable pageable,
            ModelAndView mav, HttpServletRequest request
    ) {
        Map<String, Object> result = new HashMap<String, Object>();
        Map<String, Object> comboParams = new HashMap<String, Object>();
        Map<String, Object> params = new HashMap<String, Object>();

        System.out.println("ruleId : "+ruleId);
        System.out.println("groupId : "+groupId);
        System.out.println("docGroup : "+docGroup);
        System.out.println("docSeq : "+docSeq);

        System.out.println("docId : "+docId);
        System.out.println("ruleNm : "+ruleNm);
        System.out.println("estDt : "+estDt);
        System.out.println("reformDt : "+reformDt);
        System.out.println("chargeDept : "+chargeDept);
        System.out.println("chargeDeptDetail : "+chargeDeptDetail);
        System.out.println("beforeFile : "+beforeFile);
        System.out.println("recentFile : "+recentFile);

        XUser user = (XUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();


        KInRule kInRule = new KInRule();

        kInRule.setGroupId(groupId);
        kInRule.setDocGroup(docGroup);


        kInRule.setRuleNm(ruleNm);
        kInRule.setEstablishDt(estDt.replaceAll("-", ""));
        kInRule.setReformDt(reformDt.replaceAll("-", ""));
        kInRule.setChargeDept(chargeDept);
        kInRule.setChargeDeptDetail(chargeDeptDetail);
        kInRule.setBeforeFile(beforeFile);
        kInRule.setRecentFile(recentFile);

        if(ruleId == null) {
            params.put("groupId",groupId);
            params.put("docGroup",docGroup);
            KInRule kInRuleSeq = kamsInterRuleMapper.selectKinRuleDocSeq(params);

            System.out.println("kInRuleSeq : " + kInRuleSeq.toString());

            //docId = groupId + docGroup + kInRuleSeq.getDocSeq();

            kInRule.setDocSeq(kInRuleSeq.getDocSeq());
            kInRule.setDocId(docId);

            kInRule.setRegEmp(user.getUserId());

        }else{
            kInRule.setRuleId(ruleId);
            kInRule.setDocSeq(docSeq);
            kInRule.setDocId(docId);
            kInRule.setUpdateEmp(user.getUserId());
            kInRule.setUpdateDate(new Date());
        }
        System.out.println("kInRule : " + kInRule.toString());
        kInRuleRepository.save(kInRule);

        result.put("ruleId", kInRule.getRuleId());

        return result;
    }


    /**
     * 사규 삭제
     * @param request
     * @return
     */
    @RequestMapping(value = "/inter_rule/form", method = RequestMethod.DELETE)
    public Map<String, Object> delete(
            @RequestParam(value = "id", required = true) String id,
            WebRequest request
    ) {
        Map<String, Object> result = new HashMap<String, Object>();
        Map<String, Object> params = new HashMap<String, Object>();

        String[] ids = id.split(",");

        for(String i : ids){
            System.out.println("i : "+ i);
            KInRule kInRule = new KInRule();
            kInRule.setDeleteDate(new Date());
            kInRule.setRuleId(Integer.parseInt(i));
            kInRuleRepository.delete(kInRule);
        }

        return result;
    }




    /**
     * 사규내역 리스트 조회
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/inter_rule/list", method = RequestMethod.GET)
    public ModelAndView list(
            Pageable pageable,
            ModelAndView mav, WebRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        Map<String, Object> comboParams = new HashMap<String, Object>();
        String deptCd = null;
//        XUser user = (XUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        List<XCode> IRGs = xCodeRepository.findAllByCodeGroupAndDeleteDateIsNullOrderByOrderNoAsc("IRG");
        List<XCode> RDGs = xCodeRepository.findAllByCodeGroupAndDeleteDateIsNullOrderByOrderNoAsc("RDG");
        List<DzDept> dzDepts = kamsRecordMapper.selectTbDeptsGrpByDeptCd(comboParams);

        mav.addObject("IRGs", IRGs);
        mav.addObject("RDGs", RDGs);
        mav.addObject("dzDepts", dzDepts);

        mav.setViewName("inter_rule/inter_rule_list");
        Sort sortObj = new Sort(Sort.Direction.ASC, "rule_id");
        mav.addObject("order", sortObj.iterator().next());

        return mav;
    }
    /**
     * 사규내역 리스트 조회
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/inter_rule/listV", method = RequestMethod.GET)
    public ModelAndView listV(
            Pageable pageable,
            ModelAndView mav, WebRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        Map<String, Object> comboParams = new HashMap<String, Object>();
        String deptCd = null;
//        XUser user = (XUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        List<XCode> IRGs = xCodeRepository.findAllByCodeGroupAndDeleteDateIsNullOrderByOrderNoAsc("IRG");
        List<XCode> RDGs = xCodeRepository.findAllByCodeGroupAndDeleteDateIsNullOrderByOrderNoAsc("RDG");
        List<DzDept> dzDepts = kamsRecordMapper.selectTbDeptsGrpByDeptCd(comboParams);

        mav.addObject("IRGs", IRGs);
        mav.addObject("RDGs", RDGs);
        mav.addObject("dzDepts", dzDepts);

        mav.setViewName("inter_rule/inter_rule_list_v");
        Sort sortObj = new Sort(Sort.Direction.ASC, "rule_id");
        mav.addObject("order", sortObj.iterator().next());

        return mav;
    }
    /**
     * 사규 등록 form
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/inter_rule/list_div", method = RequestMethod.GET)
    public ModelAndView list_div(
            @RequestParam(value = "ruleId", required = false) Integer ruleId,
            @RequestParam(value = "groupId", required = false) Integer groupId,
            @RequestParam(value = "docGroup", required = false) String docGroup,
            @RequestParam(value = "ruleCd", required = false) String ruleCd,
            @RequestParam(value = "ruleNm", required = false) String ruleNm,
            @RequestParam(value = "estDt", required = false) String estDt,
            @RequestParam(value = "reformDt", required = false) String reformDt,
            @RequestParam(value = "chargeDept", required = false) String chargeDept,
            @RequestParam(value = "stDt", required = false) String stDt,
            @RequestParam(value = "ndDt", required = false) String ndDt,
            Pageable pageable,
            ModelAndView mav, HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        Map<String, Object> comboParams = new HashMap<String, Object>();
//        XUser user = (XUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Date now        = new Date();
        String today    = DateFormatUtils.format(now, "yyyyMMdd");

        stDt = (stDt != null) ? stDt.replaceAll("-", "") : null;
        ndDt = (ndDt != null) ? ndDt.replaceAll("-", "") : null;

        params.put("groupId",groupId);
        params.put("docGroup",docGroup);
        params.put("chargeDept",chargeDept);
        params.put("stDt",stDt);
        params.put("ndDt",ndDt);

        int count = kamsInterRuleMapper.selectKinRuleCount(params);
        List<KInRule> kIRLists = kamsInterRuleMapper.selectKinRules(params);

        mav.addObject("kIRLists", kIRLists);
        params.put("pageable"   , pageable);
        System.out.println("kInRules : "+ kIRLists.size());

//        for(KPlList a: kPlLists){
//            System.out.println("kPlLists : "+ a.getId());
//        }

        String paging = pagingUtil.getPagingLink((int)Math.ceil((double)count / pageable.getPageSize()), count, pageable.getPageNumber() + 1, request.getRequestURI(), params);
//        //String paging = pagingUtil.getPagingLink((count / pagingUtil.getPageSize())+1, count, pageable.getPageNumber() + 1, request.getRequestURI(), params);
//        mav.addObject("paging", paging);

        mav.setViewName("inter_rule/inter_rule_list_div");

        return mav;
    }
     
}
