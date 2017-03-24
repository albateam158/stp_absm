package com.stp.absm.controller;

import com.google.gson.Gson;
import com.stp.absm.common.AES;
import com.stp.absm.common.DurationFromNow;
import com.stp.absm.config.Settings;
import com.stp.absm.mybatis.mapper.*;
import com.stp.absm.repository.*;
import com.stp.absm.common.PagingUtil;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.Resource;
import javax.persistence.EntityManager;

/**
 * Created by sj on 15. 11. 11..
 */
abstract public class RootController {



    @Autowired
    protected EntityManager entityManager;

    @Autowired
    protected Gson gson;

    @Autowired
    protected AES aes;

    @Autowired
    protected DurationFromNow durationFromNow;


    protected PagingUtil pagingUtil = new PagingUtil();

    /////////////////////////////////////////////////////////////////////////
    ////////////////////////////////  absm  /////////////////////////////////
    /////////////////////////////////////////////////////////////////////////
    @Autowired
    protected Settings settings;

    @Autowired
    protected  AbsmCaseRepository absmCaseRepository;

    @Autowired
    protected  AbsmCodeRepository absmCodeRepository;

    @Autowired
    protected  AbsmEventRepository absmEventRepository;

    @Autowired
    protected  AbsmFileRepository absmFileRepository;

    @Autowired
    protected  AbsmOrgRepository absmOrgRepository;

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

    /**
     * Mapper
     */

    //absm mapper

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
}
