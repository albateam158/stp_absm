package com.stp.absm.mybatis.mapper;

import com.stp.absm.model.AbsmPrivate;

import java.util.List;
import java.util.Map;

/**
 * 개인특성자료입력 화면
 */
public interface Page001Mapper {

    List<AbsmPrivate> selectBoards(Map<String, Object> params);

    Integer selectBoardsCount(Map<String, Object> params);

    Integer selectCaseId();

    int insertSurveyAvg(Map<String, Object> params);
}
