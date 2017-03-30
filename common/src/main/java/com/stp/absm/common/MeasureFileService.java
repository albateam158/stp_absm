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
import java.util.Date;

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
        Date now        = new Date();

        String fileType = fileUploadInfo.getFileType();
        String fileName = fileUploadInfo.getFileName();
        String url      = fileUploadInfo.getUrl();
        int caId        = fileUploadInfo.getCaId();
        int prId        = fileUploadInfo.getPrId();
        long fileSize   = fileUploadInfo.getFileSize();

        String egCd = "";
        if ("ECG".equals(fileType)) {
            egCd = "E";
        }
        else if ("GSR".equals(fileType)) {
            egCd = "G";
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
                        //absmMeasure.setMeTm(dataArray[0] + " " + dataArray[1]);
                        absmMeasure.setMeTm(dataArray[0]);
                        absmMeasure.setMeVal(Double.valueOf(dataArray[3]));
                        absmMeasure.setRegDate(now);
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
                        absmMeasure.setRegDate(now);
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
            absmFile.setPrId(prId);

            if ("ECG".equals(fileType)) {
                absmFile.setFileCd("03");
            }
            else if ("GSR".equals(fileType)) {
                absmFile.setFileCd("04");
            }

            absmFile.setFileName(fileName);
            absmFile.setFileSize(fileSize);
            absmFile.setUrl(url);
            absmFile.setRegDate(now);
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
