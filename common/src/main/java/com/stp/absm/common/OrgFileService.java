package com.stp.absm.common;

import com.stp.absm.model.AbsmFile;
import com.stp.absm.model.AbsmOrg;
import com.stp.absm.repository.AbsmFileRepository;
import com.stp.absm.repository.AbsmOrgRepository;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

/**
 * Created by thomas on 2017-03-22.
 */
public class OrgFileService implements DataFileService {
    public static Logger logger = Logger.getLogger(OrgFileService.class);

    FileUploadInfo fileUploadInfo = new FileUploadInfo();

    @Autowired
    protected AbsmOrgRepository absmOrgRepository;

    @Autowired
    protected AbsmFileRepository absmFileRepository;

    public OrgFileService() {}

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

                    AbsmOrg absmOrg = new AbsmOrg();
                    absmOrg.setCaId(caId);
                    absmOrg.setPrId(prId);
                    absmOrg.setFiTm(CommonUtil.removeDot(row.getCell(0).toString()));

                    if (row.getCell(1) != null)
                        absmOrg.setMeanRri(Double.valueOf(row.getCell(1).toString()));
                    else
                        absmOrg.setMeanRri(0.0);

                    if (row.getCell(2) != null)
                        absmOrg.setStdRri(Double.valueOf(row.getCell(2).toString()));
                    else
                        absmOrg.setStdRri(0.0);

                    if (row.getCell(3) != null)
                        absmOrg.setRmssdd(Double.valueOf(row.getCell(3).toString()));
                    else
                        absmOrg.setRmssdd(0.0);

                    if (row.getCell(4) != null)
                        absmOrg.setPnn50(Double.valueOf(row.getCell(4).toString()));
                    else
                        absmOrg.setPnn50(0.0);

                    if (row.getCell(5) != null)
                        absmOrg.setMeanHrv(Double.valueOf(row.getCell(5).toString()));
                    else
                        absmOrg.setMeanHrv(0.0);

                    if (row.getCell(6) != null)
                        absmOrg.setStdHrv(Double.valueOf(row.getCell(6).toString()));
                    else
                        absmOrg.setStdHrv(0.0);

                    if (row.getCell(7) != null)
                        absmOrg.setLfhf(Double.valueOf(row.getCell(7).toString()));
                    else
                        absmOrg.setLfhf(0.0);

                    if (row.getCell(10) != null)
                        absmOrg.setScl(Double.valueOf(row.getCell(10).toString()));
                    else
                        absmOrg.setScl(0.0);

                    logger.info(absmOrg.toString());

                    absmOrgRepository.save(absmOrg);

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
