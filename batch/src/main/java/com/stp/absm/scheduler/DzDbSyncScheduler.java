package com.stp.absm.scheduler;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import com.stp.absm.mybatis.mapper.*;
import com.stp.absm.repository.*;
import com.stp.absm.type.SuccessState;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.stp.absm.common.PagingUtil;

/**
 * Created by sj on 16. 3. 16..
 */
@Component
public class DzDbSyncScheduler {
    private final org.slf4j.Logger log = LoggerFactory.getLogger(DzDbSyncScheduler.class);


    @Autowired
    protected XCategoryRepository xCategoryRepository;

    @Autowired
    protected XCodeRepository xCodeRepository;

    @Autowired
    protected XFileRepository xFileRepository;

    @Autowired
    protected XAdminRepository xAdminRepository;

    @Autowired
    protected XUserRepository xUserRepository;

    @Autowired
    protected XNoticeRepository xNoticeRepository;

    @Autowired
    protected XNoticeCommentRepository xNoticeCommentRepository;

    @Resource
    protected KAccCodeRepository kAccCodeRepository;

    @Resource
    protected KProdCodeRepository kProdCodeRepository;

    @Autowired
    protected KPlListRepository kPlListRepository;

    @Autowired
    protected KPreplListRepository kPreplListRepository;

    protected PagingUtil pagingUtil = new PagingUtil();


    /**
     * Mapper
     */
    @Autowired
    protected KamsCategoryMapper xCategoryMapper;

    @Autowired
    protected KamsNoticeMapper xNoticeMapper;

    @Autowired
    protected XUserMapper xUserMapper;

    @Autowired
    protected DzEmpMapper dzEmpMapper;

    @Autowired
    protected KamsRecordMapper kamsRecordMapper;

    @Value("${develop}")
    boolean develop;

    @Scheduled(cron = "0 0 6,12,18 * * *")
    //@Scheduled(fixedDelay=1000)
    public void dzDBSync() throws ParseException {

        if( develop == false) {

            log.info("setSuccessState start =====>>");

            List<XProject> projects = xProjectRepository.findByDeleteDateIsNull();

            for (XProject project : projects) {
                SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
                Date sbscStDt = transFormat.parse(project.getSbscStDt());
                Date today = new Date();

                if (project.getSuccessState().equals(SuccessState.READY)) {
                    if (today.compareTo(sbscStDt) >= 0) {
                        project.setSuccessState(SuccessState.ING);

                        xProjectRepository.save(project);
                    }
                }
            }

            log.info("setSuccessState finish =====>>");
        }
    }



    @Scheduled(cron = "0 0 17 * * *")
    //@Scheduled(fixedDelay=1000)
    public void setFinishSuccessState() throws ParseException {

        if( develop == false) {

            log.info("setSuccessState start =====>>");

            List<XProject> projects = xProjectRepository.findByDeleteDateIsNull();

            for (XProject project : projects) {
                SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
                Date today = new Date();
                String todayString = transFormat.format(today);

                if (project.getSuccessState().equals(SuccessState.ING)) {

                    if(todayString.equals(project.getSbscNdDt())) {
                        project.setSuccessState(SuccessState.FINISH);

                        xProjectRepository.save(project);
                    }
                }
            }

            log.info("setSuccessState finish =====>>");
        }
    }
}
