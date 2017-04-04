package com.stp.absm.controller;

import com.stp.absm.common.*;
import com.stp.absm.model.*;
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
import java.util.*;

/**
 * 실험대상자 측정자료입력 화면
 */

@RestController
public class Page002Controller extends RootController {

    private final Logger logger = LoggerFactory.getLogger(Page002Controller.class);

    @Value(value = "${upload.fileLocation}")
    private String fileLocation;

    @Value(value = "${upload.fileUrl}")
    private String fileUrl;

    @Autowired
    protected MeasureFileService measureFileService;

    @Autowired
    protected ModelFileService modelFileService;

    @Autowired
    protected OrgFileService orgFileService;

    @Autowired
    protected FilterFileService filterFileService;


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
        List<AbsmCase> cases = absmCaseRepository.findByOrderByCaIdAsc();
        List<AbsmPrivate> pris = absmPrivateRepository.findByOrderByPrIdAsc();

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
        List<AbsmOrg> boards = page002Mapper.selectBoards(params);
        String paging = pagingUtil.getPagingLink((int) Math.ceil((double) count / pageable.getPageSize()), count, pageable.getPageNumber() + 1, request.getRequestURI(), params);

        JSONObject jsonObject = new JSONObject();
        JSONArray cell = new JSONArray();

        for(int i=0; i < boards.size(); i++) {

            AbsmOrg absmOrg = (AbsmOrg)boards.get(i);
            JSONObject obj = new JSONObject();

            obj.put( "케이스명"     , absmOrg.getCaseNm());
            obj.put( "참가번호"     , absmOrg.getPrId());
            obj.put( "필터시간"     , absmOrg.getFiTm());
            obj.put( "mean_rri"     , absmOrg.getMeanRri());
            obj.put( "std_rri"     , absmOrg.getStdRri());
            obj.put( "mean_hrv"     , absmOrg.getMeanHrv());
            obj.put( "std_hrv"     , absmOrg.getStdHrv());
            obj.put( "rmssdd"     , absmOrg.getRmssdd());
            obj.put( "pnn50"     , absmOrg.getPnn50());
            obj.put( "lfhf"     , absmOrg.getLfhf());
            obj.put( "scl"     , absmOrg.getScl());

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
        List<AbsmPrivate> pris = absmPrivateRepository.findByCaIdOrderByPrIdAsc(Integer.parseInt(caId));

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
        Date now        = new Date();

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
                fileUploadInfo.setUrl(fileUrl+file.getOriginalFilename());
                fileUploadInfo.setFileName(filePath);
                fileUploadInfo.setFileType(fileType[i]);
                fileUploadInfo.setFileSize(file.getSize());

                Map<String, Object> param = new HashMap<String, Object>();
                param.put("caId",caId);
                param.put("prId",prId);

                if ("ECG".equals(fileType[i]) || "GSR".equals(fileType[i])) {
                    //측정 데이터삭제 ECG일 경우만 삭제
                    if ("ECG".equals(fileType[i]))
                        page002Mapper.deleteMeasure(param);

                    measureFileService.setFileInfo(fileUploadInfo);
                    measureFileService.doParse();
                }
                else if ("FILTER".equals(fileType[i])) {
                    //필터 데이터삭제
                    page002Mapper.deleteFilter(param);
                    //모델 데이터삭제
                    page002Mapper.deleteModel(param);

                    filterFileService.setFileInfo(fileUploadInfo);
                    filterFileService.doParse();

                    AbsmFilter absmFilter = new AbsmFilter();
                    AbsmModel absmModel = new AbsmModel();
                    Map<String, Object> map = new HashMap<String, Object>();

                    absmFilter.setCaId(caId);
                    absmFilter.setPrId(prId);
                    absmFilter.setRegDate(now);
                    //평균 필터데이터생성
                    page002Mapper.createFilterValCd2(absmFilter);

                    //표준편차 필터데이터생성
                    page002Mapper.createFilterValCd3(absmFilter);

                    absmModel.setCaId(caId);
                    absmModel.setPrId(prId);
                    absmModel.setRegDate(now);
                    //Z표준화 모델데이터생성
                    page002Mapper.createModel(absmModel);

                    //모형식 모델업데이트
                    map.put("caId",caId);
                    map.put("prId",prId);
                    List<AbsmModel> modelResults = page002Mapper.selectModelResult(map);
                    for(AbsmModel modelResult : modelResults){
                        modelResult.setMoId(modelResult.getMoId());
                        modelResult.setCaId(modelResult.getCaId());
                        modelResult.setPrId(modelResult.getPrId());
                        modelResult.setSeCd(modelResult.getSeCd());
                        modelResult.setMoPre1(modelResult.getMoPre1());
                        modelResult.setMoPre2(modelResult.getMoPre2());
                        modelResult.setMoPre3(modelResult.getMoPre3());
                        modelResult.setMoPre4(modelResult.getMoPre4());
                        modelResult.setStLevel(modelResult.getStLevel());
                        modelResult.setRegDate(now);
                        absmModelRepository.save(modelResult);
                    }


                }
                else if ("ORG".equals(fileType[i])) {

                    //원본 데이터삭제
                    page002Mapper.deleteOrg(param);

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