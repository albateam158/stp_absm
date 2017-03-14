package com.stp.absm.common;

import com.stp.absm.model.AbsmFile;
import com.stp.absm.model.AbsmPrivate;
import com.stp.absm.repository.AbsmFileRepository;
import com.stp.absm.repository.AbsmPrivateRepository;
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
public class PrivateFileService implements DataFileService {

    public static Logger logger = Logger.getLogger(PrivateFileService.class);

    FileUploadInfo fileUploadInfo = new FileUploadInfo();

    @Autowired
    protected AbsmPrivateRepository absmPrivateRepository;

    @Autowired
    protected AbsmFileRepository absmFileRepository;

    public PrivateFileService() {}

    @Override
    public void setFileInfo(FileUploadInfo fileUploadInfo) {
        this.fileUploadInfo = fileUploadInfo;
    }

    @Override
    public int doParse() {

        // file open db insert
        String fileName = fileUploadInfo.getFileName();
        int caId        = fileUploadInfo.getCaId();
        int prId        = fileUploadInfo.getPrId();
        long fileSize   = fileUploadInfo.getFileSize();

        try {
            // 엑셀파일
            File file = new File(fileName);

            // 엑셀 파일 오픈
            XSSFWorkbook wb = new XSSFWorkbook(new FileInputStream(file));

            // 첫번재 sheet 내용 읽기
            for (Row row : wb.getSheetAt(0)) {

                if (row.getRowNum() < 1)
                    continue;

                AbsmPrivate absmPrivate = new AbsmPrivate();
                absmPrivate.setCaId(caId);
                absmPrivate.setPNo(Integer.valueOf(CommonUtil.removeDot(row.getCell(0).toString())));
                absmPrivate.setName(row.getCell(1).toString());
                absmPrivate.setAge(Integer.valueOf(CommonUtil.removeDot(row.getCell(2).toString())));
                absmPrivate.setSex(row.getCell(3).toString());
                logger.info(absmPrivate.toString());

                absmPrivateRepository.save(absmPrivate);
            }

            // File Table Insert
            AbsmFile absmFile = new AbsmFile();
            absmFile.setCaId(caId);
            /* 개인정보 또는 설문조사 파일은 개인이 아니라 case 별로 올라감 */
            absmFile.setPrId(prId);
            absmFile.setFileCd("XLS");
            absmFile.setFileName(fileName);
            absmFile.setFileSize(fileSize);
            absmFile.setUrl(fileName);

            absmFileRepository.save(absmFile);

        } catch (FileNotFoundException fe) {
            System.out.println("FileNotFoundException >> " + fe.toString());
        } catch (IOException ie) {
            System.out.println("IOException >> " + ie.toString());
        }

        return 0;
    }
}
