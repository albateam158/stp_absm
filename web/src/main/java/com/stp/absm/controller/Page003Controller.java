package com.stp.absm.controller;

import com.stp.absm.common.CommonUtil;
import com.stp.absm.common.EventFileService;
import com.stp.absm.common.FileUploadInfo;
import com.stp.absm.model.AbsmCase;
import com.stp.absm.model.AbsmEvent;
import com.stp.absm.model.AbsmPrivate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Pageable;
import org.springframework.util.Assert;
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
     * 조회화면 목록 DIV
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/input/event_div", method = RequestMethod.GET)
    public ModelAndView pageFormListDiv(
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

        int count = page003Mapper.selectBoardsCount(params);
        List<AbsmEvent> boards = page003Mapper.selectBoards(params);
        String paging = pagingUtil.getPagingLink((int) Math.ceil((double) count / pageable.getPageSize()), count, pageable.getPageNumber() + 1, request.getRequestURI(), params);

        mav.addObject("boards", boards);
        mav.addObject("paging", paging);
        mav.setViewName("input/event_div");
        return mav;
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
        Assert.state(request instanceof MultipartHttpServletRequest, "request !instanceof MultipartHttpServletRequest");
        final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;

		/* Form Data */
        String strCaId  = (String)request.getParameter("caId");
        String strPrId  = (String)request.getParameter("prId");
        String name     = (String)request.getParameter("name");

        int caId = 0;
        if (!"".equals(strCaId))
            caId = Integer.valueOf(strCaId);
        else
            caId = 1;

        int prId = 0;
        if (!"".equals(strPrId))
            prId = Integer.valueOf(strPrId);
        else
            prId = 1;


        /* get multipart file */
        MultipartFile file = multiRequest.getFile("fileName");
        String fileType = request.getParameter("fileType");

        logger.info("fileLocation " + fileLocation);

        String filePath = CommonUtil.fileTransferTo(file, fileLocation);

        /* after move file upload file data */
        FileUploadInfo fileUploadInfo = new FileUploadInfo();
        fileUploadInfo.setCaId(caId);
        fileUploadInfo.setPrId(prId);
        fileUploadInfo.setFileName(filePath);
        fileUploadInfo.setFileType(fileType);
        fileUploadInfo.setFileSize(file.getSize());

        if ("EVENT".equals(fileType)) {
            eventFileService.setFileInfo(fileUploadInfo);
            eventFileService.doParse();
        }

        return result;
    }


}
