package com.stp.absm.mybatis.mapper;

import java.util.List;
import java.util.Map;

import com.stp.absm.model.AbsmMeasure;
import com.stp.absm.model.KamsBoardContent;
import com.stp.absm.repository.support.Master;

/**
 * 실험대상자 측정자료입력 화면
 */
@Master
public interface Page002Mapper {

    List<AbsmMeasure> selectBoards(Map<String, Object> params);

    Integer selectBoardsCount(Map<String, Object> params);

}