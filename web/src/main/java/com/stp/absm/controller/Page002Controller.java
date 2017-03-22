package com.stp.absm.controller;

import com.stp.absm.common.*;
import com.stp.absm.model.AbsmCase;
import com.stp.absm.model.AbsmMeasure;
import com.stp.absm.model.AbsmPrivate;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * 실험대상자 측정자료입력 화면
 */

@RestController
public class Page002Controller extends RootController {

    private final Logger logger = LoggerFactory.getLogger(Page002Controller.class);

    @Value(value = "${upload.fileLocation}")
    private String fileLocation;

    @Autowired
    protected MeasureFileService measureFileService;

    @Autowired
    protected ModelFileService modelFileService;

    @Autowired
    protected OrgFileService orgFileService;

    /**
     * 조회화면
     * @param request
     * @param mav
     * @return
     */
    @RequestMapping(value = "/input/biosignal", method = RequestMethod.GET)
    public ModelAndView pageFormList(
            HttpServletRequest request,
            ModelAndView mav
    ) {
        List<AbsmCase> cases = absmCaseRepository.findByDeleteDateIsNullOrderByCaIdAsc();
        List<AbsmPrivate> pris = absmPrivateRepository.findByDeleteDateIsNullOrderByPrIdAsc();

        mav.addObject("cases", cases);
        mav.addObject("pris", pris);

        mav.setViewName("input/biosignal");

        return mav;
    }

    /**
     * 조회화면 목록 DIV
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/input/biosignal_div", method = RequestMethod.GET)
    public Map<String, Object>  pageFormListDiv(
            @RequestParam(value = "caId", required = false) String caId,
            @RequestParam(value = "prId", required = false) String prId,
            Pageable pageable,
            ModelAndView mav,
            HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();

        params.put("caId", caId);
        params.put("prId", prId);
        params.put("pageable", pageable);

        int count = page002Mapper.selectBoardsCount(params);
        List<AbsmMeasure> boards = page002Mapper.selectBoards(params);
        String paging = pagingUtil.getPagingLink((int) Math.ceil((double) count / pageable.getPageSize()), count, pageable.getPageNumber() + 1, request.getRequestURI(), params);

        JSONObject jsonObject = new JSONObject();
        JSONArray cell = new JSONArray();

        for(int i=0; i < boards.size(); i++) {

            AbsmMeasure absmMeasure = (AbsmMeasure)boards.get(i);
            JSONObject obj = new JSONObject();

            obj.put( "케이스명"     , absmMeasure.getCaseNm());
            obj.put( "참가번호"     , absmMeasure.getPrId());
            obj.put( "ECG/GSR구분"  , absmMeasure.getEgCd());
            obj.put( "측정시간"     , absmMeasure.getMeTm());
            obj.put( "측정값"       , absmMeasure.getMeVal());

            cell.add(obj);
        }

        jsonObject.put("rows", cell);

        result.put("boards", jsonObject);
        result.put("paging", paging);

        //mav.addObject("boards", boards);
        //mav.addObject("paging", paging);
        //mav.setViewName("input/biosignal_div");

        return result;
    }

    /**
     * 케이스변경시 개인데이터 리로드 Ajax
     * 전화면 공통 사용
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/input/private_combo" , method={RequestMethod.GET, RequestMethod.POST})
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
    @RequestMapping(value = "input/biosignal_form", method = RequestMethod.POST)
    public Map<String, Object> pageFormSubmit(
            HttpServletRequest request
    ) {
        Map<String, Object> result = new HashMap<String, Object>();

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

		/* Form Data */
        String strCaId  = (String)request.getParameter("caId");
        String strPrId  = (String)request.getParameter("prId");

        logger.info("caId " + strCaId);
        logger.info("prId " + strPrId);

        int caId = 0;
        if (!"".equals(strCaId)) {
            caId = Integer.valueOf(strCaId);
        }
        else {
            result.put("retCode", "C002");
            result.put("retMsg", Message.C002);
            return result;
        }

        int prId = 0;
        if (!"".equals(strPrId)) {
            prId = Integer.valueOf(strPrId);
        }
        else {
            result.put("retCode", "C003");
            result.put("retMsg", Message.C003);
            return result;
        }

        /* get multipart file */
        final List<MultipartFile> files = multiRequest.getFiles("fileName");
        String[] fileType = request.getParameterValues("fileType");

        logger.info("files count " + files.size());
        logger.info("fileLocation " + fileLocation);

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
                fileUploadInfo.setPrId(prId);
                fileUploadInfo.setFileName(filePath);
                fileUploadInfo.setFileType(fileType[i]);
                fileUploadInfo.setFileSize(file.getSize());

                if ("ECG".equals(fileType[i]) || "GSR".equals(fileType[i])) {
                    measureFileService.setFileInfo(fileUploadInfo);
                    measureFileService.doParse();
                }
                else if ("MODEL".equals(fileType[i])) {
                    modelFileService.setFileInfo(fileUploadInfo);
                    modelFileService.doParse();
                }
                else if ("ORG".equals(fileType[i])) {
                    orgFileService.setFileInfo(fileUploadInfo);
                    orgFileService.doParse();
                }
            }
            i++;
        }

        result.put("caId", caId);
        result.put("prId", prId);
        result.put("retCode", "S_PAGE2001");
        result.put("retMsg", Message.S_PAGE2001);

        return result;
    }


}