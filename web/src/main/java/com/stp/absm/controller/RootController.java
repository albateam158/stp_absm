package com.stp.absm.controller;

import com.google.gson.Gson;
import com.stp.absm.common.AES;
import com.stp.absm.common.FileService;
import com.stp.absm.mybatis.mapper.*;
import com.stp.absm.repository.*;
import com.stp.absm.common.PagingUtil;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.Resource;
import javax.persistence.EntityManager;

/**
 * Created by sj on 15. 11. 11..
 */
public class RootController {



    @Autowired
    protected EntityManager entityManager;

    @Autowired
    protected Gson gson;

    @Autowired
    protected AES aes;


    @Autowired
    protected FileService fileService;


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

    @Autowired
    protected ZaDeptRepository zaDeptDaikinRepository;

    @Autowired
    protected ZaEmpRepository zaEmpDaikinRepository;


    @Autowired
    protected  KInRuleRepository kInRuleRepository;

    @Autowired
    protected  KInRuleFileRepository kInRuleFileRepository;

    @Autowired
    protected  KBoardCommentsRepository kBoardCommentsRepository;

    @Autowired
    protected  KBoardContentRepository kBoardContentRepository;

    @Autowired
    protected  KBoardAttachedRepository kBoardAttachedRepository;

    @Autowired
    protected  KBoardSettingRepository kBoardSettingRepository;



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

    @Autowired
    protected KamsInterRuleMapper kamsInterRuleMapper;

    @Autowired
    protected KamsBoardMapper kamsBoardMapper;


}
