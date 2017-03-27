package com.stp.absm.common;

import com.stp.absm.model.AbsmEvent;
import com.stp.absm.model.AbsmFile;
import com.stp.absm.repository.AbsmEventRepository;
import com.stp.absm.repository.AbsmFileRepository;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

/**
 * Created by thomas on 2017-03-13.
 */
@Service
public class EventFileService implements DataFileService{

    public static Logger logger = Logger.getLogger(EventFileService.class);

    FileUploadInfo fileUploadInfo = new FileUploadInfo();

    @Autowired
    protected AbsmEventRepository absmEventRepository;

    @Autowired
    protected AbsmFileRepository absmFileRepository;

    public EventFileService() {}

    @Override
    public void setFileInfo(FileUploadInfo fileUploadInfo) {
        this.fileUploadInfo = fileUploadInfo;
    }

    @Override
    public int doParse() {

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

                    AbsmEvent absmEvent = new AbsmEvent();
                    absmEvent.setCaId(caId);
                    absmEvent.setPNo(Integer.valueOf(CommonUtil.removeDot(row.getCell(0).toString())));
                    absmEvent.setEvDt1(row.getCell(3).toString());
                    absmEvent.setEvDt2(row.getCell(4).toString());
                    absmEvent.setEvDt3(row.getCell(5).toString());
                    absmEvent.setEvDt4(row.getCell(6).toString());
                    absmEvent.setEvDt5(row.getCell(7).toString());
                    absmEvent.setEvDt6(row.getCell(8).toString());
                    absmEvent.setEvDt7(row.getCell(9).toString());
                    absmEvent.setEvDt8(row.getCell(10).toString());
                    absmEvent.setEvDt9(row.getCell(11).toString());
                    absmEvent.setEvDt10(row.getCell(12).toString());
                    logger.info(absmEvent.toString());

                    absmEventRepository.save(absmEvent);

                }
            }

            // File Table Insert
            AbsmFile absmFile = new AbsmFile();
            absmFile.setCaId(caId);
            /* 개인정보 또는 설문조사 파일은 개인이 아니라 case 별로 올라감 */
            absmFile.setPrId(prId);
            absmFile.setFileCd("05");
            absmFile.setFileName(fileName);
            absmFile.setFileSize(fileSize);
            absmFile.setUrl(url);

            absmFileRepository.save(absmFile);

        } catch (FileNotFoundException fe) {
            System.out.println("FileNotFoundException >> " + fe.toString());
        } catch (IOException ie) {
            System.out.println("IOException >> " + ie.toString());
        }


        return 0;
    }
}
