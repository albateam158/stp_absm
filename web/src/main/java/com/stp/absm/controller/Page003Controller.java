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
 * 이벤트자료입력 화면
 */

@RestController
public class Page003Controller extends RootController {

    private final Logger logger = LoggerFactory.getLogger(Page003Controller.class);

    @Value(value = "${upload.fileLocation}")
    private String fileLocation;

    @Value(value = "${upload.fileUrl}")
    private String fileUrl;

    @Autowired
    protected EventFileService eventFileService;

    @Autowired
    protected FilterFileService filterFileService;
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

        List<AbsmCase> cases = absmCaseRepository.findByOrderByCaIdAsc();
        List<AbsmPrivate> pris = absmPrivateRepository.findByOrderByPrIdAsc();

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
        List<AbsmCase> cases = absmCaseRepository.findByOrderByCaIdAsc();

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
            obj.put( "대기지점출발"  , absmEvent.getEvDt1());
            obj.put( "판교역 출입구"  , absmEvent.getEvDt2());
            obj.put( "판교역 플랫폼"  , absmEvent.getEvDt3());
            obj.put( "지하철 탑승"  , absmEvent.getEvDt4());
            obj.put( "지하철 하차"  , absmEvent.getEvDt5());
            obj.put( "강남역 출입구"  , absmEvent.getEvDt6());
            obj.put( "버스정류장"  , absmEvent.getEvDt7());
            obj.put( "버스탑승"  , absmEvent.getEvDt8());
            obj.put( "버스하차"  , absmEvent.getEvDt9());
            obj.put( "대기지점"  , absmEvent.getEvDt10());

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
        Date now = new Date();
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
        String strCaId  = request.getParameter("caId");

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
        final List<MultipartFile> files = multiRequest.getFiles("fileName");
        String[] fileType = request.getParameterValues("fileType");

        Map<String, Object> param = new HashMap<String, Object>();
        param.put("caId",caId);

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
                fileUploadInfo.setUrl(fileUrl+file.getOriginalFilename());
                fileUploadInfo.setFileName(filePath);
                fileUploadInfo.setFileType(fileType[i]);
                fileUploadInfo.setFileSize(file.getSize());

                if ("EVENT".equals(fileType[i])) {

                    //이벤트 데이터삭제
                    page002Mapper.deleteEvent(param);

                    eventFileService.setFileInfo(fileUploadInfo);
                    eventFileService.doParse();

                } else if ("FILTER".equals(fileType[i])) {

                    //필터 데이터삭제
                    page002Mapper.deleteFilter(param);
                    //모델 데이터삭제
                    page002Mapper.deleteModel(param);

                    filterFileService.setFileInfo(fileUploadInfo);
                    filterFileService.doParse();

                    logger.info("Page003 param data " + param.toString());

                    List<AbsmFilter> absmFilterList = page002Mapper.selectFilterPrId(param);
                    Iterator iterator = absmFilterList.iterator();

                    while (iterator.hasNext()) {

                        AbsmFilter absmFilter = (AbsmFilter)iterator.next();
                        logger.info("Page003 absmFilter data " + absmFilter.toString());

                        modelData(absmFilter.getCaId(), absmFilter.getPrId(), now);
                    }
                }
            }
            i++;
        }

        result.put("caId", caId);
        result.put("retCode", "S_PAGE3001");
        result.put("retMsg", Message.S_PAGE3001);

        return result;
    }


    private void modelData(int caId, int prId, Date now) {

        AbsmFilter absmFilter = new AbsmFilter();
        AbsmModel absmModel = new AbsmModel();
        Map<String, Object> map = new HashMap<String, Object>();

        logger.info("Page003 modelData prId data " + prId);
        logger.info("Page003 modelData caId data " + caId);
        logger.info("Page003 modelData absmFilter data " + absmFilter.toString());

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
}
