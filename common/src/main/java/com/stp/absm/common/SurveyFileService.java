package com.stp.absm.common;

import com.stp.absm.model.AbsmFile;
import com.stp.absm.model.AbsmSurvey;
import com.stp.absm.model.AbsmSurveyAvg;
import com.stp.absm.repository.AbsmFileRepository;
import com.stp.absm.repository.AbsmSurveyAvgRepository;
import com.stp.absm.repository.AbsmSurveyRepository;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Date;

/**
 * Created by thomas on 2017-03-13.
 */
@Service
public class SurveyFileService implements DataFileService {

    public static Logger logger = Logger.getLogger(SurveyFileService.class);

    FileUploadInfo fileUploadInfo = new FileUploadInfo();

    @Autowired
    protected AbsmSurveyRepository absmSurveyRepository;

    @Autowired
    protected AbsmFileRepository absmFileRepository;

    @Autowired
    protected AbsmSurveyAvgRepository absmSurveyAvgRepository;

    public SurveyFileService() {}

    @Override
    public void setFileInfo(FileUploadInfo fileUploadInfo) {
        this.fileUploadInfo = fileUploadInfo;
    }

    @Override
    public int doParse() {
        Date now        = new Date();

        // file open db insert
        String fileName = fileUploadInfo.getFileName();
        String url      = fileUploadInfo.getUrl();
        int caId        = fileUploadInfo.getCaId();
        int prId        = fileUploadInfo.getPrId();
        long fileSize   = fileUploadInfo.getFileSize();

        try {
            // 엑셀파일
            File file = new File(fileName);

            // 엑셀 파일 오픈
            XSSFWorkbook wb = new XSSFWorkbook(new FileInputStream(file));

            for (Row row : wb.getSheetAt(0)) {

                if (row.getRowNum() < 1)
                    continue;

                if (row.getCell(0) != null) {

                    String str = row.getCell(0).toString();

                    if ("모형적용값".equals(str)) {
                        AbsmSurveyAvg absmSurveyAvg = new AbsmSurveyAvg();
                        absmSurveyAvg.setCaId(caId);
                        // 설문조사 파일의 모형적용값은 cell 두개가 병합
                        absmSurveyAvg.setSuVal1(CommonUtil.removeDot(row.getCell(2).toString()));
                        absmSurveyAvg.setSuVal2(CommonUtil.removeDot(row.getCell(3).toString()));
                        absmSurveyAvg.setSuVal3(CommonUtil.removeDot(row.getCell(4).toString()));
                        absmSurveyAvg.setSuVal4(CommonUtil.removeDot(row.getCell(5).toString()));
                        absmSurveyAvg.setSuVal5(CommonUtil.removeDot(row.getCell(6).toString()));
                        absmSurveyAvg.setSuVal6(CommonUtil.removeDot(row.getCell(7).toString()));
                        absmSurveyAvg.setSuVal7(CommonUtil.removeDot(row.getCell(8).toString()));
                        absmSurveyAvg.setSuVal8(CommonUtil.removeDot(row.getCell(9).toString()));
                        absmSurveyAvg.setRegDate(now);
                        logger.info(absmSurveyAvg.toString());
                        absmSurveyAvgRepository.save(absmSurveyAvg);
                    }
                    else if(!"평균".equals(str) &&
                            !"이상치(0,24)제외".equals(str) &&
                            !"모형적용값".equals(str)) {

                        AbsmSurvey absmSurvey = new AbsmSurvey();
                        absmSurvey.setCaId(caId);
                        // 설문조사 파일의 평균 값은 cell 두개가 병합
                        absmSurvey.setPrId(Integer.valueOf(CommonUtil.removeDot(row.getCell(0).toString())));
                        absmSurvey.setSuVal1(CommonUtil.removeDot(row.getCell(2).toString()));
                        absmSurvey.setSuVal2(CommonUtil.removeDot(row.getCell(3).toString()));
                        absmSurvey.setSuVal3(CommonUtil.removeDot(row.getCell(4).toString()));
                        absmSurvey.setSuVal4(CommonUtil.removeDot(row.getCell(5).toString()));
                        absmSurvey.setSuVal5(CommonUtil.removeDot(row.getCell(6).toString()));
                        absmSurvey.setSuVal6(CommonUtil.removeDot(row.getCell(7).toString()));
                        absmSurvey.setSuVal7(CommonUtil.removeDot(row.getCell(8).toString()));
                        absmSurvey.setSuVal8(CommonUtil.removeDot(row.getCell(9).toString()));
                        absmSurvey.setRegDate(now);
                        logger.info(absmSurvey.toString());

                        absmSurveyRepository.save(absmSurvey);
                    }
                }
            }

            // File Table Insert
            AbsmFile absmFile = new AbsmFile();
            absmFile.setCaId(caId);
            /* 개인정보 또는 설문조사 파일은 개인이 아니라 case 별로 올라감 */
            absmFile.setPrId(prId);
            absmFile.setFileCd("02");
            absmFile.setFileName(fileName);
            absmFile.setFileSize(fileSize);
            absmFile.setUrl(url);
            absmFile.setRegDate(now);
            absmFileRepository.save(absmFile);

        } catch (FileNotFoundException fe) {
            System.out.println("FileNotFoundException >> " + fe.toString());
        } catch (IOException ie) {
            System.out.println("IOException >> " + ie.toString());
        }

        return 0;
    }

}
