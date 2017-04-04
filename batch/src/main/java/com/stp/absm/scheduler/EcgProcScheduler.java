package com.stp.absm.scheduler;

import com.stp.absm.model.AbsmBatch;
import com.stp.absm.mybatis.mapper.*;
import com.stp.absm.repository.*;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

/**
 * Created by sj on 16. 3. 16..
 */
@Component
public class EcgProcScheduler {
    private final org.slf4j.Logger log = LoggerFactory.getLogger(EcgProcScheduler.class);

    @Autowired
    protected AbsmCaseRepository absmCaseRepository;

    @Autowired
    protected AbsmCodeRepository absmCodeRepository;

    @Autowired
    protected AbsmEventRepository absmEventRepository;

    @Autowired
    protected AbsmFileRepository absmFileRepository;

    @Autowired
    protected AbsmOrgRepository absmOrgRepository;

    @Autowired
    protected  AbsmFilterRepository absmFilterRepository;

    @Autowired
    protected  AbsmMeasureRepository absmMeasureRepository;

    @Autowired
    protected  AbsmModelRepository absmModelRepository;

    @Autowired
    protected  AbsmPrivateRepository absmPrivateRepository;

    @Autowired
    protected  AbsmSurveyRepository absmSurveyRepository;

    @Autowired
    protected AbsmSurveyAvgRepository absmSurveyAvgRepository;

    @Autowired
    protected AbsmBatchRepository absmBatchRepository;

    @Autowired
    protected Page001Mapper page001Mapper;

    @Autowired
    protected Page002Mapper page002Mapper;

    @Autowired
    protected Page003Mapper page003Mapper;

    @Autowired
    protected Page004Mapper page004Mapper;

    @Autowired
    protected Page005Mapper page005Mapper;

    @Autowired
    protected Page006Mapper page006Mapper;

    @Value("${develop}")
    boolean develop;

    @Value(value = "${spring.datasource.url}")
    private String url;

    @Value(value = "${spring.datasource.username}")
    private String username;

    @Value(value = "${spring.datasource.password}")
    private String password;


//    @Scheduled(cron = "0 0 6,12,18 * * *")
    // 80분 마다 실행
    @Scheduled(fixedDelay=1000*60*80)
    public void ecgDBBulk() throws ParseException {

        log.info("ecgDBBulk start =====>>");

        /* status "0" 미처리 , fileCd "03" ECG
         * 미처리건 조회후 "1" 처리중으로 변환후 정상처리시 "2"처리완료, 오류면 "3"처리오류
         */

        List<AbsmBatch> lBat = absmBatchRepository.findByStatusAndFileCdOrderByPrIdAsc("0", "03");
        for(AbsmBatch absmBatch: lBat){
            log.info("ecgDBBulk Cnt =====>>" + lBat.size());
            //처리중으로 바꿈
            absmBatch.setStatus("1");
            absmBatchRepository.save(absmBatch);

            //파일벌크인서트처리
            try{

                String sql = "Insert Into absm_measure(ca_id, pr_id, eg_cd, me_tm, me_val, reg_date, update_date) Values(?, ?, ?, ?, ?, now(), now())";
                writeBulkData(absmBatch.getCaId(), absmBatch.getPrId(), "E", sql, absmBatch.getFileName());
                //정상이면
                absmBatch.setStatus("2");
            }
            catch (Exception e) {
                //에러이면
                absmBatch.setStatus("3");
            }
            finally {
                absmBatchRepository.save(absmBatch);
                log.info("ecgDBBulk Result =====>>" + absmBatch.getStatus());
            }
        }

        log.info("ecgDBBulk finish =====>>");
    }

    // 20분 마다 실행
    @Scheduled(fixedDelay=1000*60*20)
    public void gsrDBBulk() throws ParseException {

        log.info("gsrDBBulk start =====>>");

        /* status "0" 미처리 , fileCd "03" ECG
         * 미처리건 조회후 "1" 처리중으로 변환후 정상처리시 "2"처리완료, 오류면 "3"처리오류
         */

        List<AbsmBatch> lBat = absmBatchRepository.findByStatusAndFileCdOrderByPrIdAsc("0", "04");
        for(AbsmBatch absmBatch: lBat){
            log.info("gsrDBBulk Cnt =====>>" + lBat.size());
            //처리중으로 바꿈
            absmBatch.setStatus("1");
            absmBatchRepository.save(absmBatch);

            //파일벌크인서트처리
            try{

                String sql = "Insert Into absm_measure(ca_id, pr_id, eg_cd, me_tm, me_val, reg_date, update_date) Values(?, ?, ?, ?, ?, now(), now())";
                writeBulkData(absmBatch.getCaId(), absmBatch.getPrId(), "G", sql, absmBatch.getFileName());
                //정상이면
                absmBatch.setStatus("2");
            }
            catch (Exception e) {
                //에러이면
                absmBatch.setStatus("3");
            }
            finally {
                absmBatchRepository.save(absmBatch);
                log.info("gsrDBBulk Result =====>>" + absmBatch.getStatus());
            }
        }

        log.info("gsrDBBulk finish =====>>");
    }

    private void writeBulkData (int caId, int prId, String fileCd, String sql, String fileName) throws Exception {

        Connection con = null;
        PreparedStatement pstmt = null;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url, username, password);

        if (con == null) {
            throw new Exception("Connection Fail");
        }

        BufferedReader br = new BufferedReader(new FileReader(fileName));

        if (br == null) {
            throw new Exception("File Open Fail");
        }

        String strLine;
        int lineCount = 0;
        pstmt = con.prepareStatement(sql);

        if (pstmt == null) {
            throw new Exception("PrepareStatement Create Fail");
        }

        try {

            if ("E".equals(fileCd)) {
                br.readLine();
                br.readLine();
                br.readLine();

                while ((strLine = br.readLine()) != null) {

                    String[] dataArray = strLine.split("\t");

                    pstmt.setInt(1, caId);
                    pstmt.setInt(2, prId);
                    pstmt.setString(3, fileCd);
                    pstmt.setString(4, dataArray[0]);
                    pstmt.setString(5, dataArray[3]);

                    // addBatch에 담기
                    pstmt.addBatch();
                    // 파라미터 Clear
                    pstmt.clearParameters();

                    // OutOfMemory를 고려하여 만건 단위로 커밋
                    if ((lineCount % 10000) == 0) {

                        // Batch 실행
                        pstmt.executeBatch();

                        // Batch 초기화
                        pstmt.clearBatch();
                    }
                    lineCount++;
                }

                // 커밋되지 못한 나머지 구문에 대하여 실행
                pstmt.executeBatch();

            } else if ("G".equals(fileCd)) {

                br.readLine();
                br.readLine();

                while ((strLine = br.readLine()) != null) {

                    String[] dataArray = strLine.split(",");

                    pstmt.setInt(1, caId);
                    pstmt.setInt(2, prId);
                    pstmt.setString(3, fileCd);
                    pstmt.setString(4, dataArray[0]);
                    pstmt.setString(5, dataArray[1]);

                    // addBatch에 담기
                    pstmt.addBatch();
                    // 파라미터 Clear
                    pstmt.clearParameters();

                    // OutOfMemory를 고려하여 만건 단위로 커밋
                    if ((lineCount % 10000) == 0) {

                        // Batch 실행
                        pstmt.executeBatch();

                        // Batch 초기화
                        pstmt.clearBatch();
                    }
                    lineCount++;
                }

                // 커밋되지 못한 나머지 구문에 대하여 실행
                pstmt.executeBatch();

            }
        }
        catch (Exception e) {
            con.rollback();
            throw e;
        }
        finally {
            if (pstmt != null) try {pstmt.close();pstmt = null;} catch(SQLException ex){}
            if (con != null) try {con.close();con = null;} catch(SQLException ex){}
        }

    }
}
