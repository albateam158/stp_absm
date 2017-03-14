package com.stp.absm.common;

import com.stp.absm.model.AbsmFile;
import com.stp.absm.model.AbsmModel;
import com.stp.absm.repository.AbsmFileRepository;
import com.stp.absm.repository.AbsmModelRepository;
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
public class ModelFileService implements DataFileService {

    public static Logger logger = Logger.getLogger(ModelFileService.class);

    FileUploadInfo fileUploadInfo = new FileUploadInfo();

    @Autowired
    protected AbsmModelRepository absmModelRepository;

    @Autowired
    protected AbsmFileRepository absmFileRepository;

    public ModelFileService() {}

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

            for (Row row : wb.getSheetAt(0)) {

                if (row.getRowNum() < 1)
                    continue;

                if (row.getCell(0) != null) {

                    AbsmModel absmModel = new AbsmModel();
                    absmModel.setCaId(caId);
                    absmModel.setPrId(prId);
                    absmModel.setSeCd(2);

                    absmModel.setMeanRri(Double.valueOf(row.getCell(2).toString()));
                    absmModel.setStdRri(Double.valueOf(row.getCell(3).toString()));
                    absmModel.setMeanHrv(Double.valueOf(row.getCell(4).toString()));
                    absmModel.setStdHrv(Double.valueOf(row.getCell(5).toString()));
                    absmModel.setRmssdd(Double.valueOf(row.getCell(6).toString()));
                    absmModel.setPnn50(Double.valueOf(row.getCell(7).toString()));
                    absmModel.setLfhf(Double.valueOf(row.getCell(8).toString()));
                    absmModel.setScl(Double.valueOf(row.getCell(9).toString()));

                    absmModel.setSurAvg(Double.valueOf(row.getCell(10).toString()));
                    absmModel.setMoPre1(Double.valueOf(row.getCell(11).toString()));
                    absmModel.setMoPre2(Double.valueOf(row.getCell(12).toString()));
                    absmModel.setMoPre3(Double.valueOf(row.getCell(13).toString()));
                    absmModel.setMoPre4(Double.valueOf(row.getCell(14).toString()));
                    absmModel.setStLevel(Integer.valueOf(row.getCell(15).toString()));

                    logger.info(absmModel.toString());

                    absmModelRepository.save(absmModel);

                }
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
