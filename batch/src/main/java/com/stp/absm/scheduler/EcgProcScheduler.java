package com.stp.absm.scheduler;

import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.stp.absm.model.AbsmBatch;
import com.stp.absm.model.AbsmPrivate;
import com.stp.absm.mybatis.mapper.*;
import com.stp.absm.repository.*;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

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

//    @Scheduled(cron = "0 0 6,12,18 * * *")
    @Scheduled(fixedDelay=60000)
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



                //정상이면
                absmBatch.setStatus("2");
                absmBatchRepository.save(absmBatch);
            }catch (Exception e){
                //에러이면
                absmBatch.setStatus("3");
                absmBatchRepository.save(absmBatch);
            }finally {
                log.info("ecgDBBulk Result =====>>" + absmBatch.getStatus());

            }


        }


        log.info("ecgDBBulk finish =====>>");
    }


}
