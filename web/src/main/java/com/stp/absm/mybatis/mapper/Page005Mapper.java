package com.stp.absm.mybatis.mapper;

import java.util.List;
import java.util.Map;

import com.stp.absm.model.AbsmFile;
import com.stp.absm.model.AbsmSurvey;
import com.stp.absm.repository.support.Master;

/**
 *  자료 조회 화면
 */
@Master
public interface Page005Mapper {

    List<AbsmSurvey> selectBoards(Map<String, Object> params);

    Integer selectBoardsCount(Map<String, Object> params);

}
