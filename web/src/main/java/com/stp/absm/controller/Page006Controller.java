package com.stp.absm.controller;

import com.stp.absm.common.ExcelUtil;
import com.stp.absm.model.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 결과보기 화면
 */

@RestController
public class Page006Controller extends RootController {

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
    @RequestMapping(value = "/result/result", method = RequestMethod.GET)
    public ModelAndView pageFormList(
            @RequestParam(value = "caId", required = false) Integer caId,
            @RequestParam(value = "pNo", required = false) Integer pNo,
            HttpServletRequest request,
            ModelAndView mav
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("caId",caId);
        params.put("pNo",pNo);

        List<AbsmCase> cases = absmCaseRepository.findByOrderByCaIdAsc();
//        List<AbsmPrivate> LPris = absmPrivateRepository.findByCaIdOrderByPrIdAsc(caId);
        List<AbsmPrivate> LPris = page006Mapper.selectPrivates(params);
        AbsmPrivate LPri = page006Mapper.selectPrivate(params);

//        Map<String , Object> params = new HashMap<String, Object>();
//        params.put("caId", caId);
//        params.put("pNo", pNo);

        /*List<AbsmFilter> filters = page006Mapper.selectResultData(params);*/
        AbsmPrivate aPri = new AbsmPrivate();
        aPri.setCaId(caId);
        aPri.setPrNo(pNo);
        mav.addObject("cases", cases);
        mav.addObject("LPris", LPris);
        mav.addObject("aPri", aPri);
        mav.addObject("LPri", LPri);
        //mav.addObject("chartData", filters);
        //mav.addObject("bioChartData", filters);
        //mav.addObject("privateData");
        //mav.addObject("measureResult");
        mav.setViewName("result/result");

        return mav;
    }

    @RequestMapping(value = "/result/pri_combo" , method={RequestMethod.GET, RequestMethod.POST})
    public @ResponseBody List<AbsmPrivate> smallClassComboAjax(
            final HttpServletRequest request, final HttpServletResponse response) {
        String  caId = request.getParameter("caId");
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("caId",caId);

        List<AbsmPrivate> LPris = page006Mapper.selectPrivates(params);

        return LPris;
    }


    @RequestMapping(value = "/result/chart", method = RequestMethod.GET)
    public @ResponseBody Map<String, Object> chartInfoAjax(
            @RequestParam(value = "caId", required = false) Integer caId,
            @RequestParam(value = "pNo", required = false) Integer pNo,
            @RequestParam(value = "chartId", required = false) String chartId,
            HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();

        params.put("caId"   , caId);
        params.put("pNo"    , pNo);
        params.put("chartId", chartId);

        AbsmPrivate LPri = page006Mapper.selectPrivate(params);

        // Filter Data
        //List<AbsmFilter>   chartInfo    = page006Mapper.selectResultData(params);
        List<AbsmOrg> chartInfo = page006Mapper.selectGraph(params);
        // Video Data
        AbsmFile absmFile = page006Mapper.selectVideoUrl(params);
        // Event Data
        List<AbsmEvent> events = page006Mapper.selectEvents(params);

        result.put("chartInfo", chartInfo);
        result.put("videoInfo", absmFile);
        result.put("events", events);
        result.put("LPri", LPri);

        return result;
    }

    /**
     * Filter값 조회 ajax
     * @param request
     * @return
     */
    @RequestMapping(value = "/result/filter", method = RequestMethod.GET)
    public @ResponseBody
    List<AbsmMeasure> filterFormListAjax(
            @RequestParam(value = "caId", required = false) Integer caId,
            @RequestParam(value = "pNo", required = false) Integer pNo,
            @RequestParam(value = "egCd", required = false) String egCd,
            @RequestParam(value = "lastRow", required = false) Integer lastRow,
            HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("caId", caId);
        params.put("pNo", pNo);
        params.put("egCd", egCd);
        params.put("lastRow", lastRow);
        params.put("rowCount", 100);

        //List<AbsmFilter> filters = page006Mapper.selectFilters(params);
        List<AbsmMeasure> filters = page006Mapper.selectGraph2(params);
        return filters;
    }

    /**
     * Model값 조회 ajax
     * @param request
     * @return
     */
    @RequestMapping(value = "/result/model", method = RequestMethod.GET)
    public @ResponseBody
    List<AbsmModel> modelFormListAjax(
            @RequestParam(value = "caId", required = false) Integer caId,
            @RequestParam(value = "prId", required = false) Integer prId,
            HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("caId", caId);
        params.put("prId", prId);

        List<AbsmModel> models = page006Mapper.selectModels(params);

        return models;
    }

    /**
     * Measure값 조회 ajax
     * @param request
     * @return
     */
    @RequestMapping(value = "/result/measure", method = RequestMethod.GET)
    public @ResponseBody
    List<AbsmModel> measureFormListAjax(
            @RequestParam(value = "caId", required = false) Integer caId,
            @RequestParam(value = "prId", required = false) Integer prId,
            @RequestParam(value = "egCd", required = false) String egCd,
            @RequestParam(value = "lastRow", required = false) String lastRow,

            HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("caId", caId);
        params.put("prId", prId);
        params.put("egCd", egCd);
        params.put("lastRow", lastRow);

        List<AbsmModel> models = page006Mapper.selectModels(params);

        return models;
    }


    /**
     * Report 파일 생성 ajax
     * @param request
     * @return
     */
    @RequestMapping(value = "/result/measureReport", method = RequestMethod.GET)
    public void measureReportAjax(
            @RequestParam(value = "caId", required = false) Integer caId,
            @RequestParam(value = "pNo", required = false) Integer pNo,

            HttpServletRequest request, HttpServletResponse response
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("caId"   , caId);
        params.put("pNo"    , pNo);

        AbsmPrivate absmPrivate  = page006Mapper.selectPrivate(params);
        List<AbsmOrg> reportData = page006Mapper.selectReportData(params);

        List excelparamList = new ArrayList();
        excelparamList.add(absmPrivate);
        excelparamList.add(reportData);
        ExcelUtil excelUtil = ExcelUtil.getInstance();

        String fileName = "absm_report_"+ absmPrivate.getName() +"("+absmPrivate.getAge()+").xls";
        excelUtil.makeFile(fileLocation, fileName, excelparamList);

        try {

            /* 생성된 파일 */
            File file = new File(fileLocation+fileName);
            InputStream is = new FileInputStream(file);

            /* 브라우저를 통해서 다운로드 될 파일명 */
            String downFile = "absm_report_"+ absmPrivate.getName() +"("+absmPrivate.getAge()+")";

            /* 파일명 한글 Encoding */
            downFile = new String(downFile.getBytes("UTF-8"), "ISO-8859-1");
            String fileExtension = ".xls";

            int bytelength = (int) file.length();
            byte fileByte[] = new byte[bytelength];

            response.reset();
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment;filename=\"" + fileUrl + downFile + fileExtension + "\"");

            OutputStream output = response.getOutputStream();

            for (int nChunk = is.read(fileByte); nChunk!=-1; nChunk = is.read(fileByte)) {
                output.write(fileByte);
            }

            is.close();
            output.close();
        }
        catch (IOException ie) {
            ie.printStackTrace();
        }
    }
}
