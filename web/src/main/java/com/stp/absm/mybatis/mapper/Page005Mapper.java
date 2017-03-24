package com.stp.absm.mybatis.mapper;

import com.stp.absm.model.AbsmSurvey;

import java.util.List;
import java.util.Map;

/**
 *  자료 조회 화면
 */
public interface Page005Mapper {

    List<AbsmSurvey> selectBoards(Map<String, Object> params);

    Integer selectBoardsCount(Map<String, Object> params);

    List<AbsmSurvey> selectPrivateInfo(Map<String, Object> params);

}
