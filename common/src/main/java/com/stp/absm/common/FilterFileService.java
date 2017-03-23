package com.stp.absm.common;

import com.stp.absm.model.AbsmFile;
import com.stp.absm.model.AbsmFilter;
import com.stp.absm.repository.AbsmFileRepository;
import com.stp.absm.repository.AbsmFilterRepository;
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
public class FilterFileService implements DataFileService{

    public static Logger logger = Logger.getLogger(FilterFileService.class);

    FileUploadInfo fileUploadInfo = new FileUploadInfo();

    @Autowired
    protected AbsmFilterRepository absmFilterRepository;

    @Autowired
    protected AbsmFileRepository absmFileRepository;

    public FilterFileService() {}

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

            /*for (Row row : wb.getSheetAt(0)) {

                if (row.getRowNum() < 1)
                    continue;

                if (row.getCell(0) != null) {

                    AbsmFilter absmFilter = new AbsmFilter();
                    absmFilter.setCaId(caId);
                    absmFilter.setPrId(prId);
                    absmFilter.setValCd("1");

                    //absmFilter.setFiTm(CommonUtil.removeDot(row.getCell(0).toString()));

                    if (row.getCell(1) != null)
                        absmFilter.setMeanRri(Double.valueOf(row.getCell(1).toString()));
                    else
                        absmFilter.setMeanRri(0.0);

                    if (row.getCell(2) != null)
                        absmFilter.setStdRri(Double.valueOf(row.getCell(2).toString()));
                    else
                        absmFilter.setStdRri(0.0);

                    if (row.getCell(3) != null)
                        absmFilter.setRmssdd(Double.valueOf(row.getCell(3).toString()));
                    else
                        absmFilter.setRmssdd(0.0);

                    if (row.getCell(4) != null)
                        absmFilter.setPnn50(Double.valueOf(row.getCell(4).toString()));
                    else
                        absmFilter.setPnn50(0.0);

                    if (row.getCell(5) != null)
                        absmFilter.setMeanHrv(Double.valueOf(row.getCell(5).toString()));
                    else
                        absmFilter.setMeanHrv(0.0);

                    if (row.getCell(6) != null)
                        absmFilter.setStdHrv(Double.valueOf(row.getCell(6).toString()));
                    else
                        absmFilter.setStdHrv(0.0);

                    if (row.getCell(7) != null)
                        absmFilter.setLfhf(Double.valueOf(row.getCell(7).toString()));
                    else
                        absmFilter.setLfhf(0.0);

                    if (row.getCell(10) != null)
                        absmFilter.setScl(Double.valueOf(row.getCell(10).toString()));
                    else
                        absmFilter.setScl(0.0);

                    logger.info(absmFilter.toString());

                    absmFilterRepository.save(absmFilter);

                }
            }*/

            /* section code */
            int seCd = 2;
            for (Row row : wb.getSheetAt(0)) {

                if (row.getRowNum() < 1)
                    continue;

                if (row.getCell(1) != null) {

                    AbsmFilter absmFilter = new AbsmFilter();
                    absmFilter.setCaId(caId);
                    absmFilter.setPrId(prId);
                    absmFilter.setValCd("1");
                    absmFilter.setSeCd(String.valueOf(seCd));

                    absmFilter.setMeanRri(Double.valueOf(row.getCell(2).toString()));
                    absmFilter.setStdRri(Double.valueOf(row.getCell(3).toString()));
                    absmFilter.setMeanHrv(Double.valueOf(row.getCell(4).toString()));
                    absmFilter.setStdHrv(Double.valueOf(row.getCell(5).toString()));
                    absmFilter.setRmssdd(Double.valueOf(row.getCell(6).toString()));
                    absmFilter.setPnn50(Double.valueOf(row.getCell(7).toString()));
                    absmFilter.setLfhf(Double.valueOf(row.getCell(8).toString()));
                    absmFilter.setScl(Double.valueOf(row.getCell(9).toString()));

                    absmFilter.setSurAvg(Double.valueOf(row.getCell(10).toString()));
                    //absmFilter.setMoPre1(Double.valueOf(row.getCell(11).toString()));
                    //absmFilter.setMoPre2(Double.valueOf(row.getCell(12).toString()));
                    //absmFilter.setMoPre3(Double.valueOf(row.getCell(13).toString()));
                    //absmFilter.setMoPre4(Double.valueOf(row.getCell(14).toString()));
                    //absmFilter.setStLevel(Integer.valueOf(CommonUtil.removeDot(row.getCell(15).toString())));

                    logger.info(absmFilter.toString());

                    absmFilterRepository.save(absmFilter);
                    seCd++;

                }
            }

            // File Table Insert
            AbsmFile absmFile = new AbsmFile();
            absmFile.setCaId(caId);
            /* 개인정보 또는 설문조사 파일은 개인이 아니라 case 별로 올라감 */
            absmFile.setPrId(prId);
            absmFile.setFileCd("06");
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
