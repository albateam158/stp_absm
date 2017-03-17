package com.stp.absm.controller;

import com.stp.absm.common.CommonUtil;
import com.stp.absm.common.EventFileService;
import com.stp.absm.common.FileUploadInfo;
import com.stp.absm.common.Message;
import com.stp.absm.model.AbsmCase;
import com.stp.absm.model.AbsmEvent;
import com.stp.absm.model.AbsmPrivate;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 이벤트자료입력 화면
 */

@RestController
public class Page003Controller extends RootController {

    private final Logger logger = LoggerFactory.getLogger(Page003Controller.class);

    @Value(value = "${upload.fileLocation}")
    private String fileLocation;

    @Autowired
    protected EventFileService eventFileService;

    /**
     * 조회화면
     * @param request
     * @param mav
     * @return
     */
    @RequestMapping(value = "/input/event", method = RequestMethod.GET)
    public ModelAndView pageFormList(
            HttpServletRequest request,
            ModelAndView mav
    ) {

        List<AbsmCase> cases = absmCaseRepository.findByDeleteDateIsNullOrderByCaIdAsc();
        List<AbsmPrivate> pris = absmPrivateRepository.findByDeleteDateIsNullOrderByPrIdAsc();

        mav.addObject("cases", cases);
        mav.addObject("pris", pris);

        mav.setViewName("input/event");

        return mav;
    }

    /**
     * 케이스 목록 조회
     * @param request
     * @param request
     * @return
     */
    @RequestMapping(value = "/input/caseList", method = RequestMethod.GET)
    public Map<String, Object> caseList(
            HttpServletRequest request
    ) {
        List<AbsmCase> cases = absmCaseRepository.findByDeleteDateIsNullOrderByCaIdAsc();

        Map<String, Object> result = new HashMap<String, Object>();
        result.put("cases", cases);

        return result;
    }

    /**
     * 개인 정보 조회
     * @param request
     * @param request
     * @return
     */
    @RequestMapping(value = "/input/privateList", method = RequestMethod.GET)
    public Map<String, Object> privateList(
            @RequestParam(value = "caId", required = false) String caId,
            HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("caId", caId);

        List<AbsmPrivate> pris = page003Mapper.selectPrivates(params);
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("pris", pris);

        return result;
    }

    /**
     * 조회화면 목록 DIV
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/input/event_div", method = RequestMethod.GET)
    public Map<String, Object> pageFormListDiv(
            @RequestParam(value = "caId", required = false) String caId,
            @RequestParam(value = "prId", required = false) String prId,
            Pageable pageable,
            ModelAndView mav,
            HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("caId", caId);
        params.put("prId", prId);
        params.put("pageable", pageable);

        Map<String, Object> result = new HashMap<String, Object>();

        int count = page003Mapper.selectBoardsCount(params);
        List<AbsmEvent> boards = page003Mapper.selectBoards(params);
        String paging = pagingUtil.getPagingLink((int) Math.ceil((double) count / pageable.getPageSize()), count, pageable.getPageNumber() + 1, request.getRequestURI(), params);

        JSONObject jsonObject = new JSONObject();
        JSONArray cell = new JSONArray();

        for(int i=0; i < boards.size(); i++) {

            AbsmEvent absmEvent = (AbsmEvent)boards.get(i);
            JSONObject obj = new JSONObject();

            obj.put( "이름"     , absmEvent.getCaseNm());
            obj.put( "이벤트1"  , absmEvent.getEvDt1());
            obj.put( "이벤트2"  , absmEvent.getEvDt2());
            obj.put( "이벤트3"  , absmEvent.getEvDt3());
            obj.put( "이벤트4"  , absmEvent.getEvDt4());
            obj.put( "이벤트5"  , absmEvent.getEvDt5());
            obj.put( "이벤트6"  , absmEvent.getEvDt6());
            obj.put( "이벤트7"  , absmEvent.getEvDt7());
            obj.put( "이벤트8"  , absmEvent.getEvDt8());
            obj.put( "이벤트9"  , absmEvent.getEvDt9());
            obj.put( "이벤트10"  , absmEvent.getEvDt10());

            cell.add(obj);
        }

        jsonObject.put("rows", cell);

        result.put("boards", jsonObject);
        result.put("paging", paging);

        //mav.addObject("boards", boards);
        //mav.addObject("paging", paging);
        //mav.setViewName("input/event_div");
        return result;
    }

    /**
     * 입력처리
     * @param request
     * @return
     */
    @RequestMapping(value = "/input/event_form", method = RequestMethod.POST)
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

        int caId = 0;
        if (!"".equals(strCaId)) {
            caId = Integer.valueOf(strCaId);
        }
        else {
            result.put("retCode", "C002");
            result.put("retMsg", Message.C002);
            return result;
        }

        /* get multipart file */
        MultipartFile file = multiRequest.getFile("fileName");
        String fileType = request.getParameter("fileType");

        logger.info("fileLocation " + fileLocation);

        String filePath = CommonUtil.fileTransferTo(file, fileLocation);

        /* after move file upload file data */
        FileUploadInfo fileUploadInfo = new FileUploadInfo();
        fileUploadInfo.setCaId(caId);
        fileUploadInfo.setFileName(filePath);
        fileUploadInfo.setFileType(fileType);
        fileUploadInfo.setFileSize(file.getSize());

        if ("EVENT".equals(fileType)) {
            eventFileService.setFileInfo(fileUploadInfo);
            eventFileService.doParse();
        }

        result.put("caId", caId);
        result.put("retCode", "S_PAGE3001");
        result.put("retMsg", Message.S_PAGE3001);

        return result;
    }


}
