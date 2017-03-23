package com.stp.absm.controller;

import com.stp.absm.common.*;
import com.stp.absm.model.AbsmCase;
import com.stp.absm.model.AbsmPrivate;
import com.stp.absm.mybatis.mapper.Page001Mapper;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 개인특성자료입력 화면
 */

@RestController
public class Page001Controller extends RootController {

    private final Logger logger = LoggerFactory.getLogger(Page001Controller.class);

    @Value(value = "${upload.fileLocation}")
    private String fileLocation;

    @Autowired
    protected PrivateFileService privateFileService;

    @Autowired
    protected SurveyFileService surveyFileService;

    @Autowired
    protected Page001Mapper page001Mapper;

    /**
     * 조회화면
     * @param request
     * @param mav
     * @return
     */
    @RequestMapping(value = "/input/baseline", method = RequestMethod.GET)
    public ModelAndView pageFormList(
            HttpServletRequest request,
            ModelAndView mav
    ) {

        mav.setViewName("input/baseline");
        return mav;
    }

    /**
     * 조회화면 목록 DIV
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/input/baseline_div", method = RequestMethod.GET)
    public Map<String, Object> pageFormListDiv(
            @RequestParam(value = "dt", required = false) String dt,
            @RequestParam(value = "caId", required = false) String caId,
            @RequestParam(value = "note", required = false) String note,
            Pageable pageable,
            ModelAndView mav,
            HttpServletRequest request
    ) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> params = new HashMap<String, Object>();
        params.put("dt", dt);
        params.put("caId", caId);
        params.put("note", note);
        params.put("pageable", pageable);

        int count = page001Mapper.selectBoardsCount(params);
        List<AbsmPrivate> boards = page001Mapper.selectBoards(params);
        String paging = pagingUtil.getPagingLink((int) Math.ceil((double) count / pageable.getPageSize()), count, pageable.getPageNumber() + 1, request.getRequestURI(), params);

        JSONObject jsonObject = new JSONObject();
        JSONArray cell = new JSONArray();

        for(int i=0; i < boards.size(); i++) {

            AbsmPrivate absmPrivate = (AbsmPrivate)boards.get(i);
            JSONObject obj = new JSONObject();

            obj.put( "케이스명"     , absmPrivate.getCaseNm());
            obj.put( "참가번호"     , absmPrivate.getPNo());
            obj.put( "이름"         , absmPrivate.getName());
            obj.put( "나이"         , absmPrivate.getAge());
            obj.put( "성별"         , absmPrivate.getSex());
            cell.add(obj);
        }

        jsonObject.put("rows", cell);

        result.put("boards", jsonObject);
        result.put("paging", paging);
        //mav.setViewName("input/baseline");
        return result;
    }

    /**
     * 입력처리
     * @param request
     * @return
     */
    @RequestMapping(value = "/input/baseline_form", method = RequestMethod.POST)
    public Map<String, Object> pageFormSubmit(
            HttpServletRequest request
    ) {

        Map<String, Object> result = new HashMap<String, Object>();

        logger.info("request data " + request.getParameterMap().toString());
        /*
		 * validate request type
		 */
        //Assert.state(request instanceof MultipartHttpServletRequest, "request !instanceof MultipartHttpServletRequest");
        if (!(request instanceof MultipartHttpServletRequest)) {
            result.put("retCode", "C001");
            result.put("retMsg", Message.C001);
            return result;
        }

        final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
        logger.info("multiRequest data " + multiRequest.getParameterMap().toString());

        AbsmCase absmCase = new AbsmCase();

		/* Form Data */
        String dt       = (String)request.getParameter("dt");
        String caseNm   = (String)request.getParameter("caseNm");
        String note     = (String)request.getParameter("note");

        absmCase.setDt(dt);
        absmCase.setCaseNm(caseNm);
        absmCase.setNote(note);

        absmCaseRepository.save(absmCase);

        // 등록된 Case Id를 조회하여 개인정보 입력시 사용
        int caId = page001Mapper.selectCaseId();

		/* get multipart file */
        final List<MultipartFile> files = multiRequest.getFiles("fileName");
        String[] fileType = request.getParameterValues("fileType");

        logger.info("files count " + files.size());
        logger.info("fileLocation " + fileLocation);

        /* process files */
        Iterator<MultipartFile> itr = files.iterator();
        MultipartFile file;
        String filePath = "";
        int i = 0;

        while (itr.hasNext()) {
            file = itr.next();

            if (file != null && !"".equals(file.getOriginalFilename())) {

                filePath = CommonUtil.fileTransferTo(file, fileLocation);

                /* after move file upload file data */
                FileUploadInfo fileUploadInfo = new FileUploadInfo();
                fileUploadInfo.setCaId(caId);
                fileUploadInfo.setFileName(filePath);
                fileUploadInfo.setFileType(fileType[i]);
                fileUploadInfo.setFileSize(file.getSize());

                if ("PRIVATE".equals(fileType[i])) {
                    privateFileService.setFileInfo(fileUploadInfo);
                    privateFileService.doParse();
                } else if ("SURVEY".equals(fileType[i])) {
                    surveyFileService.setFileInfo(fileUploadInfo);
                    surveyFileService.doParse();
                }
            }

            i++;
        }
        result.put("caId", caId);
        result.put("retCode", "S_PAGE1001");
        result.put("retMsg", Message.S_PAGE1001);
        return result;
    }
}
