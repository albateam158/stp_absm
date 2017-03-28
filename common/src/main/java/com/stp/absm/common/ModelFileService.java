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
import java.util.Date;

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

            /* section code */
            int seCd = 2;
            for (Row row : wb.getSheetAt(0)) {

                if (row.getRowNum() < 1)
                    continue;

                if (row.getCell(1) != null) {

                    AbsmModel absmModel = new AbsmModel();
                    absmModel.setCaId(caId);
                    absmModel.setPrId(prId);
//                    absmModel.setSeCd(seCd);

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
                    absmModel.setStLevel(Integer.valueOf(CommonUtil.removeDot(row.getCell(15).toString())));
                    absmModel.setRegDate(now);
                    logger.info(absmModel.toString());

                    absmModelRepository.save(absmModel);
                    seCd++;

                }
            }

            // File Table Insert
            AbsmFile absmFile = new AbsmFile();
            absmFile.setCaId(caId);
            absmFile.setPrId(prId);
            absmFile.setFileCd("07");
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
