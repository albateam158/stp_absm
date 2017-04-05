package com.stp.absm.common;

import com.stp.absm.model.AbsmFile;
import com.stp.absm.model.AbsmFilter;
import com.stp.absm.model.AbsmPrivate;
import com.stp.absm.repository.AbsmFileRepository;
import com.stp.absm.repository.AbsmFilterRepository;
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
import java.util.Date;

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

    @Autowired
    protected AbsmPrivateRepository absmPrivateRepository;

    public FilterFileService() {}

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
        //int prId        = fileUploadInfo.getPrId();
        long fileSize   = fileUploadInfo.getFileSize();

        try {
            // 엑셀파일
            File file = new File(fileName);

            // 엑셀 파일 오픈
            XSSFWorkbook wb = new XSSFWorkbook(new FileInputStream(file));


            for (Row row : wb.getSheetAt(0)) {

                if (row.getRowNum() < 2)
                    continue;

                if (row.getCell(1) != null) {

                    /*
                    pr_id는 기존 생체정보 화면이 아니라 케이스별 등록 화면으로 이동했기 때문에
                    Bnri Sheet의 이름 정보에서 추출한 참가번호로 대체함
                     */
                    String[] rowDatas = row.getCell(1).toString().split("_");
//                    String prId = rowDatas[0].substring(1,rowDatas[0].length());
                    AbsmPrivate absmPrivate = absmPrivateRepository.findByCaIdAndPNo(caId, Integer.valueOf(CommonUtil.removeDot(row.getCell(0).toString())));

                    logger.info("Pr_id : " + absmPrivate.getPrId());

                    int startIdx = 2;
                    int offset = 11;
                    int idx = 0;
                    int seCdIdx = 2;

                    for (int i = 0; i < 11; i++) {

                        /* 스킵구간 판교역개찰구,강남역개찰구,대기지점 */
                        if(startIdx == 3 || startIdx == 7 || startIdx == 12){
                            startIdx++;
                            continue;
                        }else{

                            AbsmFilter absmFilter = new AbsmFilter();
                            absmFilter.setCaId(caId);

                            absmFilter.setPrId(absmPrivate.getPrId());
                            absmFilter.setValCd("1");

                            /* 구간코드 생성 판교역개찰구,강남역개찰구,대기지점은  seCd null로함 i=1,5,10*/
                            if ( i == 1 || i == 5 || i == 10) {
                                continue;
                            }
                            else {
                                absmFilter.setSeCd(String.valueOf(seCdIdx));
                                seCdIdx++;
                            }

                            absmFilter.setMeanRri(Double.valueOf(row.getCell(startIdx+(offset*idx)).toString()));

                            idx++;
                            absmFilter.setStdRri(Double.valueOf(row.getCell(startIdx+(offset*idx)).toString()));

                            idx++;
                            absmFilter.setMeanHrv(Double.valueOf(row.getCell(startIdx+(offset*idx)).toString()));

                            idx++;
                            absmFilter.setStdHrv(Double.valueOf(row.getCell(startIdx+(offset*idx)).toString()));

                            idx++;
                            absmFilter.setRmssdd(Double.valueOf(row.getCell(startIdx+(offset*idx)).toString()));

                            idx++;
                            absmFilter.setPnn50(Double.valueOf(row.getCell(startIdx+(offset*idx)).toString()));

                            idx++;
                            absmFilter.setLfhf(Double.valueOf(row.getCell(startIdx+(offset*idx)).toString()));

                            idx++;
                            absmFilter.setScl(Double.valueOf(row.getCell(startIdx+(offset*idx)).toString()));

                            //absmFilter.setSurAvg(Double.valueOf(row.getCell(10).toString()));
                            absmFilter.setRegDate(now);
                            logger.info(absmFilter.toString());


                            absmFilterRepository.save(absmFilter);
                            startIdx++;
                        }


                        idx = 0;
                    }

                }
            }

            // File Table Insert
            AbsmFile absmFile = new AbsmFile();
            absmFile.setCaId(caId);
            /* 개인정보 또는 설문조사 파일은 개인이 아니라 case 별로 올라감 */
            absmFile.setPrId(0);
            absmFile.setFileCd("06");
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
