package com.stp.absm.controller;

import com.stp.absm.common.CommonUtil;
import com.stp.absm.model.AbsmCase;
import com.stp.absm.model.AbsmFile;
import com.stp.absm.model.AbsmPrivate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
 *  동영상 자료 화면
 */

@RestController
public class Page004Controller extends RootController {

    private final Logger logger = LoggerFactory.getLogger(Page004Controller.class);

    @Value(value = "${upload.fileLocation}")
    private String fileLocation;

    /**
     * 조회화면
     * @param request
     * @param mav
     * @return
     */
    @RequestMapping(value = "/page004/list", method = RequestMethod.GET)
    public ModelAndView pageFormList(
            HttpServletRequest request,
            ModelAndView mav
    ) {
        List<AbsmCase> cases = absmCaseRepository.findByDeleteDateIsNullOrderByCaIdAsc();
        List<AbsmPrivate> pris = absmPrivateRepository.findByDeleteDateIsNullOrderByPrIdAsc();

        mav.addObject("cases", cases);
        mav.addObject("pris", pris);

        mav.setViewName("page004/list");

        return mav;
    }

    /**
     * 조회화면 목록 DIV
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/page004/list_div", method = RequestMethod.GET)
    public ModelAndView pageFormListDiv(
            @RequestParam(value = "caId", required = false) String caId,
            @RequestParam(value = "prId", required = false) String prId,
            @RequestParam(value = "fileCd", required = false) String fileCd,
            Pageable pageable,
            ModelAndView mav,
            HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("caId", caId);
        params.put("prId", prId);
        params.put("fileCd", fileCd);

        int count = page004Mapper.selectBoardsCount(params);
        List<AbsmFile> boards = page004Mapper.selectBoards(params);
        String paging = pagingUtil.getPagingLink((int) Math.ceil((double) count / pageable.getPageSize()), count, pageable.getPageNumber() + 1, request.getRequestURI(), params);

        mav.addObject("boards", boards);
        mav.addObject("paging", paging);
        mav.setViewName("page004/list_div");
        return mav;
    }

    /**
     * 입력처리
     * @param request
     * @return
     */
    @RequestMapping(value = "/page004/form", method = RequestMethod.POST)
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
        final MultipartFile file = multiRequest.getFile("fileName");
        String[] fileType = request.getParameterValues("fileType");

        logger.info("fileLocation " + fileLocation);

        String filePath = CommonUtil.fileTransferTo(file, fileLocation);

        // File Table Insert
        AbsmFile absmFile = new AbsmFile();
        absmFile.setCaId(caId);
        /* 개인정보 또는 설문조사 파일은 개인이 아니라 case 별로 올라감 */
        absmFile.setPrId(prId);
        absmFile.setFileCd("XLS");
        absmFile.setFileName(filePath);
        absmFile.setFileSize(file.getSize());
        absmFile.setUrl(filePath);

        absmFileRepository.save(absmFile);

        return result;
    }


}
