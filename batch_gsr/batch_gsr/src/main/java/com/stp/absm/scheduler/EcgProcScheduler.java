package com.stp.absm.scheduler;

import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.stp.absm.model.AbsmPrivate;
import com.stp.absm.mybatis.mapper.*;
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
    @Scheduled(fixedDelay=1000)
    public void ecgDBBulk() throws ParseException {

        log.info("setSuccessState start =====>>");

        Map<String, Object> params = new HashMap<String, Object>();
        params.put("caId",64);

        List<AbsmPrivate> LPris = page006Mapper.selectPrivates(params);
        for(AbsmPrivate absmPrivate: LPris){
            log.info("LPris : "+absmPrivate.getName());
        }


        log.info("setSuccessState finish =====>>");
    }


}
