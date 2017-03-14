package com.stp.absm.common;

import com.stp.absm.model.AbsmFile;
import com.stp.absm.model.AbsmMeasure;
import com.stp.absm.repository.AbsmFileRepository;
import com.stp.absm.repository.AbsmMeasureRepository;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

/**
 * Created by thomas on 2017-03-13.
 */
@Service
public class MeasureFileService implements DataFileService {

    public static Logger logger = Logger.getLogger(MeasureFileService.class);

    FileUploadInfo fileUploadInfo = new FileUploadInfo();

    @Autowired
    protected AbsmMeasureRepository absmMeasureRepository;

    @Autowired
    protected AbsmFileRepository absmFileRepository;

    public MeasureFileService() {}

    @Override
    public void setFileInfo(FileUploadInfo fileUploadInfo) {
        this.fileUploadInfo = fileUploadInfo;
    }

    @Override
    public int doParse() {

        String fileType = fileUploadInfo.getFileType();
        String fileName = fileUploadInfo.getFileName();
        int caId        = fileUploadInfo.getCaId();
        int prId        = fileUploadInfo.getPrId();
        long fileSize   = fileUploadInfo.getFileSize();

        String egCd = "";
        if ("ECG".equals(fileType)) {
            egCd = "1";
        }
        else if ("GSR".equals(fileType)) {
            egCd = "2";
        }

        try {
            BufferedReader br = new BufferedReader(new FileReader(fileName));
            String strLine;
            int lineCount = 0;

            /**
             * ECG 파일 구분자가 공백과 탭이 섞여 있음 하나로 통일 필요
             */
            if ("ECG".equals(fileType)) {
                while ((strLine = br.readLine()) != null) {

                    if (lineCount > 2) {
                        String[] dataArray = strLine.split("\t");

                        AbsmMeasure absmMeasure = new AbsmMeasure();

                        absmMeasure.setCaId(caId);
                        absmMeasure.setPrId(prId);
                        absmMeasure.setEgCd(egCd);
                        absmMeasure.setMeTm(dataArray[0] + " " + dataArray[1]);
                        absmMeasure.setMeVal(Double.valueOf(dataArray[4]));

                        logger.info(absmMeasure.toString());
                        absmMeasureRepository.save(absmMeasure);
                    }
                    lineCount++;
                }
            }
            else if ("GSR".equals(fileType)) {
                while ((strLine = br.readLine()) != null)   {

                    if (lineCount > 1) {
                        String[] dataArray = strLine.split(",");

                        AbsmMeasure absmMeasure = new AbsmMeasure();

                        absmMeasure.setCaId(caId);
                        absmMeasure.setPrId(prId);
                        absmMeasure.setEgCd(egCd);
                        absmMeasure.setMeTm(dataArray[0]);
                        absmMeasure.setMeVal(Double.valueOf(dataArray[1]));

                        logger.info(absmMeasure.toString());
                        absmMeasureRepository.save(absmMeasure);
                    }
                    lineCount++;
                }
            }

            br.close();

            // File Table Insert
            AbsmFile absmFile = new AbsmFile();
            absmFile.setCaId(caId);
            /* 개인정보 또는 설문조사 파일은 개인이 아니라 case 별로 올라감 */
            absmFile.setPrId(prId);
            absmFile.setFileCd("TXT");
            absmFile.setFileName(fileName);
            absmFile.setFileSize(fileSize);
            absmFile.setUrl(fileName);

            absmFileRepository.save(absmFile);

        }
        catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return 0;
    }
}
