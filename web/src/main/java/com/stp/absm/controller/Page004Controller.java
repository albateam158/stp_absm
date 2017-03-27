package com.stp.absm.controller;

import com.stp.absm.common.CommonUtil;
import com.stp.absm.common.Message;
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

    @Value(value = "${upload.fileUrl}")
    private String fileUrl;

    /**
     * 조회화면
     * @param request
     * @param mav
     * @return
     */
    @RequestMapping(value = "/input/video", method = RequestMethod.GET)
    public ModelAndView pageFormList(
            HttpServletRequest request,
            ModelAndView mav
    ) {
        List<AbsmCase> cases = absmCaseRepository.findByOrderByCaIdAsc();
        List<AbsmPrivate> pris = absmPrivateRepository.findByOrderByPrIdAsc();

        mav.addObject("cases", cases);
        mav.addObject("pris", pris);

        mav.setViewName("input/video");

        return mav;
    }

    /**
     * 조회화면 목록 DIV
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/input/video_div", method = RequestMethod.GET)
    public Map<String, Object> pageFormListDiv(
            @RequestParam(value = "caId", required = false) String caId,
            @RequestParam(value = "prId", required = false) String prId,
            @RequestParam(value = "fileCd", required = false) String fileCd,
            Pageable pageable,
            ModelAndView mav,
            HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();

        params.put("caId", caId);
        params.put("prId", prId);
        params.put("fileCd", fileCd);

        logger.info("parameter data " + params.toString());

        int count = page004Mapper.selectBoardsCount(params);
        List<AbsmFile> boards = page004Mapper.selectBoards(params);
        String paging = pagingUtil.getPagingLink((int) Math.ceil((double) count / pageable.getPageSize()), count, pageable.getPageNumber() + 1, request.getRequestURI(), params);

        String url = "";
        if (boards.size() > 0)
            url = boards.get(0).getUrl();

        result.put("url", url);
        return result;
    }

    /**
     * 입력처리
     * @param request
     * @return
     */
    @RequestMapping(value = "/input/video_form", method = RequestMethod.POST)
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
        final MultipartFile file = multiRequest.getFile("fileName");
        //String[] fileType = request.getParameterValues("fileType");

        logger.info("fileLocation " + fileLocation);

        //String filePath = CommonUtil.fileTransferTo(file, fileLocation);
        CommonUtil.fileTransferTo(file, fileLocation);

        Map<String, Object> param = new HashMap<String, Object>();
        param.put("caId",caId);
        param.put("prId",prId);
        param.put("fileCd","08");

        //파일 데이터삭제
        page002Mapper.deleteFile(param);
        // File Table Insert
        AbsmFile absmFile = new AbsmFile();
        absmFile.setCaId(caId);
        absmFile.setPrId(prId);
        absmFile.setFileCd("08");
        absmFile.setFileName(file.getOriginalFilename());
        absmFile.setFileSize(file.getSize());
        absmFile.setUrl(fileUrl+file.getOriginalFilename());

        absmFileRepository.save(absmFile);

        result.put("caId", caId);
        result.put("prId", prId);
        result.put("retCode", "S_PAGE4001");
        result.put("retMsg", Message.S_PAGE4001);

        return result;
    }


}
